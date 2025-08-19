import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet.dart';

class Tag {
  final String label;
  final String tagString;

  const Tag({required this.label, required this.tagString});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag && runtimeType == other.runtimeType && tagString == other.tagString;

  @override
  int get hashCode => tagString.hashCode;
}

class TagsSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final Function(SheetResponse response)? completer;
  bool initialTagsSet = false;

  TagsSheetModel({required this.completer});

  // Predefined Tags
  List<Tag> get courseTagsList => [
        Tag(label: 'Breakfast', tagString: 'breakfast'),
        Tag(label: 'Lunch', tagString: 'lunch'),
        Tag(label: 'Dinner', tagString: 'dinner'),
        Tag(label: 'Starter', tagString: 'starter'),
        Tag(label: 'Canapé', tagString: 'canape'),
        Tag(label: 'Side', tagString: 'side'),
        Tag(label: 'Sweet', tagString: 'sweet'),
      ];

  List<Tag> get categoryTagsList => [
        Tag(label: 'Passage friendly', tagString: 'passagefriendly'),
        Tag(label: 'Meal Prep', tagString: 'mealprep'),
        Tag(label: 'Plated', tagString: 'plated'),
        Tag(label: 'Family Style', tagString: 'family'),
        Tag(label: 'Light Meal', tagString: 'light'),
        Tag(label: 'Charter', tagString: 'charter'),
        Tag(label: 'Crew', tagString: 'crew'),
      ];

  List<Tag> get dietaryNeedsTagsList => [
        Tag(label: 'Vegetarian', tagString: 'vegetarian'),
        Tag(label: 'Vegan', tagString: 'vegan'),
        Tag(label: 'Gluten-Free', tagString: 'glutenfree'),
        Tag(label: 'Dairy-Free', tagString: 'dairyfree'),
        Tag(label: 'Nut-Free', tagString: 'nutfree'),
        Tag(label: 'Pescatarian', tagString: 'pescatarian'),
        Tag(label: 'Kosher', tagString: 'kosher'),
        Tag(label: 'Halal', tagString: 'halal'),
      ];

  // Selected Tags
  Set<Tag> courseTags = {};
  Set<Tag> categoryTags = {};
  Set<Tag> dietaryNeedsTags = {};

  // Helper function to toggle selections
  void toggleSelection(Set<Tag> selectionSet, Tag item) {
    if (selectionSet.contains(item)) {
      selectionSet.remove(item);
    } else {
      selectionSet.add(item);
    }
    notifyListeners();
    rebuildUi();
  }

  // Specific toggle functions for each category
  void toggleCourseTag(Tag course) {
    toggleSelection(courseTags, course);
  }

  void toggleCategoryTag(Tag category) {
    toggleSelection(categoryTags, category);
  }

  void toggleDietaryNeedTag(Tag need) {
    toggleSelection(dietaryNeedsTags, need);
  }

  // Helper function to check if an item is selected
  bool isSelected(Tag item) {
    return courseTags.contains(item) ||
        categoryTags.contains(item) ||
        dietaryNeedsTags.contains(item);
  }

  bool isTagStringSelected(String tagString) {
    return courseTags.any((tag) => tag.tagString == tagString) ||
        categoryTags.any((tag) => tag.tagString == tagString) ||
        dietaryNeedsTags.any((tag) => tag.tagString == tagString);
  }

  void goBack() {
    _navigationService.back();
  }

  void reset() {
    courseTags.clear();
    categoryTags.clear();
    dietaryNeedsTags.clear();
    notifyListeners();
    rebuildUi();
  }

  void setInitialSelectedTags(List<String> savedTags) {
    for (final tagString in savedTags) {
      if (courseTagsList.any((tag) => tag.label == tagString)) {
        toggleSelection(courseTags, courseTagsList.firstWhere((tag) => tag.label == tagString));
      } else if (categoryTagsList.any((tag) => tag.label == tagString)) {
        toggleSelection(categoryTags, categoryTagsList.firstWhere((tag) => tag.label == tagString));
      } else if (dietaryNeedsTagsList.any((tag) => tag.label == tagString)) {
        toggleSelection(
            dietaryNeedsTags, dietaryNeedsTagsList.firstWhere((tag) => tag.label == tagString));
      }
    }
  }

  List<String> selectedOptions() {
    final selectedList = <String>[];
    selectedList.addAll(courseTags.map((tag) => tag.label));
    selectedList.addAll(categoryTags.map((tag) => tag.label));
    selectedList.addAll(dietaryNeedsTags.map((tag) => tag.label));
    return selectedList;
  }

  void apply() {
    if (completer != null) {
      completer!(SheetResponse(confirmed: true, data: TagsSheetResponse(tags: selectedOptions())));
    }
  }
}
