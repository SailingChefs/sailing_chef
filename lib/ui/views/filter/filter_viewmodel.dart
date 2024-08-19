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
  final ChefService _chefService = locator<ChefService>();
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
  int selectedTagsCount = 0;
  SfRangeValues values = const SfRangeValues(0.0, 5.0);
  String time = '';
  // SfRangeValues values =  SfRangeValues(TimeOfDay.hoursPerDay-2, TimeOfDay.hoursPerDay-5);
  void updateValue(SfRangeValues newValue) {
    values = newValue;

    notifyListeners();
    rebuildUi();
  }

  void addTimeFilter() {
    if (time == '') {
      selectedTagsCount++;
      time = 'time';
    } else {
      time = 'time';
    }
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

  final List<String> _selectedTags = [];

  List<String> get selectedTags => _selectedTags;

  // void addTag(String tag) {
  //   if (!_selectedTags.contains(tag)) {
  //     _selectedTags.remove(tag);
  //   } else {
  //     _selectedTags.add(tag);
  //   }
  // }

  // void removeTag(String tag) {
  //   if (_selectedTags.contains(tag)) {
  //     _selectedTags.remove(tag);
  //   } else {
  //     _selectedTags.add(tag);
  //   }
  // }

  void addTag(String tag) {
    if (!_selectedTags.contains(tag)) {
      _selectedTags.add(tag);
    }
  }

  void removeTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    }
  }

  void shouldIncrementFilterCount() {
    if (selectedTabMainCourse == '') {
      selectedTagsCount++;
    }
  }

  willIncrementCount() {}

  // void handleTabMainCourse(int index) {
  //   switch (index) {
  //     case 0:
  //       isLunchSelected = false;
  //       isDinnerSelected = false;

  //       if (isBreakfastSelected) {
  //         selectedTabMainCourse = '';

  //         isBreakfastSelected = false;
  //         selectedTagsCount--;
  //         removeTag('breakfast');
  //         log("BreakFast Removed");
  //       } else {
  //         selectedTabMainCourse = 'breakfast';
  //         isBreakfastSelected = true;
  //         selectedTagsCount++;
  //         addTag('breakfast');
  //         log("BreakFast Selected");
  //       }
  //       notifyListeners();
  //       rebuildUi();
  //       break;

  //     case 1:
  //       isBreakfastSelected = false;
  //       isDinnerSelected = false;
  //       if (isLunchSelected) {
  //         selectedTabMainCourse = '';

  //         isLunchSelected = false;
  //         selectedTagsCount--;
  //         removeTag('lunch');
  //       } else {
  //         selectedTabMainCourse = 'lunch';
  //         isLunchSelected = true;
  //         selectedTagsCount++;
  //         addTag('lunch');
  //       }
  //       break;
  //     case 2:
  //       isLunchSelected = false;
  //       isBreakfastSelected = false;
  //       if (isDinnerSelected) {
  //         selectedTabMainCourse = '';

  //         isDinnerSelected = false;
  //         selectedTagsCount--;
  //         removeTag('dinner');
  //       } else {
  //         selectedTabMainCourse = 'dinner';
  //         isDinnerSelected = true;
  //         selectedTagsCount++;
  //         addTag('dinner');
  //       }
  //       break;
  //     default:
  //       break;
  //   }
  //   rebuildUi();
  // }

  void handleTabMainCourse(int index) {
    log("Initial State - Breakfast: $isBreakfastSelected, Lunch: $isLunchSelected, Dinner: $isDinnerSelected, Count: $selectedTagsCount");

    bool wasAnyMainCourseSelected =
        isBreakfastSelected || isLunchSelected || isDinnerSelected;

    switch (index) {
      case 0:
        isLunchSelected = false;
        isDinnerSelected = false;

        if (isBreakfastSelected) {
          isBreakfastSelected = false;
          selectedTabMainCourse = '';
          selectedTagsCount--;
          removeTag('breakfast');
          log("Breakfast Removed");
        } else {
          isBreakfastSelected = true;
          selectedTabMainCourse = 'breakfast';
          if (!wasAnyMainCourseSelected) selectedTagsCount++;
          addTag('breakfast');
          log("Breakfast Selected");
        }
        break;

      case 1:
        isBreakfastSelected = false;
        isDinnerSelected = false;

        if (isLunchSelected) {
          isLunchSelected = false;
          selectedTabMainCourse = '';
          selectedTagsCount--;
          removeTag('lunch');
          log("Lunch Removed");
        } else {
          isLunchSelected = true;
          selectedTabMainCourse = 'lunch';
          if (!wasAnyMainCourseSelected) selectedTagsCount++;
          addTag('lunch');
          log("Lunch Selected");
        }
        break;

      case 2:
        isBreakfastSelected = false;
        isLunchSelected = false;

        if (isDinnerSelected) {
          isDinnerSelected = false;
          selectedTabMainCourse = '';
          selectedTagsCount--;
          removeTag('dinner');
          log("Dinner Removed");
        } else {
          isDinnerSelected = true;
          selectedTabMainCourse = 'dinner';
          if (!wasAnyMainCourseSelected) selectedTagsCount++;
          addTag('dinner');
          log("Dinner Selected");
        }
        break;

      default:
        break;
    }

    log("Final State - Breakfast: $isBreakfastSelected, Lunch: $isLunchSelected, Dinner: $isDinnerSelected, Count: $selectedTagsCount");

    notifyListeners();
    rebuildUi();
  }

  void handleMainTabsDietary(int index) {
    switch (index) {
      case 0:
        if (isPassageSelected) {
          isPassageSelected = false;
          selectedTagsCount--;
          removeTag('Passage');
        } else {
          isPassageSelected = true;
          selectedTagsCount++;
          addTag('Passage');
        }
        break;
      case 1:
        if (isMealSelected) {
          isMealSelected = false;
          selectedTagsCount--;
          removeTag('Meal');
        } else {
          isMealSelected = true;
          selectedTagsCount++;
          addTag('Meal');
        }
        break;
      case 2:
        if (isPlatedSelected) {
          isPlatedSelected = false;
          selectedTagsCount--;
          removeTag('Plated');
        } else {
          isPlatedSelected = true;
          selectedTagsCount++;
          addTag('Plated');
        }
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void handleSubTabsDietary(int index) {
    switch (index) {
      case 0:
        if (isFamilySelected) {
          isFamilySelected = false;
          selectedTagsCount--;
          removeTag('Family');
        } else {
          isFamilySelected = true;
          selectedTagsCount++;
          addTag('Family');
        }
        break;
      case 1:
        if (isLightSelected) {
          isLightSelected = false;
          selectedTagsCount--;
          removeTag('Light');
        } else {
          isLightSelected = true;
          selectedTagsCount++;
          addTag('Light');
        }
        break;
      case 2:
        if (isCharterSelected) {
          isCharterSelected = false;
          selectedTagsCount--;
          removeTag('Charter');
        } else {
          isCharterSelected = true;
          selectedTagsCount++;
          addTag('Charter');
        }
        break;
      case 3:
        if (isCrewSelected) {
          isCrewSelected = false;
          selectedTagsCount--;
          removeTag('Crew');
        } else {
          isCrewSelected = true;
          selectedTagsCount++;
          addTag('Crew');
        }
        break;

      default:
        break;
    }
    notifyListeners();
  }

  void handleSubTabsCourse(int index) {
    switch (index) {
      case 0:
        isStarterSelected = !isStarterSelected;
        if (isStarterSelected) {
          addTag('starter');
          selectedTagsCount++;
        } else {
          removeTag('starter');
          selectedTagsCount--;
        }
        break;
      case 1:
        isCanapeSelected = !isCanapeSelected;
        if (isCanapeSelected) {
          addTag('canape');
          selectedTagsCount++;
        } else {
          removeTag('canape');
          selectedTagsCount--;
        }
        break;
      case 2:
        isSideSelected = !isSideSelected;
        if (isSideSelected) {
          addTag('side');
          selectedTagsCount++;
        } else {
          removeTag('side');
          selectedTagsCount--;
        }
        break;
      default:
        break;
    }
    notifyListeners();
  }

  // void handleSubTabsCourse(int index) {
  //   switch (index) {
  //     case 0:
  //       isStarterSelected = !isStarterSelected;
  //       if (isStarterSelected) {
  //         addTag('starter');
  //         selectedTagsCount++;
  //       } else {
  //         removeTag('starter');
  //         selectedTagsCount--;
  //       }
  //       notifyListeners();
  //       break;
  //     case 1:
  //       isCanapeSelected = !isCanapeSelected;
  //       if (isCanapeSelected) {
  //         addTag('canape');
  //         selectedTagsCount++;
  //       } else {
  //         removeTag('canape');
  //         selectedTagsCount--;
  //       }
  //       notifyListeners();
  //       break;
  //     case 2:
  //       isSideSelected = !isSideSelected;
  //       if (isSideSelected) {
  //         addTag('side');
  //         selectedTagsCount++;
  //       } else {
  //         removeTag('side');
  //         selectedTagsCount--;
  //       }
  //       notifyListeners();
  //       break;
  //     default:
  //       break;
  //   }
  // }

// void handleSubTabsCourse(int index) {
//   switch (index) {
//     case 0:
//       if (isStarterSelected) {
//         isStarterSelected = false;
//         selectedTagsCount--;
//       } else {
//         isStarterSelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     case 1:
//       if (isCanapeSelected) {
//         isCanapeSelected = false;
//         selectedTagsCount--;
//       } else {
//         isCanapeSelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     case 2:
//       if (isSideSelected) {
//         isSideSelected = false;
//         selectedTagsCount--;
//       } else {
//         isSideSelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     default:
//       break;
//   }
//   rebuildUi();
// }

// void handleMainTabsDietary(int index) {
//   switch (index) {
//     case 0:
//       if (isCrewSelected) {
//         isCrewSelected = false;
//         selectedTagsCount--;
//       } else {
//         isCrewSelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     case 1:
//       if (isFamilySelected) {
//         isFamilySelected = false;
//         selectedTagsCount--;
//       } else {
//         isFamilySelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     case 2:
//       if (isLightSelected) {
//         isLightSelected = false;
//         selectedTagsCount--;
//       } else {
//         isLightSelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     default:
//       break;
//   }
//   rebuildUi();
// }

// void handleSubTabsDietary(int index) {
//   switch (index) {
//     case 0:
//       if (isCharterSelected) {
//         isCharterSelected = false;
//         selectedTagsCount--;
//       } else {
//         isCharterSelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     case 1:
//       if (isPassageSelected) {
//         isPassageSelected = false;
//         selectedTagsCount--;
//       } else {
//         isPassageSelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     case 2:
//       if (isMealSelected) {
//         isMealSelected = false;
//         selectedTagsCount--;
//       } else {
//         isMealSelected = true;
//         selectedTagsCount++;
//       }
//       break;
//     default:
//       break;
//   }
//   rebuildUi();
// }
// void handleSubTabsCourse(int index) {
//   switch (index) {
//     case 0:
//       isStarterSelected =!isStarterSelected;
//       if (isStarterSelected) {
//         addTag('starter');
//         selectedTagsCount++;
//       } else {
//         removeTag('starter');
//         selectedTagsCount--;
//       }
//       notifyListeners();
//       break;
//     case 1:
//       isCanapeSelected =!isCanapeSelected;
//       if (isCanapeSelected) {
//         addTag('canape');
//         selectedTagsCount++;
//       } else {
//         removeTag('canape');
//         selectedTagsCount--;
//       }
//       notifyListeners();
//       break;
//     case 2:
//       isSideSelected =!isSideSelected;
//       if (isSideSelected) {
//         addTag('side');
//         selectedTagsCount++;
//       } else {
//         removeTag('side');
//         selectedTagsCount--;
//       }
//       notifyListeners();
//       break;
//     default:
//       break;
//   }
// }

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

  // void handleSubTabsCourse(int index) {
  //   switch (index) {
  //     case 0:
  //       selectedTabSub = 'starter';
  //       break;
  //     case 1:
  //       selectedTabSub = 'canape';
  //       break;
  //     case 2:
  //       selectedTabSub = 'side';
  //     case 3:
  //       selectedTabSub = 'sweet';
  //       break;

  //     default:
  //       break;
  //   }

  //   rebuildUi();
  // }

  // void handleMainTabsDietary(int index) {
  //   switch (index) {
  //     case 0:
  //       selectedTabMainDietaryNeed = 'passagefriendly';
  //       break;
  //     case 1:
  //       selectedTabMainDietaryNeed = 'mealprep';
  //       break;
  //     case 2:
  //       selectedTabMainDietaryNeed = 'plated';
  //       break;
  //     default:
  //       break;
  //   }
  //   notifyListeners();
  //   rebuildUi();
  // }

  // void handleSubTabsDietary(int index) {
  //   switch (index) {
  //     case 0:
  //       selectedTabSubDietaryNeed = 'family';
  //       break;
  //     case 1:
  //       selectedTabSubDietaryNeed = 'light';
  //       break;
  //     case 2:
  //       selectedTabSubDietaryNeed = 'charter';
  //       break;
  //     case 3:
  //       selectedTabSubDietaryNeed = 'crew';
  //       break;
  //     default:
  //       break;
  //   }
  //   notifyListeners();
  //   rebuildUi();
  // }

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
    selectedTagsCount = 0;
    time = '';
    notifyListeners();
    rebuildUi();
  }

  void apply() {
    List<RecipeModel> filteredRecipes = RecipeService.recipes.where((recipe) {
      // Check if any tag in the recipe matches any tag in the specified tags list
      bool tagMatch =
          recipe.tags!.any((tag) => selectedOptions().contains(tag));

      // Parse prep time of the recipe into hours
      double prepTimeHours = _parsePrepTime(recipe.prepTime) / 60;
      log('prep time ${prepTimeHours.toString()}');

      // Check if prep time falls within the specified range
      bool timeInRange =
          prepTimeHours >= values.start && prepTimeHours <= values.end;

      if (selectedOptions().isEmpty) {
        return timeInRange;
      }

      return tagMatch && timeInRange;
    }).toList();

    _navigationService.replaceWithSearchView(
        selectedTagsCount: selectedTagsCount,
        recipeModel: filteredRecipes,
        chefList: _chefService.chefs);
  }

  int _parsePrepTime(String prepTimeString) {
    prepTimeString =
        prepTimeString.trim(); // Remove any leading or trailing spaces

    if (prepTimeString.contains('h')) {
      List<String> parts = prepTimeString.split('h');

      // Check if there are exactly two parts (hours and minutes)
      if (parts.length == 2) {
        int hours = int.tryParse(parts[0].trim()) ?? 0;
        int minutes = int.tryParse(parts[1].replaceAll('mins', '').trim()) ?? 0;

        // Convert hours and minutes to total minutes
        return hours * 60 + minutes;
      } else if (parts.length == 1) {
        // If only hours are provided
        return int.tryParse(parts[0].replaceAll('h', '').trim()) ?? 0 * 60;
      }
    } else if (prepTimeString.contains('mins')) {
      // If only minutes are provided
      return int.tryParse(prepTimeString.replaceAll('mins', '').trim()) ?? 0;
    }

    // If the format is invalid or parsing fails, return a default value (e.g., 0)
    return 0;
  }

//  void apply() {

//   List<RecipeModel> filteredRecipes = RecipeService.recipes.where((recipe) {
//     return recipe.tags!.any((tag) => selectedOptions().contains(tag));
//   }).toList();
//   _navigationService.replaceWithSearchView(recipeModel: filteredRecipes, chefList: ChefService.chefs);
// }
}
