import 'dart:async';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/checkdatatype.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/reviews.dart';
import 'package:sailing_chefs/services/bitmap_image_service.dart';
import 'package:sailing_chefs/services/location_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:uuid/uuid.dart';

class PinDropMapViewModel extends BaseViewModel {
  final _navigationpinService = locator<PinDropService>();
  final DialogService _dialogService = locator<DialogService>();
  final _locationService = locator<LocationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  late bool serviceEnabled;
  late LocationPermission permission;

  Position currentPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  bool isClicked = false;
  late PinnedLocation pinnedLocation;
  List<String> selectedTabSelections = [];
  List<bool> selections = [];
  Map<String, Marker> allMarkers = {};
  Map<String, Marker> filteredMarkers = {};

  BuildContext? context;
  List<PinnedLocation> get pins => _navigationpinService.pins.where((pin) {
        return pin.status == PinnedLocationStatus.published ||
            pin.uid == userDetails?.uid;
      }).toList();
  bool showMarker = false;
  List<String> tagTabSelections = [];
  CameraPosition? initialCameraPosition;
  CameraPosition? currentCameraPosition;
  int totalFilters = 0;
  bool showBottomButtons = false;
  bool showList = false;
  List<PinnedLocation> filteredPins = [];

  GoogleMapController? controllermap;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_navigationpinService];

  Future<void> onViewModelReady(String id) async {
    try {
      setBusy(true);

      await getCurrentLocation().timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw TimeoutException('Location fetch timed out'),
      );
    } catch (e) {
      await Geolocator.getLastKnownPosition();

      log('Error in onViewModelReady: $e');
      showErrorDialog('Failed to initialize map: $e');
    } finally {
      initialCameraPosition = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 12,
      );
      await showAllMarkers(id);

      await loadPinsNearUser();

      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> loadPinsNearUser() async {
    try {
      await _navigationpinService.getPinsNearUserLocation(
        LatLng(currentPosition.latitude, currentPosition.longitude),
      );
      notifyListeners();
    } catch (e) {
      log('Error loading pins: $e');
      showErrorDialog('Failed to load nearby locations');
    }
  }

  Future<void> showErrorDialog(String message) async {
    await _dialogService.showDialog(
      title: 'Error',
      description: message,
      buttonTitle: 'OK',
    );
  }

  Future<void> callDetailsDialog(PinnedLocation pinnedLoco) async {
    try {
      await controllermap?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              pinnedLoco.location.latitude,
              pinnedLoco.location.longitude,
            ),
            zoom: 15,
          ),
        ),
      );

      final place = await getCityCountry(
        pinnedLoco.location.latitude,
        pinnedLoco.location.longitude,
      );

      await _dialogService.showCustomDialog(
        variant: DialogType.pindetails,
        data: pinnedLoco,
        title: place,
      );
    } catch (e) {
      log('Error showing pin details: $e');
      showErrorDialog('Could not show location details');
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      currentPosition = await _locationService.determinePosition();
    } catch (e) {
      log('Error getting location: $e');
      showErrorDialog(
          'Could not get current location. Please check your location settings.');
    } finally {
      notifyListeners();
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
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      // ignore: unnecessary_null_comparison
      if (placemarks != null && placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.subLocality}, ${placemark.locality}, ${placemark.country}';
      }
      return 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }

  LatLng? tapPosition;

  Marker createMarker(
      String markerId, LatLng location, PinnedLocationStatus status,
      [bool isSelected = false]) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: location,
      onTap: () {
        tapPosition = location;
        showList = true;
        showMarker = false;
        showBottomButtons = false;
        rebuildUi();
      },
      icon: locator<BitmapImageService>().getIcon(isSelected, status),
    );

    return marker;
  }

  void onMapTap() {
    showList = false;
    rebuildUi();
  }

  void addMarkers(
      String markerId, LatLng location, PinnedLocationStatus status) {
    allMarkers[markerId] = createMarker(markerId, location, status);
  }

  void showMyLocation() {
    // currentPosition = await getCurrentLocation();

    controllermap!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 15,
        ),
      ),
    );
    rebuildUi();
    allMarkers['currentLocation'] = Marker(
      markerId: const MarkerId('currentLocation'),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
  }

  // Future<void> showAllMarkers(String id) async {
  //   try {
  //     final pinDropService = locator<PinDropService>();
  //     final pins = await pinDropService
  //         .getPins(LatLng(currentPosition.latitude, currentPosition.longitude));

  //     for (PinnedLocation pin in pins) {
  //       if (pin.id != null && pin.location != null) {
  //         addMarkers(
  //             pin.id!, LatLng(pin.location.latitude, pin.location.longitude));

  //       }
  //     }
  //   } catch (e) {
  //     log('Error fetching pins: $e');
  //   }
  // }

// Future<void> showAllMarkers(String id) async {
//   final pinDropService = locator<PinDropService>();
//   final pins = await pinDropService
//      .getPins(LatLng(currentPosition.latitude, currentPosition.longitude));

