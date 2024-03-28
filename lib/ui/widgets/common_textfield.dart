import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class CommonTextField extends StatelessWidget {
  CommonTextField(
      {super.key, this.hintText, this.prefix, this.postfix, this.width});
  final String? hintText;
  final IconData? prefix, postfix;
  final double? width;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            prefix,
            color: kcBlackColor.withOpacity(0.5),
            size: 30.sp,
          ),
        ),
        Container(
          height: 50.h,
          width: width ?? 290.w,
          decoration: BoxDecoration(
            color: kcVeryLightGrey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: SemiRoundedTranpaentTextField(
              controller: controller,
              labelText: '$hintText',
            ),
          ),
        ),
      ],
    );
  }
}
