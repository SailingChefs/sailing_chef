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

  bool get isDietaryPassageSelected => _filterService.isDietaryPassageSelected;
  bool get isDietaryMealSelected => _filterService.isDietaryMealSelected;
  bool get isDietaryPlatedSelected => _filterService.isDietaryPlatedSelected;
  bool get isDietaryFamilySelected => _filterService.isDietaryFamilySelected;
  bool get isDietaryLightSelected => _filterService.isDietaryLightSelected;
  bool get isDietaryCharterSelected => _filterService.isDietaryCharterSelected;
  bool get isDietaryCrewSelected => _filterService.isDietaryCrewSelected;

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
      case 0:
        if (_filterService.isDietaryPassageSelected) {
          _filterService.isDietaryPassageSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDietaryPassageSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 1:
        if (_filterService.isDietaryMealSelected) {
          _filterService.isDietaryMealSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDietaryMealSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 2:
        if (_filterService.isDietaryPlatedSelected) {
          _filterService.isDietaryPlatedSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDietaryPlatedSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 3:
        if (_filterService.isDietaryFamilySelected) {
          _filterService.isDietaryFamilySelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDietaryFamilySelected = true;
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

  List<String> selectedOptions() {
    return _filterService.selectedOptions();
  }

  void apply() {
    final filteredRecipes = RecipeService.recipes.where((recipe) {
      // Check if any tag in the recipe matches any tag in the specified tags list
      final tagMatch = recipe.tags!.any((tag) => selectedOptions().contains(tag));

      // Parse prep time of the recipe into hours
      final prepTimeHours = _parsePrepTime(recipe.prepTime) / 60;
      log('prep time $prepTimeHours');

      // Check if prep time falls within the specified range
      final timeInRange = prepTimeHours >= values.start && prepTimeHours <= values.end;

      // Return true if both tag and time conditions are met
      if (selectedOptions().isEmpty) {
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
      case 0:
        if (_filterService.isDietaryFamilySelected) {
          _filterService.isDietaryFamilySelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDietaryFamilySelected = true;
          _filterService.selectedTagsCount++;
        }
      case 1:
        if (_filterService.isDietaryLightSelected) {
          _filterService.isDietaryLightSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDietaryLightSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 2:
        if (_filterService.isDietaryCharterSelected) {
          _filterService.isDietaryCharterSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDietaryCharterSelected = true;
          _filterService.selectedTagsCount++;
        }
      case 3:
        if (_filterService.isDietaryCrewSelected) {
          _filterService.isDietaryCrewSelected = false;
          _filterService.selectedTagsCount--;
        } else {
          _filterService.isDietaryCrewSelected = true;
          _filterService.selectedTagsCount++;
        }
      default:
        break;
    }
    rebuildUi();
  }
}
