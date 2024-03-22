import 'package:sailing_chefs/app/app.locator.dart';
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
    isCrewSelected;
    isFamilySelected;
    isLightSelected;
    isCharterSelected;
    isPassageSelected;
    isMealSelected;
    isPlatedSelected;
    isSweetSelected;
    isStarterSelected;
    isCanapeSelected;
    isSideSelected;
    isBreakfastSelected;
    isLunchSelected;
    isDinnerSelected;
    selectedTabMainCourse;
    selectedTabSub;
    selectedTabMainDietaryNeed;
    selectedTabSubDietaryNeed;

    _navigationService.back();
  }
}
