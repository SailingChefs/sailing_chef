import 'dart:developer';

import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/app.router.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  String selectedTabMainCourse = '';
  String selectedTabSub = '';
  String selectedTabMainDietaryNeed = '';
  String selectedTabSubDietaryNeed = '';
  bool isPassageSelected = false;
  bool isMealSelected = false;
  bool isPlatedSelected = false;
  bool isBreakfastSelected = false;
  bool isLunchSelected = false;
  bool isDinnerSelected = false;
  bool isSweetSelected = false;
  bool isStarterSelected = false;
  bool isCanapeSelected = false;
  bool isSideSelected = false;
  bool isFamilySelected = false;
  bool isLightSelected = false;
  bool isCharterSelected = false;
  bool isCrewSelected = false;

  SfRangeValues values = const SfRangeValues(0.0, 5.0);
  // SfRangeValues values =  SfRangeValues(TimeOfDay.hoursPerDay-2, TimeOfDay.hoursPerDay-5);
  void updateValue(SfRangeValues newValue) {
    
    values = newValue;
    notifyListeners();
    rebuildUi();
  }

  void familySelected() {
    isFamilySelected = true;
    isLightSelected = false;
    isCharterSelected = false;
    isCrewSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void lightSelected() {
    isLightSelected = true;
    isFamilySelected = false;
    isCharterSelected = false;
    isCrewSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void charterSelected() {
    isCharterSelected = true;
    isFamilySelected = false;
    isLightSelected = false;
    isCrewSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void crewSelected() {
    isCrewSelected = true;
    isFamilySelected = false;
    isLightSelected = false;
    isCharterSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void passageSelected() {
    isPassageSelected = true;
    isMealSelected = false;
    isPlatedSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void mealSelected() {
    isMealSelected = true;
    isPassageSelected = false;
    isPlatedSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void platedSelected() {
    isPlatedSelected = true;
    isMealSelected = false;
    isPassageSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void goBack() {
    _navigationService.back();
  }

  void sweetSelected() {
    isSweetSelected = true;
    isStarterSelected = false;
    isCanapeSelected = false;
    isSideSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void starterSelected() {
    isStarterSelected = true;
    isSweetSelected = false;
    isCanapeSelected = false;
    isSideSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void canapeSelected() {
    isCanapeSelected = true;
    isStarterSelected = false;
    isSweetSelected = false;
    isSideSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void sideSelected() {
    isSideSelected = true;
    isCanapeSelected = false;
    isStarterSelected = false;
    isSweetSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void breakfastSelected() {
    isBreakfastSelected = true;
    isLunchSelected = false;
    isDinnerSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void lunchSelected() {
    isLunchSelected = true;
    isBreakfastSelected = false;
    isDinnerSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void dinnerSelected() {
    isDinnerSelected = true;
    isLunchSelected = false;
    isBreakfastSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void handleTabMainCourse(int index) {
    switch (index) {
      case 0:
        selectedTabMainCourse = 'breakfast';
        break;
      case 1:
        selectedTabMainCourse = 'lunch';
        break;
      case 2:
        selectedTabMainCourse = 'dinner';
        break;

      default:
        break;
    }

    rebuildUi();
  }
 List<String> selectedOptions() {
    List<String> selectedList = [];

    if (isPassageSelected) selectedList.add('Passage');
    if (isMealSelected) selectedList.add('Meal');
    if (isPlatedSelected) selectedList.add('Plated');
    if (isBreakfastSelected) selectedList.add('Breakfast');
    if (isLunchSelected) selectedList.add('Lunch');
    if (isDinnerSelected) selectedList.add('Dinner');
    if (isSweetSelected) selectedList.add('Sweet');
    if (isStarterSelected) selectedList.add('Starter');
    if (isCanapeSelected) selectedList.add('Canape');
    if (isSideSelected) selectedList.add('Side');
    if (isFamilySelected) selectedList.add('Family');
    if (isLightSelected) selectedList.add('Light');
    if (isCharterSelected) selectedList.add('Charter');
    if (isCrewSelected) selectedList.add('Crew');

    return selectedList;
  }
  void handleSubTabsCourse(int index) {
    switch (index) {
      case 0:
        selectedTabSub = 'starter';
        break;
      case 1:
        selectedTabSub = 'canape';
        break;
      case 2:
        selectedTabSub = 'side';
      case 3:
        selectedTabSub = 'sweet';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void handleMainTabsDietary(int index) {
    switch (index) {
      case 0:
        selectedTabMainDietaryNeed = 'passagefriendly';
        break;
      case 1:
        selectedTabMainDietaryNeed = 'mealprep';
        break;
      case 2:
        selectedTabMainDietaryNeed = 'plated';
        break;
      default:
        break;
    }
    notifyListeners();
    rebuildUi();
  }

  void handleSubTabsDietary(int index) {
    switch (index) {
      case 0:
        selectedTabSubDietaryNeed = 'family';
        break;
      case 1:
        selectedTabSubDietaryNeed = 'light';
        break;
      case 2:
        selectedTabSubDietaryNeed = 'charter';
        break;
      case 3:
        selectedTabSubDietaryNeed = 'crew';
        break;
      default:
        break;
    }
    notifyListeners();
    rebuildUi();
  }

  void reset() {
    isCrewSelected = false;
    isFamilySelected = false;
    isLightSelected = false;
    isCharterSelected = false;
    isPassageSelected = false;
    isMealSelected = false;
    isPlatedSelected = false;
    isSweetSelected = false;
    isStarterSelected = false;
    isCanapeSelected = false;
    isSideSelected = false;
    isBreakfastSelected = false;
    isLunchSelected = false;
    isDinnerSelected = false;
    selectedTabMainCourse = '';
    selectedTabSub = '';
    selectedTabMainDietaryNeed = '';
    selectedTabSubDietaryNeed = '';

    values = const SfRangeValues(0.0, 5.0);
    notifyListeners();
    rebuildUi();
  }

void apply() {
  int minTimeInMinutes = (values.start * 60).floor();
  int maxTimeInMinutes = (values.end * 60).floor();
  List<RecipeModel> filteredRecipes = RecipeService.recipes.where((recipe) {

    // Check if any tag in the recipe matches any tag in the specified tags list
    bool tagMatch = recipe.tags!.any((tag) => selectedOptions().contains(tag));
    
    // Parse prep time of the recipe into minutes
    int prepTimeMinutes = _parsePrepTime(recipe.prepTime);

    // Check if prep time falls within the specified range
    bool timeInRange = prepTimeMinutes >= minTimeInMinutes && prepTimeMinutes <= maxTimeInMinutes;

    log(selectedOptions().toString());

    if(selectedOptions().isEmpty){
      return timeInRange;
    }

    return tagMatch && timeInRange;
  }).toList();
 _navigationService.replaceWithSearchView(recipeModel: filteredRecipes, chefList: ChefService.chefs);
  // Now filteredRecipes contains only the recipes that have at least one of the specified tags
  // and prep time within the specified range
}

int _parsePrepTime(String prepTimeString) {
  if (prepTimeString.contains('h')) {
    List<String> parts = prepTimeString.split('h');
    int hours = int.parse(parts[0]);
    int minutes = parts.length > 1 ? int.parse(parts[1].replaceAll('min', '').trim()) : 0;
    return hours * 60 + minutes;
  } else {
    return int.parse(prepTimeString.replaceAll('min', '').trim());
  }
}

//  void apply() {
  
//   List<RecipeModel> filteredRecipes = RecipeService.recipes.where((recipe) {
//     return recipe.tags!.any((tag) => selectedOptions().contains(tag));
//   }).toList();
//   _navigationService.replaceWithSearchView(recipeModel: filteredRecipes, chefList: ChefService.chefs);
// }
}
