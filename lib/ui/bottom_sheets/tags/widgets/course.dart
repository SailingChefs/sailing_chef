import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet_model.dart';

class CourseTabBarFilerSheet extends ViewModelWidget<TagsSheetModel> {
  const CourseTabBarFilerSheet({super.key});

  @override
  Widget build(BuildContext context, TagsSheetModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course',
          style: globalTextStyle(
              fontSize: 20.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w500),
        ),
        verticalSpaceSmall,
        Wrap(
          spacing: 8.dg,
          runSpacing: 8.dg,
          children: viewModel.courseTagsList.map((tag) {
            return _buildTag(
              context: context,
              viewModel: viewModel,
              tag: tag,
              onTap: () => viewModel.toggleCourseTag(tag),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTag({
    required BuildContext context,
    required TagsSheetModel viewModel,
    required Tag tag,
    required VoidCallback onTap,
  }) {
    final isSelected = viewModel.isSelected(tag);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.dg, vertical: 12.dg),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.dg),
          ),
          color: isSelected
              ? kcPrimaryColorDark
              : kcVeryLightGrey.withOpacity(0.4),
        ),
        child: Text(
          tag.label,
          style: TextStyle(
            fontSize: 12.0.dg,
            fontWeight: FontWeight.w600,
            color: isSelected ? kcVeryLightGrey : kcBlackColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
