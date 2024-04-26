import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class BitmapImageService {
  BitmapDescriptor? _icon;
  BitmapDescriptor? _selectedIcon;

  BitmapDescriptor getIcon(bool isSelected) {
    log(isSelected.toString());
    return (isSelected ? _icon : _selectedIcon) ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }

  Future initialise() async {
    _icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(24, 24)),
        'assets/images/icons/location.png');
    _selectedIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(24, 24)),
        'assets/images/icons/green.png');

  }
}
