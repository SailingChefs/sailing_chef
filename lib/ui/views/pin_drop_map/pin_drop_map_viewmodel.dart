import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/services/bitmap_image_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';

class PinDropMapViewModel extends ReactiveViewModel {
  GoogleMapController? controllermap;
  Map<String, Marker> allMarkers = {};
  Map<String, Marker> filteredMarkers = {};
  final bottomSheetService = locator<BottomSheetService>();
  final _navigationpinService = locator<PinDropService>();
  final DialogService _dialogService = locator<DialogService>();
  late bool serviceEnabled;
  late LocationPermission permission;
  String? mapStyle;

  Position? currentPosition;
  bool isClicked = false;
  PinnedLocation? pinnedLocation;
  List<String> selectedTabSelections = [];
  List<bool> selections = [];
  final pins = List<PinnedLocation>.empty(growable: true);
  LatLng? value;
  List<String> tagTabSelections = [];

  int totalFilters = 0;

  Map<String, Marker> get markers {
    if (totalFilters == 0) return allMarkers;
    return filteredMarkers;
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_navigationpinService];
  Future<Position> getCurrentLocation() async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log(currentPosition.toString());
      rebuildUi();
      return currentPosition!;
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }

  bool isSelected = true;

  void tagsIconSelected() {
    isSelected = !isSelected;
    log(isSelected.toString());
    notifyListeners();
  }

  Future<String> getCityCountry(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      // ignore: unnecessary_null_comparison
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return '${placemark.subLocality}, ${placemark.locality}, ${placemark.country}';
      } else {
        return 'Unknown';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  Marker createMarker(String markerId, LatLng location,
      [bool isSelected = false]) {
    var marker = Marker(
      markerId: MarkerId(markerId),
      draggable: true,
      position: location,
      infoWindow: InfoWindow(
        title: location.latitude.toString(),
      ),
      onTap: () async {
        if (pinnedLocation == null) {
          final res = await bottomSheetService.showCustomSheet(
            variant: BottomSheetType.dropPinButtons,
          );
          if (res?.data == null || res?.data == false) return;
          final res2 = await bottomSheetService.showCustomSheet(
              variant: BottomSheetType.dropPinSheet,
              data: LatLng(
                  currentPosition!.latitude, currentPosition!.longitude));
          if (res?.data == null ||
              res?.data == false && res2?.data == false ||
              res2?.data == null) return;
          return;
        }
        final place = await getCityCountry(pinnedLocation!.location.latitude,
            pinnedLocation!.location.longitude);

        List<PinnedLocation> pins =
            await _navigationpinService.getPinsNearUserLocation(
          LatLng(currentPosition!.latitude, currentPosition!.longitude),
        );
        log(pins.toString());
        for (PinnedLocation pinInList in pins) {
          // ignore: unrelated_type_equality_checks
          log("logging the value: ${pinInList.location.latitude == location.latitude.toString()}");
          if (pinInList.location.latitude == location.latitude &&
              pinInList.location.longitude == location.longitude) {
            log("logging: ${isClicked.toString()}");

            pinnedLocation = pinInList;

            _dialogService.showCustomDialog(
              variant: DialogType.pindropDialoguebox,
              title: place,
              data: pinnedLocation,
            );
            notifyListeners();
            rebuildUi();
            return;
          }
        }
      },
      icon: locator<BitmapImageService>().getIcon(isSelected),
    );
    log("logging the value: ${isClicked.toString()}");

    return marker;
  }

  void addMarkers(String markerId, LatLng location,) {
    allMarkers[markerId] = createMarker(markerId, location);
    
    notifyListeners();
    rebuildUi();
  }

  void onViewModelReady() async {
    setBusy(true);
    currentPosition = await getCurrentLocation();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
    setBusy(false);
  }

  void showAllMarkers(String id) async {
    try {
      List<PinnedLocation> newPins =
          await _navigationpinService.getPinsNearUserLocation(
        LatLng(currentPosition!.latitude, currentPosition!.longitude),
      );

      pins.addAll(newPins);

      for (PinnedLocation pin in pins) {
        addMarkers(pin.id ?? id,
            LatLng(pin.location.latitude, pin.location.longitude));
        pinnedLocation = pin;
      }
      notifyListeners();
      rebuildUi();
    } catch (e) {
      log('Error fetching pins: $e');
    }
  }

  void showAllMarkersWithTags() async {
    try {
      final filteredPins = List<PinnedLocation>.empty(growable: true);

      if (totalFilters == 0) {
        filteredPins.addAll(pins);
      } else {
        for (final pin in pins) {
          if (tagTabSelections.where((e) => pin.tags.contains(e)).isNotEmpty) {
            filteredPins.add(pin);
          }
        }
      }
      allMarkers.clear();
      rebuildUi();

      for (PinnedLocation pin in filteredPins) {
        addMarkers(
            pin.id!, LatLng(pin.location.latitude, pin.location.longitude));
        pinnedLocation = pin;
      }
      notifyListeners();
      rebuildUi();
    } catch (e) {
      log('Error fetching pins with tags: $e');
    }
  }

  void handleTagSelection(String tabSelection) {
    if (tagTabSelections.contains(tabSelection)) {
      tagTabSelections.remove(tabSelection);
    } else {
      tagTabSelections.add(tabSelection);
    }
    totalFilters = tagTabSelections.length;
    notifyListeners();
    rebuildUi();
  }

  void handleTabSelection(String tabSelection) {
    if (selectedTabSelections.contains(tabSelection)) {
      selectedTabSelections.remove(tabSelection);
    } else {
      selectedTabSelections.add(tabSelection);
    }
    notifyListeners();
    rebuildUi();
  }

  clearTags() {
    totalFilters = 0;
    tagTabSelections.clear();
    notifyListeners();
    rebuildUi();
  }

  Marker createMarkerwithTags(String markerId, LatLng location,
      [bool isSelected = false]) {
    var marker = Marker(
      markerId: MarkerId(markerId),
      draggable: true,
      position: location,
      infoWindow: InfoWindow(
        title: location.latitude.toString(),
      ),
      onTap: () async {
        final place = await getCityCountry(pinnedLocation!.location.latitude,
            pinnedLocation!.location.longitude);

        List<PinnedLocation> pins =
            await _navigationpinService.getPinsUsingTags(
                LatLng(currentPosition!.latitude, currentPosition!.longitude),
                tagTabSelections);

        for (PinnedLocation pinInList in pins) {
          if (pinInList.location.latitude == location.latitude &&
              pinInList.location.longitude == location.longitude) {
            final newMarker = createMarker(markerId, location, true);
            allMarkers[markerId] = newMarker;

            pinnedLocation = pinInList;
            _dialogService.showCustomDialog(
              variant: DialogType.pindropDialoguebox,
              title: place,
              data: pinnedLocation,
            );

            notifyListeners();
            rebuildUi();
          }
        }
      },
      icon: locator<BitmapImageService>().getIcon(isSelected),
    );
    log("logging the value: ${isClicked.toString()}");

    return marker;
  }
}
