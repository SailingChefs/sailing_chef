import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_cropper/image_cropper.dart';
// import 'package:croppy/croppy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;

class AddRecipeViewModel extends BaseViewModel {
  final RecipeModel? recipeModel;
  AddRecipeViewModel({this.recipeModel});
  PageController pageController = PageController(viewportFraction: 1.0);
  late final RecorderController recorderController;
  late final PlayerController playerController;
  late VideoPlayerController controller;
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _recipeService = locator<RecipeService>();
  final _userSerice = locator<UserdataServiceService>();
  late Directory directory;
  late String path;
  String selectedValue = 'Public';
  int selectedQuantity = 1;
  List<XFile> selectedImages = [];
  List<XFile> thumbnails = [];
  List<String> alreadySelectedImages = [];
  TextEditingController titleController = TextEditingController();
  int count = 0;
  List<String> values = ['Public', 'Private'];
  List<String> quantity = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List<String> timeMethod = ['secs', 'mins', 'hrs'];
  String selectedTimeMethod = 'secs';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Ingredient> ingredientsList = [];
  List<Ingredient> updatedIngredientsList = [];
  List<String> methodsList = [];
  List<String> updatedMethodsList = [];
  List<String> tagsList = [];
  TimeOfDay? selectedTime;

  bool isPlaying = false;

  bool isclicked = false;

  List<double>? waveFormData;

  bool get isRecording => recorderController.isRecording;

  bool get shouldShowHint {
    return !hasRecordedAudio && !isRecording;
  }

  bool get isWaveformAndChefNoteEmpty {
  return (waveFormData?.length ?? 0) == 0 && (recipeModel?.chefNote ?? '').isEmpty;
}

  bool hasRecordedAudio = false;

  Future<void> showTagsSheet(context) async {      
    final result =
        await _bottomSheetService.showCustomSheet<dynamic, TagsSheetResponse>(
      variant: BottomSheetType.tags,
    );
    if (result == null) return;
    tagsList = result.data.tags;

    log("tagsList: $tagsList");
    rebuildUi();
    notifyListeners();
  }

