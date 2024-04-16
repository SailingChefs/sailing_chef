import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class RecipeViewViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _recipeService = locator<RecipeService>();
  String selectedTab = 'Ingredients';
  bool isIngredientsSelected = true;
  bool isMethodsSelected = false;
  int serves = 1;

  void myIngredientsSelected() {
    isIngredientsSelected = true;
    isMethodsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void methodsSelected() {
    isMethodsSelected = true;
    isIngredientsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void moveBack() {
    _navigationService.back();
    
  }
  void saveRecipe(RecipeModel recipe,List<XFile?> selectedImages) async{
     List<String> imageUrls =
            await _recipeService.uploadImagesToFirebase(selectedImages);

       final check =  await _recipeService.addRecipeToFirestore(RecipeModel(
          visibility: recipe.visibility,
          chefNote: 'recorderController',
          coverImage: imageUrls,
          createdTime: Timestamp.now(),
          ingredients: recipe.ingredients,
          methods: recipe.methods,
          prepTime: recipe.prepTime,
          servingSize: recipe.servingSize,
          status: 'published',
          title: recipe.title,
          uid: recipe.uid,
        ));
        if(check){
          _navigationService.replaceWithRecipeListPageView(isFromProfileView: false

          );
        }
        else{
          showToast( message: 'Something went wrong');
        }

  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Ingredients';
        break;
      case 1:
        selectedTab = 'Method';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void addServes(value) {
    value++;
    rebuildUi();
    notifyListeners();
  }

  void removeServes(value) {
    if (value == 0) {
      value = 0;
      rebuildUi();
    } else {
      value--;
      rebuildUi();
    }

    rebuildUi();
    notifyListeners();
  }
}
