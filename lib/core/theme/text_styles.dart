import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';

TextStyle globalTextStyle(
        {required double fontSize,
        Color? color,
        double? letterSpacing,
        FontWeight? fontWeight,
        double? height,
        TextDecoration? decoration}) =>
    GoogleFonts.inter(
        textStyle: TextStyle(
      height: height ?? 1.5,
      color: color ?? kcWhiteColor,
      fontSize: fontSize,
      letterSpacing: letterSpacing ?? 0.5,
      fontWeight: fontWeight ?? FontWeight.w600,
      fontFamily: 'Inter',
      decoration: decoration ?? TextDecoration.none,
    ));
