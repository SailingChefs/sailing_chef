import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class AddRecipeViewModel extends BaseViewModel {
  PageController pageController = PageController(viewportFraction: 1.0);
  late final RecorderController recorderController;
  late final PlayerController playerController;
  late VideoPlayerController controller;
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  late Directory directory;
  late String path;
  String selectedValue = 'Public';
  int selectedQuantity = 1;
  List<XFile> selectedImages = [];
  List<XFile> thumbnails = [];
  TextEditingController titleController = TextEditingController();
  final _recipeService = locator<RecipeService>();
  int count = 0;
  final TextEditingController prepTimeController = TextEditingController();
  List<String> values = ['Public', 'Private'];
  List<String> quantity = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List<String> timeMethod = ['secs', 'mins', 'hrs'];
  String selectedTimeMethod = 'secs';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Ingredient> ingredientsList = [];
  List<String> methodsList = [];

  bool isPlaying = false;

  bool isclicked = false;


  List<double>? waveFormData;

  bool get isRecording => recorderController.isRecording;

  bool get shouldShowHint {
    return !hasRecordedAudio && !isRecording;
  }

  bool hasRecordedAudio = false;

  void onTimeMethodSelection(String value) {
    selectedTimeMethod = value;
    notifyListeners();
    rebuildUi();
  }

  String? validatePrepTime(String? value) {
    if (value!.isEmpty) {
      return 'Please enter some time';
    }
    return null;
  }

  String? validateTitle(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    return value.length >= 3
        ? null
        : 'Title must be at least 3 characters long';
  }

  void onViewModelReady() async {
    setBusy(true);
    _initialiseController();
    // recorderController = RecorderController();
    playerController = PlayerController();
    directory = await getApplicationDocumentsDirectory();

    path = '${directory.path}/recording.mpeg4';
    setBusy(false);
  }

  void _initialiseController() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4;
  }

  void startRecording() async {
    await recorderController.record(
      path: path,
      androidOutputFormat: AndroidOutputFormat.mpeg4,
    );
    rebuildUi();
  }

  void stopRecording() async {
    await recorderController.stop();
    log("Path=> $path");
    waveFormData = await playerController.extractWaveformData(path: path);
    hasRecordedAudio = true;
    rebuildUi();
    await playerController.preparePlayer(
      path: path,
      volume: 100,
    );
    rebuildUi();
  }

  void startListening() async {
    await playerController.startPlayer(finishMode: FinishMode.pause);
  }

  void deleteCurrentRecording() {
    hasRecordedAudio = false;
    recorderController.reset();
    playerController.release();

    rebuildUi();
  }

  void deleteCurrentImage() {
    selectedImages.removeAt(pageController.page!.round());
    notifyListeners();
    rebuildUi();
  }

  void showPreviousImage() {
    if (pageController.page! > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  // Function to handle swipe to the left (show next image)
  void showNextImage() {
    if (pageController.page! < selectedImages.length - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  Future<void> pickImages() async {
    List<XFile>? images = await ImagePicker()
        .pickMultipleMedia(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);

    if (images.isNotEmpty) {
      for (var image in images) {
        if (File(image.path).isImage) {
          selectedImages.add(image);
          
        } else if (File(image.path).isVideo) {
          controller = VideoPlayerController.file(images
              .where((element) => File(element.path).isVideo)
              .first
              .toFile);
          controller.play();
          // final thumbnailss = await VideoThumbnail.thumbnailFile(
          //   video: image.path,
          //   thumbnailPath: (await getTemporaryDirectory()).path,
          //   imageFormat: ImageFormat.PNG,
          //   maxHeight: 50,
          //   quality: 100,
          // );
          selectedImages.add(XFile(image.path));
          
        }
      }

      notifyListeners();
      rebuildUi();
    }
  }

  void showDraftDialog() {
    _dialogService
        .showCustomDialog(variant: DialogType.saveDraftAlertbox, data: {
      'model': RecipeModel(
        visibility: selectedValue,
        chefNote: 'recorderController',
        coverImage: [],
        createdTime: Timestamp.now(),
        ingredients: ingredientsList,
        methods: ['methods'],
        prepTime:
            mergeStrings(prepTimeController.text.trim(), selectedTimeMethod),
        servingSize: selectedQuantity,
        status: 'draft',
        title: titleController.text.trim(),
        uid: firebaseAuth.currentUser!.uid,
        docId: '',
        waveForm: waveFormData!,
      ),
      'images': selectedImages,
    });
  }

  void callIngredientsBottomSheet() async {
    final result = await _bottomSheetService
        .showCustomSheet<dynamic, AddIngredientsSheetResponse>(
      variant: BottomSheetType.addIngredients,
    );
    if (result == null) return;
    ingredientsList = result.data.ingredientsList;
    rebuildUi();
    notifyListeners();
  }

  void popBack() {
    _navigationService.back();
  }

  void callCookingInstructionBottomSheet() async {
    final method = await _bottomSheetService
        .showCustomSheet<dynamic, CookingInstructionsSheetResponse>(
      variant: BottomSheetType.cookingInstructions,
    );
    log(method.runtimeType.toString());

    if (method == null) return;
    methodsList = method.data.instructionsListResponse.toList();
    rebuildUi();
    notifyListeners();
  }

  void updateQuantity(int value) {
    selectedQuantity = value;
    notifyListeners();
    rebuildUi();
  }

  void updateValue(String value) {
    selectedValue = value;
    notifyListeners();
    rebuildUi();
  }

  void increment() {
    count++;
    notifyListeners();
    rebuildUi();
  }

  void decrement() {
    if (count > 0) {
      count--;
      notifyListeners();
      rebuildUi();
    }
  }

  String mergeStrings(String time, String method) {
    return '$time $method';
  }

  void saveRecipe() async {
    if (titleController.text.trim().isNotEmpty &&
        prepTimeController.text.trim().isNotEmpty &&
        methodsList.isNotEmpty &&
        ingredientsList.isNotEmpty &&
        hasRecordedAudio) {
      if (selectedImages.isEmpty) {
        showToast(message: 'Please add at least one image');
        return;
      } else {
        List<String> imageUrls =
            await _recipeService.uploadMediaToFirebase(selectedImages,
            FirebaseFirestore.instance.collection('recipes').doc().id);

        await _recipeService.addRecipeToFirestore(RecipeModel(
          visibility: selectedValue,
          chefNote: 'recorderController',
          coverImage: imageUrls,
          createdTime: Timestamp.now(),
          ingredients: ingredientsList,
          methods: methodsList,
          waveForm: waveFormData!,
          prepTime:
              mergeStrings(prepTimeController.text.trim(), selectedTimeMethod),
          servingSize: selectedQuantity,
          status: 'published',
          title: titleController.text.trim(),
          uid: firebaseAuth.currentUser!.uid, docId: '',
        ));

        _navigationService.navigateToRecipeViewView(
            recipeModel: RecipeModel(
              visibility: selectedValue,
              chefNote: 'recorderController',
              coverImage: [],
              createdTime: Timestamp.now(),
              ingredients: ingredientsList,
              methods: methodsList,
              prepTime: mergeStrings(
                  prepTimeController.text.trim(), selectedTimeMethod),
              servingSize: selectedQuantity,
              status: 'published',
              title: titleController.text.trim(),
              uid: firebaseAuth.currentUser!.uid,
              docId: '',
              waveForm: waveFormData!,
            ),
            selectedImages: selectedImages,
            path: path,
            waveFormData: waveFormData);
      }
    } else {
      showToast(message: 'Please fill all fields');
    }
  }

  void deleteMethod(int index) {
    methodsList.removeAt(index);
    rebuildUi();
    notifyListeners();
  }

  void deleteIngredient(int index) {
    ingredientsList.removeAt(index);
    rebuildUi();
  }

  void draftRecipe() async {
    if (titleController.text.trim().isNotEmpty) {
      List<String> imageUrls;

      imageUrls = selectedImages.isNotEmpty
          ? await _recipeService.uploadMediaToFirebase(selectedImages,FirebaseFirestore.instance.collection('recipes').doc().id)
          : [];

      await _recipeService.addRecipeToFirestore(RecipeModel(
        visibility: selectedValue,
        chefNote: 'recorderController',
        coverImage: imageUrls.isNotEmpty ? imageUrls : [],
        createdTime: Timestamp.now(),
        ingredients: ingredientsList,
        methods: ['methods'],
        prepTime:
            mergeStrings(prepTimeController.text.trim(), selectedTimeMethod),
        servingSize: selectedQuantity,
        status: 'draft',
        title: titleController.text.trim(),
        uid: firebaseAuth.currentUser!.uid,

        docId: '',
        waveForm: waveFormData!,

      ));
    }
  }

  // void goToRecipePreview() {
  //   _navigationService.navigateToRecipeViewView();
  // }

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    titleController.dispose();
    prepTimeController.dispose();
    selectedImages = [];
    ingredientsList = [];
    methodsList = [];
    selectedTimeMethod = '';
    selectedQuantity = 0;
    selectedValue = 'public';
    count = 0;
    path = '';
    waveFormData = [];
    super.dispose();
  }

  void deleteInstruction(int index) {}

  void updateVideoSource(File value) {
    if (value.isVideo) {
      controller = VideoPlayerController.file(value);
      isclicked == false ? controller.pause() : controller.play();
      notifyListeners();
    } else {}
  }

  navigateToRecipeViewView() async{
          List<String> imageUrls;

      imageUrls = selectedImages.isNotEmpty
          ? await _recipeService.uploadMediaToFirebase(selectedImages,FirebaseFirestore.instance.collection('recipes').doc().id)
          : [];

    _navigationService.navigateToRecipeViewView(recipeModel: RecipeModel(
        visibility: selectedValue,
        chefNote: 'recorderController',
        coverImage: imageUrls,
        createdTime: Timestamp.now(),
        ingredients: ingredientsList,
        methods: methodsList,
        waveForm: waveFormData!,
        prepTime:
            mergeStrings(prepTimeController.text.trim(), selectedTimeMethod),
        servingSize: selectedQuantity,
        status: 'draft',
        title: titleController.text.trim(),
        uid: firebaseAuth.currentUser!.uid,
        docId: '',
      ),
      selectedImages: selectedImages);
  }
}