  Future<void> showCroppper(File value, context, index) async {
    int fileSizeInBytes = await File(value.path).length();

    // Convert bytes to kilobytes
    double fileSizeInKB = fileSizeInBytes / 1024;

    // Print the file size in kilobytes
    log(' File size is : $fileSizeInKB KB');
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: value.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '',
          toolbarColor: kcBlackColor,
          toolbarWidgetColor: kcWhiteColor,
          activeControlsWidgetColor: kcPrimaryColor,
          cropFrameColor: kcWhiteColor,
          cropGridColor: kcWhiteColor,
          dimmedLayerColor: kcBlackColor,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
        ),
        IOSUiSettings(
          title: '',
        ),
      ],
    );
    if (croppedImage != null) {
      // ! we need "a value of File Type" so here we are converting the from CropperdFile to File
      final XFile croppedFile = XFile(
        croppedImage.path,
      );

      selectedImages[index] = croppedFile;

      rebuildUi();
      notifyListeners();
      int fileSizeInBytes = await File(croppedFile.path).length();

      // Convert bytes to kilobytes
      double fileSizeInKB = fileSizeInBytes / 1024;

      // Print the file size in kilobytes
      log('after Cropper File size is : $fileSizeInKB KB');
    } else {
      log("cropped image is null");
    }
    // = CroppedFile(croppedFile!.path) as XFile;
  }

  String? validatePrepTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some time';
    }
    if (value.length > 3) {
      return 'Please enter only 3 or fewer characters';
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


  String? timedurationPrep;

  void onViewModelReady() async {
    setBusy(true);
    _initialiseController();
    // recorderController = RecorderController();
    playerController = PlayerController();
    directory = await getApplicationDocumentsDirectory();
    if (recipeModel != null) {
      titleController.text = recipeModel!.title;
      ingredientsList = recipeModel!.ingredients;
      methodsList = recipeModel!.methods;
      if(recipeModel!.coverImage.isNotEmpty){
        alreadySelectedImages = recipeModel!.coverImage;
      }
      // selectedTime = recipeModel!.prepTime as TimeOfDay?;
      tagsList = recipeModel!.tags!;
      if (recipeModel!.chefNote.isNotEmpty &&
          recipeModel!.waveForm.isNotEmpty) {
        waveFormData = recipeModel!.waveForm;
        await downloadAudio();
      }
      
      selectedQuantity = recipeModel!.servingSize;
    
      // selectedImages = recipeModel!.coverImage;
    } 

    path = '${directory.path}/recording.mpeg4';
    setBusy(false);
  }

  Future<void> downloadAudio() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final response = await http.get(Uri.parse(recipeModel!.chefNote));
    File audioFile = File("$tempPath/audio.mpeg4");
    if (response.statusCode == 200) {
      await audioFile.writeAsBytes(response.bodyBytes);
      log("Download Complete");
      await playerController.preparePlayer(
        path: audioFile.path,
        volume: 100,
      );

      log("Player Ready");
    }
  }

  void startListening() async {
    log("start Listening ${isPlaying.toString()}");
    isPlaying = true;
    rebuildUi();
    await playerController
        .startPlayer(finishMode: FinishMode.pause)
        .then((value) {
      // isPlaying = false;
      // rebuildUi();
    });
    log("start Listening ends ${isPlaying.toString()}");
  }

  void stopListening() async {
    log("stop Listening ${isPlaying.toString()}");
    await playerController.pausePlayer();
    isPlaying = false;
    log(isPlaying.toString());
    rebuildUi();
    log("stop Listening ends ${isPlaying.toString()}");
  }

  void _initialiseController() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4;
  }

  void addIngredients(List<Ingredient> newIngredients) async {
    final result = await _bottomSheetService
        .showCustomSheet<dynamic, AddIngredientsSheetResponse>(
      variant: BottomSheetType.addIngredients,
    );
    if (result == null) return;
    updatedIngredientsList = result.data.ingredientsList;
    updatedIngredientsList.addAll(newIngredients);
    ingredientsList = updatedIngredientsList;
    notifyListeners();
  }

  void addMethods(List<String> newMethods) async {
    final method = await _bottomSheetService
        .showCustomSheet<dynamic, CookingInstructionsSheetResponse>(
      variant: BottomSheetType.cookingInstructions,
    );
    updatedMethodsList = method!.data.instructionsListResponse.toList();
    updatedMethodsList.addAll(newMethods);
    methodsList = updatedMethodsList;
    notifyListeners();

    rebuildUi();
    notifyListeners();
  }

  void startRecording() async {
    await recorderController.record(
      path: path,
      androidOutputFormat: AndroidOutputFormat.mpeg4,
    );
    rebuildUi();
  }

  int timeConverter() {
    int totalMinutes = selectedTime != null
        ? selectedTime!.hour * 60 + selectedTime!.minute
        : 0;
    return totalMinutes;
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

  void deleteCurrentRecording() {
    hasRecordedAudio = false;
    // _recipeService.deleteAudioFromDocument(recipeModel!.docId!);
    recorderController.reset();
    playerController.release();
    rebuildUi();
  }

  void deleteCurrentImage(index) {
    selectedImages.remove(index);
    thumbnails.remove(index);
    rebuildUi();
  }
  void fireBaseImage(String recipeId, index){
    alreadySelectedImages.removeAt(index);
    _recipeService.deleteIndexImageFromDocument(recipeId,alreadySelectedImages[index]);
    _userSerice.deleteFileFromStorage(alreadySelectedImages[index]);
    notifyListeners();
    rebuildUi();


  }

  Future<void> showCustomTimePickerDialog(BuildContext context) async {
    // Set the initial time to 00:00 (midnight)
    TimeOfDay initialTime = const TimeOfDay(hour: 0, minute: 0);

    // Define a custom theme for the time picker dialog
    final ThemeData themeData = Theme.of(
        context); // Change the text color// Change the color of the dial
    // Change the color of the hand // Change the background color

    // Show the time picker dialog and wait for user input
    selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData(
              textTheme: themeData.textTheme.copyWith(),
              colorScheme: themeData.colorScheme.copyWith(
                primary: kcPrimaryColor,
                onPrimary: kcWhiteColor,
                // onSurface: kcPrimaryColor,
                // surface: kcPrimaryColor,
              ),
              primaryColor: kcPrimaryColor,
              dialogBackgroundColor: kcPrimaryColor,
              hoverColor: kcPrimaryColor,
              focusColor: kcPrimaryColor,
              fontFamily: 'Poppins',
              dialogTheme: DialogTheme(
                backgroundColor: kcWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    rebuildUi();
  }

  String formatDuration([TimeOfDay? time]) {
    int minutes = selectedTime!.minute;
    int hours = selectedTime!.hour;
     
      int remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return '$hours h'; // If no remaining minutes, only display hours
      } else if (hours == 0) {
        return '$remainingMinutes mins'; // If less than an hour, display only minutes
      } else {
        return '$hours h $remainingMinutes mins'; // Otherwise, display hours and minutes
      }
    
  }

  void pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultipleMedia(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    for (var i = 0; i < images.length; i++) {
      if (File(images[i].path).isImage || File(images[i].path).isVideo) {
        if (images.isNotEmpty) {
          log(images.length.toString());
          for (var image in images) {
            if (File(image.path).isImage) {
              thumbnails.add(XFile(image.path));
              log("added image thumbnail");
            } else {
              controller = VideoPlayerController.file(images
                  .where((element) => File(element.path).isVideo)
                  .first
                  .toFile);
              controller.play();
              final thumbnailss = await VideoThumbnail.thumbnailFile(
                video: image.path,
                thumbnailPath: (await getTemporaryDirectory()).path,
                imageFormat: ImageFormat.PNG,
                maxHeight: 50,
                quality: 100,
              );
              thumbnails.add(XFile(thumbnailss!));
              log("added video thumbnail");
            }
            selectedImages.add(XFile(image.path));
          }
          log("selected images: ${selectedImages.length} ,${thumbnails.length}");
          notifyListeners();
          rebuildUi();
        }
      } else {
        showToast(message: 'Please select only images & videos');
      }
    }
  }

  void showDraftDialog() {
    if (titleController.text.trim().isEmpty) {
      showToast(message: 'Title cannot be empty');
      return;
    } else if (ingredientsList.isEmpty) {
      showToast(message: 'Please add ingredients');
      return;
    } else if (methodsList.isEmpty) {
      showToast(message: 'Please add cooking instructions');
      return;
    } else if (timeConverter() == 0) {
      showToast(message: 'Please add cooking time');
      return;
    } else {
      recipeModel == null ? _dialogService
          .showCustomDialog(variant: DialogType.saveDraftAlertbox, data: {
        'model': RecipeModel(
          visibility: 'private',
          chefNote: 'recorderController',
          coverImage: alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
          createdTime: Timestamp.now(),
          ingredients: ingredientsList,
          tags: tagsList,
          methods: methodsList,
          prepTime: formatDuration(),
          servingSize: selectedQuantity,
          status: 'draft',
          title: titleController.text.trim().toLowerCase(),
          uid: firebaseAuth.currentUser!.uid,
          docId: '',
          waveForm: waveFormData == null ? [] : waveFormData!,
        ),
        'images': selectedImages,
        'path': path,
      }) :
      _dialogService
          .showCustomDialog(variant: DialogType.saveDraftAlertbox, data: {
        'model': RecipeModel(
          visibility: 'private',
          chefNote: 'recorderController',
          coverImage: [],
          createdTime: Timestamp.now(),
          ingredients: ingredientsList,
          tags: tagsList,
          methods: methodsList,
          prepTime: formatDuration(),
          servingSize: selectedQuantity,
          status: 'draft',
          title: titleController.text.trim().toLowerCase(),
          uid: firebaseAuth.currentUser!.uid,
          docId: recipeModel!.docId,
          waveForm: waveFormData == null ? [] : waveFormData!,
        ),
        'images': selectedImages,
        'path': path,
      });
    }
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

  void previewRecipe() async {
    if (titleController.text.trim().isNotEmpty &&
        // ignore: unrelated_type_equality_checks
        timeConverter() != 0 &&
        methodsList.isNotEmpty &&
        ingredientsList.isNotEmpty &&
        hasRecordedAudio) {
      bool hasImage = selectedImages.any((image) => image.isImage);
      if (!hasImage) {
        showToast(message: 'Please add at least one image');
        return;
      } else {
        recipeModel != null
            ? _navigationService.navigateToRecipeViewView(
                recipeModel: RecipeModel(
                  visibility: selectedValue,
                  chefNote: '',
                  coverImage: alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
                  createdTime: Timestamp.now(),
                  ingredients: ingredientsList,
                  methods: methodsList,
                  tags: tagsList,
                  prepTime: formatDuration(),
                  servingSize: selectedQuantity,
                  status: 'draft',
                  title: titleController.text.trim().toLowerCase(),
                  uid: firebaseAuth.currentUser!.uid,
                  docId: recipeModel!.docId,
                  waveForm: waveFormData!,
                ),
                selectedImages: selectedImages,
                path: path,
                waveFormData: waveFormData,
              )
            : _navigationService.navigateToRecipeViewView(
                recipeModel: RecipeModel(
                  visibility: selectedValue,
                  chefNote: '',
                  coverImage: alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
                  createdTime: Timestamp.now(),
                  ingredients: ingredientsList,
                  methods: methodsList,
                  tags: tagsList,
                  prepTime: formatDuration(),
                  servingSize: selectedQuantity,
                  status: '',
                  title: titleController.text.trim().toLowerCase(),
                  uid: firebaseAuth.currentUser!.uid,
                  docId: '',
                  waveForm: waveFormData!,
                ),
                selectedImages: selectedImages,
                path: path,
                waveFormData: waveFormData,
              );
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

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    titleController.dispose();

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
      controller.play();
      notifyListeners();
    } else {}
  }

  late List<String> imageUrls;

  // navigateToRecipeViewView() async {
  //   imageUrls = selectedImages.isNotEmpty
  //       ? await _recipeService.uploadMediaToFirebase(selectedImages,
  //           FirebaseFirestore.instance.collection('recipes').doc().id)
  //       : [];

  //   _navigationService.navigateToRecipeViewView(
  //       recipeModel: RecipeModel(
  //         visibility: selectedValue,
  //         chefNote: 'recorderController',
  //         coverImage: imageUrls,
  //         createdTime: Timestamp.now(),
  //         ingredients: ingredientsList,
  //         methods: methodsList,
  //         tags: tagsList,
  //         prepTime:
  //             mergeStrings(prepTimeController.text.trim(), selectedTimeMethod),
  //         servingSize: selectedQuantity,
  //         status: 'draft',
  //         title: titleController.text.trim().toLowerCase(),
  //         uid: firebaseAuth.currentUser!.uid,
  //         docId: '',
  //         waveForm: waveFormData!,
  //       ),
  //       selectedImages: selectedImages);
  // }
}
