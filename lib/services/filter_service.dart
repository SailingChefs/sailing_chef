import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterService with ChangeNotifier {
  // Category state variables
  bool _isPassageSelected = false;
  bool _isMealSelected = false;
  bool _isPlatedSelected = false;
  bool _isFamilySelected = false;
  bool _isLightSelected = false;
  bool _isCharterSelected = false;
  bool _isCrewSelected = false;

  // Course state variables
  bool _isBreakfastSelected = false;
  bool _isLunchSelected = false;
  bool _isDinnerSelected = false;
  bool _isSweetSelected = false;
  bool _isStarterSelected = false;
  bool _isCanapeSelected = false;
  bool _isSideSelected = false;

  // Dietary needs state variables
  bool _isDietaryPassageSelected = false;
  bool _isDietaryMealSelected = false;
  bool _isDietaryPlatedSelected = false;
  bool _isDietaryFamilySelected = false;
  bool _isDietaryLightSelected = false;
  bool _isDietaryCharterSelected = false;
  bool _isDietaryCrewSelected = false;

  int _selectedTagsCount = 0;
  SfRangeValues _values = const SfRangeValues(0.0, 5.0);
  String _time = '';

  final List<String> _selectedTags = [];

  // Getters
  bool get isPassageSelected => _isPassageSelected;
  bool get isMealSelected => _isMealSelected;
  bool get isPlatedSelected => _isPlatedSelected;
  bool get isFamilySelected => _isFamilySelected;
  bool get isLightSelected => _isLightSelected;
  bool get isCharterSelected => _isCharterSelected;
  bool get isCrewSelected => _isCrewSelected;

  bool get isBreakfastSelected => _isBreakfastSelected;
  bool get isLunchSelected => _isLunchSelected;
  bool get isDinnerSelected => _isDinnerSelected;
  bool get isSweetSelected => _isSweetSelected;
  bool get isStarterSelected => _isStarterSelected;
  bool get isCanapeSelected => _isCanapeSelected;
  bool get isSideSelected => _isSideSelected;

  bool get isDietaryPassageSelected => _isDietaryPassageSelected;
  bool get isDietaryMealSelected => _isDietaryMealSelected;
  bool get isDietaryPlatedSelected => _isDietaryPlatedSelected;
  bool get isDietaryFamilySelected => _isDietaryFamilySelected;
  bool get isDietaryLightSelected => _isDietaryLightSelected;
  bool get isDietaryCharterSelected => _isDietaryCharterSelected;
  bool get isDietaryCrewSelected => _isDietaryCrewSelected;

  int get selectedTagsCount => _selectedTagsCount;
  SfRangeValues get values => _values;
  String get time => _time;
  List<String> get selectedTags => _selectedTags;

  // Setters
  set isPassageSelected(bool value) {
    _isPassageSelected = value;
    notifyListeners();
  }

  set isMealSelected(bool value) {
    _isMealSelected = value;
    notifyListeners();
  }

  set isPlatedSelected(bool value) {
    _isPlatedSelected = value;
    notifyListeners();
  }

  set isFamilySelected(bool value) {
    _isFamilySelected = value;
    notifyListeners();
  }

  set isLightSelected(bool value) {
    _isLightSelected = value;
    notifyListeners();
  }

  set isCharterSelected(bool value) {
    _isCharterSelected = value;
    notifyListeners();
  }

  set isCrewSelected(bool value) {
    _isCrewSelected = value;
    notifyListeners();
  }

  set isBreakfastSelected(bool value) {
    _isBreakfastSelected = value;
    notifyListeners();
  }

  set isLunchSelected(bool value) {
    _isLunchSelected = value;
    notifyListeners();
  }

  set isDinnerSelected(bool value) {
    _isDinnerSelected = value;
    notifyListeners();
  }

  set isSweetSelected(bool value) {
    _isSweetSelected = value;
    notifyListeners();
  }

  set isStarterSelected(bool value) {
    _isStarterSelected = value;
    notifyListeners();
  }

  set isCanapeSelected(bool value) {
    _isCanapeSelected = value;
    notifyListeners();
  }

  set isSideSelected(bool value) {
    _isSideSelected = value;
    notifyListeners();
  }

  set isDietaryPassageSelected(bool value) {
    _isDietaryPassageSelected = value;
    notifyListeners();
  }

  set isDietaryMealSelected(bool value) {
    _isDietaryMealSelected = value;
    notifyListeners();
  }

  set isDietaryPlatedSelected(bool value) {
    _isDietaryPlatedSelected = value;
    notifyListeners();
  }

  set isDietaryFamilySelected(bool value) {
    _isDietaryFamilySelected = value;
    notifyListeners();
  }

  set isDietaryLightSelected(bool value) {
    _isDietaryLightSelected = value;
    notifyListeners();
  }

  set isDietaryCharterSelected(bool value) {
    _isDietaryCharterSelected = value;
    notifyListeners();
  }

  set isDietaryCrewSelected(bool value) {
    _isDietaryCrewSelected = value;
    notifyListeners();
  }

  set selectedTagsCount(int value) {
    _selectedTagsCount = value;
    notifyListeners();
  }

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

  void updateValue(SfRangeValues newValue) {
    _values = newValue;
    notifyListeners();
  }

  void addTimeFilter() {
    if (_time == '') {
      _selectedTagsCount++;
      _time = 'time';
    } else {
      _time = 'time';
    }
    notifyListeners();
  }

  void reset() {
    // Reset category state variables
    _isPassageSelected = false;
    _isMealSelected = false;
    _isPlatedSelected = false;
    _isFamilySelected = false;
    _isLightSelected = false;
    _isCharterSelected = false;
    _isCrewSelected = false;

    // Reset course state variables
    _isBreakfastSelected = false;
    _isLunchSelected = false;
    _isDinnerSelected = false;
    _isSweetSelected = false;
    _isStarterSelected = false;
    _isCanapeSelected = false;
    _isSideSelected = false;

    // Reset dietary needs state variables
    _isDietaryPassageSelected = false;
    _isDietaryMealSelected = false;
    _isDietaryPlatedSelected = false;
    _isDietaryFamilySelected = false;
    _isDietaryLightSelected = false;
    _isDietaryCharterSelected = false;
    _isDietaryCrewSelected = false;

    // Reset UI state variables
    _selectedTagsCount = 0;
    _values = const SfRangeValues(0.0, 5.0);
    _time = '';

    // Clear selected tags
    _selectedTags.clear();

    notifyListeners();
  }

  List<String> selectedOptions() {
    List<String> selectedList = [];

    // Category selections
    if (_isPassageSelected) selectedList.add('Passage');
    if (_isMealSelected) selectedList.add('Meal');
    if (_isPlatedSelected) selectedList.add('Plated');
    if (_isFamilySelected) selectedList.add('Family');
    if (_isLightSelected) selectedList.add('Light');
    if (_isCharterSelected) selectedList.add('Charter');
    if (_isCrewSelected) selectedList.add('Crew');

    // Course selections
    if (_isBreakfastSelected) selectedList.add('Breakfast');
    if (_isLunchSelected) selectedList.add('Lunch');
    if (_isDinnerSelected) selectedList.add('Dinner');
    if (_isSweetSelected) selectedList.add('Sweet');
    if (_isStarterSelected) selectedList.add('Starter');
    if (_isCanapeSelected) selectedList.add('Canape');
    if (_isSideSelected) selectedList.add('Side');

    // Dietary needs selections
    if (_isDietaryPassageSelected) selectedList.add('DietaryPassage');
    if (_isDietaryMealSelected) selectedList.add('DietaryMeal');
    if (_isDietaryPlatedSelected) selectedList.add('DietaryPlated');
    if (_isDietaryFamilySelected) selectedList.add('DietaryFamily');
    if (_isDietaryLightSelected) selectedList.add('DietaryLight');
    if (_isDietaryCharterSelected) selectedList.add('DietaryCharter');
    if (_isDietaryCrewSelected) selectedList.add('DietaryCrew');

    return selectedList;
  }
}
