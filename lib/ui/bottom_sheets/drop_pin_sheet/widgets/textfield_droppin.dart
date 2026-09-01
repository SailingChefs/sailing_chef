import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/drop_pin_sheet_sheet_model.dart';

class DopPinTextFields extends ViewModelWidget<DropPinSheetSheetModel> {
  const DopPinTextFields(
      {required this.func,
      required this.color,
      required this.contoll,
      required this.hinttext,
      required this.suffixIcon,
      super.key});
  final String hinttext;
  final Color color;
  final Widget suffixIcon;
  final VoidCallback func;
  final TextEditingController contoll;
  @override
  Widget build(BuildContext context, DropPinSheetSheetModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 390,
            height: 50,
            child: TextFormField(
              controller: contoll,
              style: globalTextStyle(
                fontSize: 15.sp,
                letterSpacing: -0.5,
                fontWeight: FontWeight.w500,
                color: kcBlackColor.withOpacity(0.87),
              ),
              inputFormatters: [
                //add numbers too
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9!@#\$ ]")),
              ],
              textCapitalization: TextCapitalization.words,
              autocorrect: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: globalTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: kcBlackColor.withOpacity(0.6)),
                suffixIcon: SizedBox(
                  width: 115,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: kcSurfaceColor,
                        width: 1,
                        height: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            if (viewModel.location.pinnedLocation != null) {
                              viewModel.getPfpImage();
                            } else {
                              viewModel.getPfpImage();
                            }
                          },
                          child: viewModel.location.pinnedLocation != null
                              ? viewModel.location.pinnedLocation!.picture
                                          .isNotEmpty &&
                                      viewModel.selectedImageFile == null
                                  ? Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: const BoxDecoration(
                                        color: kcVeryLightGrey,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          child: Image.network(
                                            viewModel.location.pinnedLocation!
                                                .picture.first,
                                            fit: BoxFit.cover,
                                          )),
                                    )
                                  : viewModel.selectedImageFile != null
                                      ? Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: const BoxDecoration(
                                            color: kcVeryLightGrey,
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)),
                                              child: Image.file(
                                                File(viewModel
                                                    .selectedImageFile!
                                                    .first
                                                    .path),
                                                fit: BoxFit.cover,
                                              )),
                                        )
                                      : suffixIcon
                              : viewModel.selectedImageFile != null
                                  ? Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: const BoxDecoration(
                                        color: kcVeryLightGrey,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          child: Image.file(
                                            File(viewModel
                                                .selectedImageFile!.first.path),
                                            fit: BoxFit.cover,
                                          )),
                                    )
                                  : suffixIcon,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
