import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/courses_sheet_model.dart';

class CoursesButtons extends ViewModelWidget<CoursesSheetModel> {
  final Function(SheetResponse response)? completer;
  const CoursesButtons({super.key, this.completer});

  @override
  Widget build(BuildContext context, CoursesSheetModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            height: 42,
            width: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kcPrimaryColorDark),
            child: TextButton(
              onPressed: () {
                viewModel.saveCourse();
              },
              child: Text(
                'Submit for review',
                style: globalTextStyle(
                    fontSize: 14,
                    color: kcWhiteColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Container(
            height: 42,
            width: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kcButtonColor.withOpacity(0.1)),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: globalTextStyle(
                    fontSize: 14,
                    color: kcBlackColor.withOpacity(0.6),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
