import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/courses_sheet_model.dart';

class TextFieldLink extends ViewModelWidget<CoursesSheetModel> {
  const TextFieldLink(
      {required this.color,
      required this.hinttext,
      required this.controller,
      this.suffixIcon,
      super.key});
  final String hinttext;
  final Color color;
  final Image? suffixIcon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, CoursesSheetModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: viewModel.link,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a link';
              }
              if (!RegExp(
                r'^(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+(?:\/[\w/.]*)?$',
              ).hasMatch(value)) {
                return 'Please enter a valid URL';
              }
              return null;
            },
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
              color: kcPrimaryColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              hintStyle: TextStyle(color: color),
              suffixIcon: Image.asset(
                'assets/images/icons/link.png',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
