import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/courses_sheet_model.dart';

class TextFieldLink extends ViewModelWidget<CoursesSheetModel> {
  const TextFieldLink(
      {required this.color,
      required this.hinttext,
      required this.controller,
      required this.suffixIcon,
      super.key});
  final String hinttext;
  final Color color;
  final IconData suffixIcon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, CoursesSheetModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 390,
            height: 40,
            child: TextField(
              controller: viewModel.link,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  viewModel.setLinkErrorMessage(viewModel.isLinkValid(value)
                      ? null
                      : "Please enter a valid link");
                } else {
                  viewModel.setLinkErrorMessage(null);
                }
              },
              style: globalTextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: kclightgreencolor,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(color: color),
                suffixIcon: Icon(suffixIcon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
