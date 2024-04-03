import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/widgets/recipes_list.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart' ;

class AddRecipeViewModel extends BaseViewModel {
  PageController pageController = PageController(viewportFraction: 1.0);
  late final RecorderController recorderController;
  late final PlayerController playerController;
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  late Directory directory;
  late String path;
  String selectedValue = 'Public';
  int selectedQuantity = 1;
  List<XFile?> selectedImages = [];
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
 

  List<double>? waveFormData;


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

  void onViewModelReady() async{
    setBusy(true);
    recorderController = RecorderController();
    playerController = PlayerController();
    directory  = await getApplicationDocumentsDirectory();
    path = '${directory.path}/recording.m4a';
    setBusy(false);
  }

  void showPreviousImage() {
    if (pageController.page! > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void deleteCurrentImage() {
    selectedImages.removeAt(pageController.page!.round());
    notifyListeners();
    rebuildUi();
  }

  // Function to handle swipe to the left (show next image)
  void showNextImage() {
    if (pageController.page! < selectedImages.length - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  Future<void> pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage(
      imageQuality: 80,
      maxWidth: 1000,
    );

    if (images.isNotEmpty) {
      selectedImages = images;
      notifyListeners();
      rebuildUi();
    }
  }

  void callIngredientsBottomSheet() async {
    final result = await _bottomSheetService.showCustomSheet<dynamic,AddIngredientsSheetResponse>(
      variant: BottomSheetType.addIngredients,
    );
    if(result == null) return;
    ingredientsList = result.data!.ingredientsList;
    notifyListeners();
  }

  void popBack() {
    _navigationService.back();
  }

  void callCookingInstructionBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.cookingInstructions,
    );
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

  void addRecipe() {
    const RecipeeItem(
      image: 'assets/background/burger.png',
      title: 'Shiitaki Mushroom',
      description: '',
      time: '',
      chef: 'Danica Nel',
    );
  }

  String mergeStrings(String time, String method) {
    return '$time $method';
  }

  void saveRecipe() async {
    if (titleController.text.trim().isNotEmpty &&
        prepTimeController.text.trim().isNotEmpty) {
      if (selectedImages.isEmpty) {
        showToast(message: 'Please add at least one image');
        return;
      } else {
        List<String> imageUrls =
            await _recipeService.uploadImagesToFirebase(selectedImages);

        await _recipeService.addRecipeToFirestore(RecipeModel(
          visibility: selectedValue,
          chefNote: 'audioLink',
          coverImage: imageUrls,
          createdTime: Timestamp.now(),
          ingredients: [
            {'ingredients': 'ingredients'}
          ],
          methods: ['methods'],
          prepTime:
              mergeStrings(prepTimeController.text.trim(), selectedTimeMethod),
          servingSize: selectedQuantity,
          status: 'published',
          title: titleController.text.trim(),
          uid: firebaseAuth.currentUser!.uid,
        ));

        _navigationService.navigateToRecipeListPageView();
      }
    } else {
      showToast(message: 'Please fill all fields');
    }
  }

  void goToRecipePreview() {
    _navigationService.navigateToRecipeViewView();
  }

  void startRecording() async {
    recorderController.reset();
    await recorderController.record(path: path);
    rebuildUi();
  }

  void pauseRecording() async {
    await recorderController.pause();
    waveFormData = await playerController.extractWaveformData(path: path);
    await playerController.preparePlayer(path: path, volume: 1.0);
    rebuildUi();
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  void startListening() {
    playerController.startPlayer();
  }
}
