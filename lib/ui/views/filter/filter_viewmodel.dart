import 'dart:developer';

import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/app.router.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/filter_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();
  final FilterService _filterService = locator<FilterService>();

  String selectedTabMainCourse = '';
  String selectedTabSub = '';
  String selectedTabMainDietaryNeed = '';
  String selectedTabSubDietaryNeed = '';

  // Delegate filter state to FilterService
  bool get isPassageSelected => _filterService.isPassageSelected;
  bool get isMealSelected => _filterService.isMealSelected;
  bool get isPlatedSelected => _filterService.isPlatedSelected;
  bool get isFamilySelected => _filterService.isFamilySelected;
  bool get isLightSelected => _filterService.isLightSelected;
  bool get isCharterSelected => _filterService.isCharterSelected;
  bool get isCrewSelected => _filterService.isCrewSelected;

  bool get isBreakfastSelected => _filterService.isBreakfastSelected;
  bool get isLunchSelected => _filterService.isLunchSelected;
  bool get isDinnerSelected => _filterService.isDinnerSelected;
  bool get isSweetSelected => _filterService.isSweetSelected;
  bool get isStarterSelected => _filterService.isStarterSelected;
  bool get isCanapeSelected => _filterService.isCanapeSelected;
  bool get isSideSelected => _filterService.isSideSelected;

  // Dietary selections (updated)
  bool get isVegetarianSelected => _filterService.isVegetarianSelected;
  bool get isVeganSelected => _filterService.isVeganSelected;
  bool get isGlutenFreeSelected => _filterService.isGlutenFreeSelected;
  bool get isDairyFreeSelected => _filterService.isDairyFreeSelected;
  bool get isNutFreeSelected => _filterService.isNutFreeSelected;
  bool get isPescatarianSelected => _filterService.isPescatarianSelected;
  bool get isKosherSelected => _filterService.isKosherSelected;
  bool get isHalalSelected => _filterService.isHalalSelected;

  int get selectedTagsCount => _filterService.selectedTagsCount;
  SfRangeValues get values => _filterService.values;
  String get time => _filterService.time;
  List<String> get selectedTags => _filterService.selectedTags;

  void onViewModelReady() {
    // Listen to FilterService changes
    _filterService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _filterService.removeListener(notifyListeners);
    super.dispose();
  }

  void updateValue(SfRangeValues newValue) {
    _filterService.updateValue(newValue);
    rebuildUi();
  }

  void addTimeFilter() {
    _filterService.addTimeFilter();
    rebuildUi();
  }

  void goBack() {
    _navigationService.back();
  }

  void addTag(String tag) {
    _filterService.addTag(tag);
  }

  void removeTag(String tag) {
    _filterService.removeTag(tag);
  }

  void handleMainTabsCourseCourse(int index) {
    switch (index) {
      case 0:
        if (_filterService.isBreakfastSelected) {
          _filterService.isBreakfastSelected = false;
          _filterService.selectedTagsCount--;
          log('Breakfast Removed');
        } else {
          _filterService.isBreakfastSelected = true;
          _filterService.selectedTagsCount++;
          log('Breakfast Selected');
        }
      case 1:
        if (_filterService.isLunchSelected) {
          _filterService.isLunchSelected = false;
          _filterService.selectedTagsCount--;
          log('Lunch Removed');
        } else {
          _filterService.isLunchSelected = true;
          _filterService.selectedTagsCount++;
          log('Lunch Selected');
        }
      case 2:
        if (_filterService.isDinnerSelected) {
          _filterService.isDinnerSelected = false;
          _filterService.selectedTagsCount--;
          log('Dinner Removed');
        } else {
          _filterService.isDinnerSelected = true;
          _filterService.selectedTagsCount++;
          log('Dinner Selected');
        }
      default:
        break;
    }
    rebuildUi();
  }

  void handleMainTabsCategory(int index) {
    switch (index) {
      case 0:
        if (_filterService.isPassageSelected) {
          _filterService.isPassageSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isPassageSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 1:
        if (_filterService.isMealSelected) {
          _filterService.isMealSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isMealSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 2:
        if (_filterService.isPlatedSelected) {
          _filterService.isPlatedSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isPlatedSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 3:
        if (_filterService.isFamilySelected) {
          _filterService.isFamilySelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isFamilySelected = true;
          _filterService.selectedTagsCount++;
        }
      default:
        break;
    }
    rebuildUi();
  }

  void handleMainTabsDietaryNeed(int index) {
    switch (index) {
      case 0: // Vegetarian
        if (_filterService.isVegetarianSelected) {
          _filterService.isVegetarianSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isVegetarianSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 1: // Vegan
        if (_filterService.isVeganSelected) {
          _filterService.isVeganSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isVeganSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 2: // Gluten-Free
        if (_filterService.isGlutenFreeSelected) {
          _filterService.isGlutenFreeSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isGlutenFreeSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 3: // Dairy-Free
        if (_filterService.isDairyFreeSelected) {
          _filterService.isDairyFreeSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDairyFreeSelected = true;
          _filterService.selectedTagsCount++;
        }
      default:
        break;
    }
    rebuildUi();
  }

  void handleSubTabsCourse(int index) {
    switch (index) {
      case 0:
        if (_filterService.isStarterSelected) {
          _filterService.isStarterSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isStarterSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 1:
        if (_filterService.isCanapeSelected) {
          _filterService.isCanapeSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isCanapeSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 2:
        if (_filterService.isSideSelected) {
          _filterService.isSideSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isSideSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 3:
        if (_filterService.isSweetSelected) {
          _filterService.isSweetSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isSweetSelected = true;
          _filterService.selectedTagsCount++;
        }
      default:
        break;
    }
    rebuildUi();
  }

  void reset() {
    _filterService.reset();
    selectedTabMainCourse = '';
    selectedTabSub = '';
    selectedTabMainDietaryNeed = '';
    selectedTabSubDietaryNeed = '';
    rebuildUi();
  }

  void apply() {
    final filterOptions = _filterService.selectedOptions();

    final filteredRecipes = RecipeService.recipes.where((recipe) {
      // Check if any tag in the recipe matches any tag in the specified tags list
      // final selectedOptions = this.selectedOptions();

      final tagMatch = recipe.tags!.any(filterOptions.contains);

      // Parse prep time of the recipe into hours
      final prepTimeHours = _parsePrepTime(recipe.prepTime) / 60;
      log('prep time $prepTimeHours');

      // Check if prep time falls within the specified range
      final timeInRange =
          prepTimeHours >= (values.start as double) && prepTimeHours <= (values.end as double);

      // Return true if both tag and time conditions are met
      if (filterOptions.isEmpty) {
        return timeInRange;
      }
      return tagMatch && timeInRange;
    }).toList();

    log('filtered ${filteredRecipes.length}');

    _navigationService.navigateToSearchView(
      recipeModel: filteredRecipes,
      chefList: _chefService.chefs,
      selectedTagsCount: selectedTagsCount,
    );
  }

  double _parsePrepTime(String? prepTime) {
    if (prepTime == null || prepTime.isEmpty) return 0.0;

    // Extract numeric values from the string using regex
    final regex = RegExp(r'\d+');
    final Iterable<Match> matches = regex.allMatches(prepTime);

    if (matches.isEmpty) return 0.0;

    var totalMinutes = 0.0;

    for (final match in matches) {
      final value = double.parse(match.group(0)!);

      // Check if the value is followed by 'h' or 'hour' (indicating hours)
      if (prepTime.substring(match.end).toLowerCase().startsWith(RegExp('h|hour'))) {
        totalMinutes += value * 60; // Convert hours to minutes
      } else {
        // Assume it's minutes if not specified as hours
        totalMinutes += value;
      }
    }

    return totalMinutes;
  }

  void handleSubTabsCategory(int index) {
    switch (index) {
      case 0:
        if (_filterService.isFamilySelected) {
          _filterService.isFamilySelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isFamilySelected = true;
          _filterService.selectedTagsCount++;
        }
      case 1:
        if (_filterService.isLightSelected) {
          _filterService.isLightSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isLightSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 2:
        if (_filterService.isCharterSelected) {
          _filterService.isCharterSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isCharterSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 3:
        if (_filterService.isCrewSelected) {
          _filterService.isCrewSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isCrewSelected = true;
          _filterService.selectedTagsCount++;
        }
      default:
        break;
    }
    rebuildUi();
  }

  void handleTabMainCourse(int index) {
    handleMainTabsCourseCourse(index);
  }

  void handleMainTabsDietary(int index) {
    handleMainTabsDietaryNeed(index);
  }

  void handleSubTabsDietary(int index) {
    switch (index) {
      case 0: // Nut-Free
        if (_filterService.isNutFreeSelected) {
          _filterService.isNutFreeSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isNutFreeSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 1: // Pescatarian
        if (_filterService.isPescatarianSelected) {
          _filterService.isPescatarianSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isPescatarianSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 2: // Kosher
        if (_filterService.isKosherSelected) {
          _filterService.isKosherSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isKosherSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 3: // Halal
        if (_filterService.isHalalSelected) {
          _filterService.isHalalSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isHalalSelected = true;
          _filterService.selectedTagsCount++;
        }
      default:
        break;
    }
    rebuildUi();
  }
}
