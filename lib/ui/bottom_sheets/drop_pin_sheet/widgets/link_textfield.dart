import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/drop_pin_sheet_sheet_model.dart';

class DopPinTextFieldLink extends ViewModelWidget<DropPinSheetSheetModel> {
  const DopPinTextFieldLink(
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
  Widget build(BuildContext context, DropPinSheetSheetModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 390,
            height: 40,
            child: TextField(
              controller: controller,
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
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:15.0),
          child: SvgPicture.asset('assets/images/icons/link.svg',
              width: 20, height: 20, color: kcBlackColor.withOpacity(0.87)),
        )
      ],
    );
  }
}
