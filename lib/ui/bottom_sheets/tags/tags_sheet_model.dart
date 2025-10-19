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
  final void Function(SheetResponse<TagsSheetResponse> response)? completer;
  bool initialTagsSet = false;

  TagsSheetModel({required this.completer});

  // Predefined Tags
  List<Tag> get courseTagsList => [
        const Tag(label: 'Breakfast', tagString: 'breakfast'),
        const Tag(label: 'Lunch', tagString: 'lunch'),
        const Tag(label: 'Dinner', tagString: 'dinner'),
        const Tag(label: 'Starter', tagString: 'starter'),
        const Tag(label: 'Canapé', tagString: 'canape'),
        const Tag(label: 'Side', tagString: 'side'),
        const Tag(label: 'Sweet', tagString: 'sweet'),
      ];

  List<Tag> get categoryTagsList => [
        const Tag(label: 'Passage Friendly', tagString: 'passagefriendly'),
        const Tag(label: 'Meal Prep', tagString: 'mealprep'),
        const Tag(label: 'Plated', tagString: 'plated'),
        const Tag(label: 'Family Style', tagString: 'family'),
        const Tag(label: 'Light Meal', tagString: 'light'),
        const Tag(label: 'Charter', tagString: 'charter'),
        const Tag(label: 'Crew', tagString: 'crew'),
      ];

  List<Tag> get dietaryNeedsTagsList => [
        const Tag(label: 'Vegetarian', tagString: 'vegetarian'),
        const Tag(label: 'Vegan', tagString: 'vegan'),
        const Tag(label: 'Gluten-Free', tagString: 'glutenfree'),
        const Tag(label: 'Dairy-Free', tagString: 'dairyfree'),
        const Tag(label: 'Nut-Free', tagString: 'nutfree'),
        const Tag(label: 'Pescatarian', tagString: 'pescatarian'),
        const Tag(label: 'Kosher', tagString: 'kosher'),
        const Tag(label: 'Halal', tagString: 'halal'),
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
    _navigationService.back<void>();
  }

  void reset() {
    courseTags.clear();
    categoryTags.clear();
    dietaryNeedsTags.clear();
    notifyListeners();
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
    completer?.call(
      SheetResponse(
        confirmed: true,
        data: TagsSheetResponse(tags: selectedOptions()),
      ),
    );
  }
}
