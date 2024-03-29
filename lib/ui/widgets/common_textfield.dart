// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

// ignore: must_be_immutable
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
            color: kcBlackColor.withOpacity(0.4),
            size: 30.sp,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right:12.0),
            child: RoundedTransparentTextField(
              controller: controller,
              labelText: '$hintText',
              textColor: kcBlackColor.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }
}
