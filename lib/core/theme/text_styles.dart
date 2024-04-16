import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';

TextStyle globalTextStyle(
        {required double fontSize,
        Color? color,
        double? letterSpacing,
        
        FontWeight? fontWeight,
        TextDecoration? decoration}) =>
    TextStyle(
      color: color ?? kcWhiteColor,
      fontSize: fontSize,
      letterSpacing: letterSpacing ?? 0.5,
      fontWeight: fontWeight ?? FontWeight.w600,
      fontFamily: 'Inter',
      decoration: decoration ?? TextDecoration.none,
    );
