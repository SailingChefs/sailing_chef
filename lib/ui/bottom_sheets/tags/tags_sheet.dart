import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/widgets/buttons.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/widgets/category.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/widgets/course.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/widgets/dietary.dart';

class TagsSheet extends StackedView<TagsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const TagsSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    TagsSheetModel viewModel,
    Widget? child,
  ) {
    // Set the initial selected tags
    if (!viewModel.initialTagsSet) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel
            .setInitialSelectedTags(request.data['savedTags'] as List<String>);
        viewModel.initialTagsSet = true;
      });
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: kcWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // verticalSpaceLarge,
                verticalSpaceSmall,
                const CourseTabBarFilerSheet(),
                verticalSpaceSmall,
                const CategoryTabsFilterSheet(),
                verticalSpaceSmall,
                const DietaryNeedTabsFilterSheet(),
                // verticalSpaceLarge,
                verticalSpaceSmall,
                BottomButtonsTagsSheet(
                  completer: completer,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  TagsSheetModel viewModelBuilder(BuildContext context) => TagsSheetModel(
        completer: completer,
      );
}

class TagsSheetResponse {
  final List<String> tags;
  const TagsSheetResponse({required this.tags});
}
