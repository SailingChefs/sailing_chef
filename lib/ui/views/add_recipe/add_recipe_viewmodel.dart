import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/recipes_list.dart';

class AddRecipeViewModel extends BaseViewModel {
  PageController pageController = PageController(viewportFraction: 1.0);
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  String selectedValue = 'Public';
  int selectedQuantity = 1;
  List<XFile?> selectedImages = [];
  TextEditingController titleController = TextEditingController();
  int count = 0;
  List<String> values = ['Public', 'Private'];
  List<String> quantity = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  void showPreviousImage() {
    if (pageController.page! > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void deleteCurrentImage() {
    selectedImages.removeAt(pageController.page!.round());
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

  void callIngredientsBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addIngredients,
    );
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

  void navigateToRecipeListView() {
    _navigationService.navigateToRecipeListPageView();
  }

  void goToRecipePreview() {
    _navigationService.navigateToRecipeViewView();
  }
}
