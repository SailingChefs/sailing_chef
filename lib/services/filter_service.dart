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

  // Dietary needs state variables (updated to actual dietary tags)
  bool _isVegetarianSelected = false;
  bool _isVeganSelected = false;
  bool _isGlutenFreeSelected = false;
  bool _isDairyFreeSelected = false;
  bool _isNutFreeSelected = false;
  bool _isPescatarianSelected = false;
  bool _isKosherSelected = false;
  bool _isHalalSelected = false;

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

  bool get isVegetarianSelected => _isVegetarianSelected;
  bool get isVeganSelected => _isVeganSelected;
  bool get isGlutenFreeSelected => _isGlutenFreeSelected;
  bool get isDairyFreeSelected => _isDairyFreeSelected;
  bool get isNutFreeSelected => _isNutFreeSelected;
  bool get isPescatarianSelected => _isPescatarianSelected;
  bool get isKosherSelected => _isKosherSelected;
  bool get isHalalSelected => _isHalalSelected;

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

  set isVegetarianSelected(bool value) {
    _isVegetarianSelected = value;
    notifyListeners();
  }

  set isVeganSelected(bool value) {
    _isVeganSelected = value;
    notifyListeners();
  }

  set isGlutenFreeSelected(bool value) {
    _isGlutenFreeSelected = value;
    notifyListeners();
  }

  set isDairyFreeSelected(bool value) {
    _isDairyFreeSelected = value;
    notifyListeners();
  }

  set isNutFreeSelected(bool value) {
    _isNutFreeSelected = value;
    notifyListeners();
  }

  set isPescatarianSelected(bool value) {
    _isPescatarianSelected = value;
    notifyListeners();
  }

  set isKosherSelected(bool value) {
    _isKosherSelected = value;
    notifyListeners();
  }

  set isHalalSelected(bool value) {
    _isHalalSelected = value;
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
    _isVegetarianSelected = false;
    _isVeganSelected = false;
    _isGlutenFreeSelected = false;
    _isDairyFreeSelected = false;
    _isNutFreeSelected = false;
    _isPescatarianSelected = false;
    _isKosherSelected = false;
    _isHalalSelected = false;

    // Reset UI state variables
    _selectedTagsCount = 0;
    _values = const SfRangeValues(0.0, 5.0);
    _time = '';

    // Clear selected tags
    _selectedTags.clear();

    notifyListeners();
  }

  List<String> selectedOptions() {
    final selectedList = <String>[];

    // Category selections
    if (_isPassageSelected) selectedList.add('Passage Friendly');
    if (_isMealSelected) selectedList.add('Meal Prep');
    if (_isPlatedSelected) selectedList.add('Plated');
    if (_isFamilySelected) selectedList.add('Family Style');
    if (_isLightSelected) selectedList.add('Light Meal');
    if (_isCharterSelected) selectedList.add('Charter');
    if (_isCrewSelected) selectedList.add('Crew');

    // Course selections
    if (_isBreakfastSelected) selectedList.add('Breakfast');
    if (_isLunchSelected) selectedList.add('Lunch');
    if (_isDinnerSelected) selectedList.add('Dinner');
    if (_isSweetSelected) selectedList.add('Sweet');
    if (_isStarterSelected) selectedList.add('Starter');
    if (_isCanapeSelected) selectedList.add('Canapé');
    if (_isSideSelected) selectedList.add('Side');

    // Dietary needs selections
    if (_isVegetarianSelected) selectedList.add('Vegetarian');
    if (_isVeganSelected) selectedList.add('Vegan');
    if (_isGlutenFreeSelected) selectedList.add('Gluten-Free');
    if (_isDairyFreeSelected) selectedList.add('Dairy-Free');
    if (_isNutFreeSelected) selectedList.add('Nut-Free');
    if (_isPescatarianSelected) selectedList.add('Pescatarian');
    if (_isKosherSelected) selectedList.add('Kosher');
    if (_isHalalSelected) selectedList.add('Halal');

    return selectedList;
  }
}
