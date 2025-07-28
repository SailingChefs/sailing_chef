import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // Use device pixel ratio for crisp icons
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    
    // Create smaller, crisp icons for better map visibility
    _icon = await _createCustomMarkerIcon(
      'assets/images/icons/green.png',
      Size(40, 40), // Reduced size for normal pins
      devicePixelRatio,
    );
    
    _selectedIcon = await _createCustomMarkerIcon(
      'assets/images/icons/location.png',
      Size(60, 60), // Slightly larger for selected state
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
      final ByteData data = await rootBundle.load(assetPath);
      
      // Calculate optimal target dimensions
      final int targetWidth = (size.width * devicePixelRatio).round();
      final int targetHeight = (size.height * devicePixelRatio).round();
      
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: targetWidth,
        targetHeight: targetHeight,
      );
      
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ByteData? resizedData = await frameInfo.image.toByteData(
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
