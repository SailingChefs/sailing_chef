import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/model/pin_model.dart';

class BitmapImageService {
  BitmapDescriptor? _icon;
  BitmapDescriptor? _selectedIcon;

  BitmapDescriptor getIcon(bool isSelected, PinnedLocationStatus status) {
    log(isSelected.toString());
    return switch (status) {
      PinnedLocationStatus.published => isSelected
          ? (BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue))
          : (BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)),
      PinnedLocationStatus.review =>
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      PinnedLocationStatus.pending =>
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    };
    // return (isSelected ? _selectedIcon : _icon) ??
    //     BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }

  Future<void> initialise(BuildContext context) async {
    // Use device pixel ratio for crisp icons
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    // Create smaller, crisp icons for better map visibility
    _icon = await _createCustomMarkerIcon(
      'assets/images/icons/green.png',
      const Size(40, 50), // Reduced size for normal pins
      devicePixelRatio,
    );

    _selectedIcon = await _createCustomMarkerIcon(
      'assets/images/icons/location.png',
      const Size(50, 60), // Slightly larger for selected state
      devicePixelRatio,
    );
  }

  Future<BitmapDescriptor> _createCustomMarkerIcon(
    String assetPath,
    Size size,
    double devicePixelRatio,
  ) async {
    try {
      // Load the asset as bytes
      final data = await rootBundle.load(assetPath);

      // Calculate optimal target dimensions
      final targetWidth = (size.width * devicePixelRatio).round();
      final targetHeight = (size.height * devicePixelRatio).round();

      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: targetWidth,
        targetHeight: targetHeight,
      );

      final frameInfo = await codec.getNextFrame();
      final resizedData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (resizedData != null) {
        return BitmapDescriptor.fromBytes(resizedData.buffer.asUint8List());
      }
    } catch (e) {
      log('Error creating custom marker icon: $e');
    }

    // Fallback to simpler asset loading
    return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: size,
        devicePixelRatio: devicePixelRatio,
      ),
      assetPath,
    );
  }
}
