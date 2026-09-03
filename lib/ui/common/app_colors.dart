import 'package:flutter/material.dart';

// ─── Canonical palette (~12 colours) ────────────────────────────────────────

const Color kcPrimaryColor = Color(0xFF61A389);       // main brand green
const Color kcPrimaryColorDark = Color(0xFF6C908D);   // dark teal accent
const Color kcDarkColor = Color(0xFF1E5D6D);           // deep ocean header
const Color kcBlackColor = Color(0xFF000000);
const Color kcWhiteColor = Color(0xFFFFFFFF);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);       // dividers, borders
const Color kcSurfaceColor = Color(0xFFF0F4EF);        // card / sheet backgrounds
const Color kcBorderColor = Color(0xFFD0DBEA);         // input borders
const Color kcErrorColor = Color(0xFFFD0000);
Color kcLightGrey = const Color(0xFF80B5A0).withOpacity(0.8); // muted green (non-const)
const Color kcMediumGrey = Color(0xFF85A09F);          // secondary text / icons
const Color kcTextColor = Color(0xFF80B5A0);           // body text tint

// ─── Legacy aliases — keep so existing code compiles unchanged ───────────────

const Color kcwhitecolor = kcWhiteColor;               // was lowercase duplicate
const Color kclightgreencolor = kcPrimaryColor;        // was typo 0xFF61A289 (now correct)
const Color kcsgreycolor = kcSurfaceColor;             // old name
const Color kcsgreylinecolor = kcBorderColor;          // old name
const Color filterIconColor = kcPrimaryColorDark;      // was identical value
const Color kcbackgroundCourses = kcSurfaceColor;      // old name

// ─── Specific-use colours kept as-is ────────────────────────────────────────

const Color kcBackgroundColor = Color.fromARGB(1, 108, 144, 141); // near-transparent tint
const Color kcbuttoncolor = Color(0xFF427536);        // dark green CTA
const Color kcchatboxecolor = Color(0xFFC2D2BE);      // chat bubble bg
const Color kcallertcolor = Color(0xFFDA1B1B);        // alert / destructive
const Color filledcolorlogin = Color(0xFFF4F8F7);     // login form fill
const Color searchIconColor = Color(0xFF606260);       // search icon
const Color editTextColor = Color(0xFF1F1F1F);
const Color editIconColor = Color(0xFF636363);

// ─── Material swatch ─────────────────────────────────────────────────────────

const MaterialColor primarySwatch = MaterialColor(
  0xFF1E5D6D,
  <int, Color>{
    50: kcPrimaryColorDark,
    100: kcPrimaryColorDark,
    200: kcPrimaryColorDark,
    300: kcPrimaryColorDark,
    400: kcPrimaryColorDark,
    500: kcPrimaryColorDark,
    600: kcPrimaryColorDark,
    700: kcPrimaryColorDark,
    800: kcPrimaryColorDark,
    900: kcPrimaryColorDark,
  },
);