//   for (PinnedLocation pin in pins) {
//     if (pin.id!= null && pin.location!= null) {
//       addMarkers(
//         pin.id!,
//         LatLng(pin.location.latitude, pin.location.longitude)
//       );
//     }
//   }
// }
  Future<void> showAllMarkers(String id) async {
    try {
      await _navigationpinService.getPinsNearUserLocation(
        LatLng(currentPosition.latitude, currentPosition.longitude),
      );

      for (final pin in pins) {
        addMarkers(pin.id ?? id,
            LatLng(pin.location.latitude, pin.location.longitude), pin.status);
        pinnedLocation = pin;
      }
      notifyListeners();
    } catch (e) {
      log('Error fetching pins: $e');
    }
  }

  void showAllMarkersWithTags() {
    filteredPins.clear();
    try {
      final filteredPin = List<PinnedLocation>.empty(growable: true);

      if (totalFilters == 0) {
        filteredPin.addAll(pins);
      } else {
        for (final pin in pins) {
          if (tagTabSelections.where(pin.tags.contains).isNotEmpty) {
            filteredPins.add(pin);
            filteredPin.add(pin);
          }
        }
      }
      allMarkers.clear();

      rebuildUi();

      for (final pin in filteredPin) {
        addMarkers(pin.id!,
            LatLng(pin.location.latitude, pin.location.longitude), pin.status);
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

  void clearTags() {
    totalFilters = 0;
    tagTabSelections.clear();
    filteredPins.clear();
    notifyListeners();
    rebuildUi();
  }

  Marker createMarkerwithTags(String markerId, LatLng location,
      [bool isSelected = false]) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      draggable: true,
      position: location,
      onTap: () async {
        final place = await getCityCountry(pinnedLocation.location.latitude,
            pinnedLocation.location.longitude);

        final pins = await _navigationpinService.getPinsUsingTags(
            LatLng(currentPosition.latitude, currentPosition.longitude),
            tagTabSelections);

        for (final pinInList in pins) {
          if (pinInList.location.latitude == location.latitude &&
              pinInList.location.longitude == location.longitude) {
            final newMarker =
                createMarker(markerId, location, pinInList.status, true);
            allMarkers[markerId] = newMarker;

            pinnedLocation = pinInList;
            // Map<String, dynamic> test = {
            //   "pinList": pinnedLocation,
            //   "currLoc": currentPosition
            // };
            _dialogService.showCustomDialog(
              variant: DialogType.pindropDialoguebox,
              title: place,
              data: pinnedLocation,
              // additionalButtonTitle: currentPosition!.latitude.toString(),
              // description: currentPosition!.longitude.toString(),
            );

            notifyListeners();
            rebuildUi();
          }
        }
      },
      icon: locator<BitmapImageService>()
          .getIcon(isSelected, PinnedLocationStatus.pending),
    );
    log('logging the value: $isClicked');

    return marker;
  }

  Future<void> showPindropDialogueBox() async {
    showList = false;
    rebuildUi();
    await _dialogService.showCustomDialog(variant: DialogType.addpindropshow);

    showMarker = true;
    rebuildUi();
  }

  String calculateAverageRating(List<ReviewsModel> comments) {
    if (comments.isEmpty) {
      return '0.0'; // Return 0 if there are no comments
    }

    var totalRating = 0.0;

    // Calculate the total rating
    for (final comment in comments) {
      if (comment.rating != null) {
        totalRating += comment.rating!;
      }
    }

    // Calculate the average rating
    final averageRating = totalRating / comments.length;
    return averageRating.toStringAsFixed(1);
  }

  Future<void> navigateToSearchResult(PinnedLocation pin) async {
    if (controllermap != null) {
      // Animate camera to the searched pin location
      await controllermap!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(pin.location.latitude, pin.location.longitude),
            zoom: 16,
          ),
        ),
      );

      // Show pin details dialog after a short delay
      Future.delayed(const Duration(milliseconds: 500), () async {
        final place =
            await getCityCountry(pin.location.latitude, pin.location.longitude);
        _dialogService.showCustomDialog(
          variant: DialogType.pindetails,
          data: pin,
          title: place,
        );
      });
    }
  }

  void onCameraMove(CameraPosition position) {
    // Store the current camera position for use in other methods
    currentCameraPosition = position;

    // If a marker is being shown while camera is moving, hide bottom buttons
    if (showMarker) {
      showBottomButtons = false;
      notifyListeners();
    }

    // Hide list while camera is moving for smoother UX
    if (showList) {
      showList = false;
      notifyListeners();
    }
  }

  // Called when the camera stops moving (camera becomes idle)
  void showBottomSheet() {
    if (showMarker && currentCameraPosition != null) {
      showBottomButtons = true;
      tapPosition = LatLng(
        currentCameraPosition!.target.latitude,
        currentCameraPosition!.target.longitude,
      );
      notifyListeners();
    }
  }

  void onCancel() {
    // Reset map state when canceling pin drop
    showMarker = false;
    showBottomButtons = false;
    if (currentCameraPosition != null) {
      controllermap?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 15,
          ),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> dropPin({required bool isNew}) async {
    if (currentCameraPosition != null) {
      final markerId = const Uuid().v4();
      final pinnedLocationData = PinnedLocationData(
          LatLng(currentCameraPosition!.target.latitude,
              currentCameraPosition!.target.longitude),
          isNew ? null : pinnedLocation);

      final res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.dropPinSheet,
        data: {'pinnedLocationData': pinnedLocationData, 'isNew': isNew},
      );

      if (res?.data == true) {
        // Only add marker and reset view if pin was successfully dropped
        addMarkers(
          markerId,
          LatLng(currentCameraPosition!.target.latitude,
              currentCameraPosition!.target.longitude),
          PinnedLocationStatus.pending,
        );
        showBottomButtons = false;
        showMarker = false;
        await loadPinsNearUser(); // Refresh pins
        notifyListeners();
      }
    }
  }
}
