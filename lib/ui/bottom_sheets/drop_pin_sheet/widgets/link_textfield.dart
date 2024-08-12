// ignore_for_file: deprecated_member_use

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
            child: TextFormField(
              controller: controller,
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
                fontSize: 14.sp,
                letterSpacing: -0.5,
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
          padding: const EdgeInsets.only(right: 15.0),
          child: SvgPicture.asset('assets/images/icons/link.svg',
              width: 20, height: 20, color: kcBlackColor.withOpacity(0.87)),
        )
      ],
    );
  }
}
