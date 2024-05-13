import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/widgets/buttons.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/widgets/category.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/widgets/course.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/widgets/dietary.dart';

import 'tags_sheet_model.dart';

class TagsSheet extends StackedView<TagsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const TagsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TagsSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
                verticalSpaceLarge,
                const CourseTabBarFilerSheet(),
                verticalSpaceSmall,
                const CategoryTabsFilterSheet(),
                verticalSpaceSmall,
                const DietaryNeedTabsFilterSheet(),
                verticalSpaceMassive,
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: BottomButtonsTagsSheet(
                completer: completer!,
              )),
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
  TagsSheetResponse({required this.tags});
}
