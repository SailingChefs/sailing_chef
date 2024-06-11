import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BitmapImageService {
  BitmapDescriptor? _icon;
  BitmapDescriptor? _selectedIcon;

  BitmapDescriptor getIcon(bool isSelected) {
    log(isSelected.toString());
    return (isSelected ? _selectedIcon : _icon) ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }

  Future initialise(BuildContext context) async {
    final double iconSize = MediaQuery.of(context).size.width * 0.1; 
    final ImageConfiguration imageConfiguration = ImageConfiguration(size: Size(iconSize, iconSize),devicePixelRatio: iconSize);

    _icon = await BitmapDescriptor .fromAssetImage(
        imageConfiguration, 'assets/images/icons/green.png');
    _selectedIcon = await BitmapDescriptor.fromAssetImage(
        imageConfiguration, 'assets/images/icons/location.png');
  }
}
