

import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:flutter/widgets.dart';

double pixelsToMediaQueryHeight(double pixels) {
  final mediaQueryData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  final devicePixelRatio = mediaQueryData.devicePixelRatio;
  return pixels * devicePixelRatio;
}

double pixelsToMediaQueryWidth(double pixels) {
  final mediaQueryData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  final devicePixelRatio = mediaQueryData.devicePixelRatio;
  return pixels / devicePixelRatio;
}
