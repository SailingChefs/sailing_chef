import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';

class BackArrowWidget extends StatelessWidget {
  final void Function() onTap;
  const BackArrowWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8.0.dg),
        height: 30.h,
        width: 30.w,
        decoration: const BoxDecoration(
          color: kcVeryLightGrey,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: kcBlackColor,
          size: 19.sp,
        ),
      ),
    );
  }
}
