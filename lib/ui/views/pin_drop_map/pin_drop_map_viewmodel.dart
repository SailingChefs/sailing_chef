

import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/reviews.dart';
import 'package:sailing_chefs/services/bitmap_image_service.dart';
import 'package:sailing_chefs/services/location_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:uuid/uuid.dart';

class PinDropMapViewModel extends ReactiveViewModel {
  GoogleMapController? controllermap;
  Map<String, Marker> allMarkers = {};
  Map<String, Marker> filteredMarkers = {};
  final bottomSheetService = locator<BottomSheetService>();
  final _navigationpinService = locator<PinDropService>();
  final DialogService _dialogService = locator<DialogService>();
  final _locationService = locator<LocationService>();
  late bool serviceEnabled;
  late LocationPermission permission;
  Position? currentPosition;
  bool isClicked = false;
  late PinnedLocation pinnedLocation;
  List<String> selectedTabSelections = [];
  List<bool> selections = [];
  List<PinnedLocation> get pins => _navigationpinService.pins;
  bool showMarker = false;
  List<String> tagTabSelections = [];
  CameraPosition? initialCameraPosition;
  CameraPosition? currentCameraPosition;
  int totalFilters = 0;
  bool showBottomButtons = false;
  bool showList = false;
  List<PinnedLocation> filteredPins = [];

 void onMarkerTap(){
    showList = true;
    rebuildUi();
  }
  void showBottomSheet() {
    showBottomButtons = true;
    rebuildUi();
  }

  Map<String, Marker> get markers {
    if (totalFilters == 0) return allMarkers;
    return filteredMarkers;
  }

  void onCameraMove(CameraPosition position) {
    currentCameraPosition = position;
    rebuildUi();
  }

  void dropPin() async {
    String markerId = const Uuid().v4();
    final res2 = await bottomSheetService.showCustomSheet(
        variant: BottomSheetType.dropPinSheet,
        data: LatLng(currentCameraPosition!.target.latitude, currentCameraPosition!.target.longitude),);
    if ( res2?.data == false ||
        res2?.data == null) return;
    addMarkers(
      markerId,
      LatLng(currentCameraPosition!.target.latitude, currentCameraPosition!.target.longitude),
    );
    showBottomButtons = false;
    showMarker = false;
    rebuildUi();
  }

  void onCancel() {
    showBottomButtons = false;
    showMarker = false;
    rebuildUi();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_navigationpinService];

  Future<Position> getCurrentLocation() async {
    try {
      currentPosition = await _locationService.determinePosition();

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

  LatLng? tapPosition;

  Marker createMarker(String markerId, LatLng location,
      [bool isSelected = false]) {
    var marker = Marker(
      markerId: MarkerId(markerId),

      draggable: false,

      position: location,
      
      onTap: () async {
        tapPosition = location;
        showList = true;
        showMarker = false;
        showBottomButtons = false;
        rebuildUi();
      },
      icon: locator<BitmapImageService>().getIcon(isSelected),
    );

    return marker;
  }
  void onMapTap(){
    showList =  false;
    rebuildUi();
  }

  void addMarkers(String markerId, LatLng location) {
    allMarkers[markerId] = createMarker(markerId, location);
  }

  void onViewModelReady(String id) async {
    setBusy(true);
    currentPosition = await getCurrentLocation();
    allMarkers.values.toSet();
     await showAllMarkers(id);
    // allMarkers['currentLocation'] = Marker(
    //   markerId: const MarkerId('currentLocation'),
    //   position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //   infoWindow: const InfoWindow(title: 'My Location'),
    // );
    initialCameraPosition = CameraPosition(
      target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
      zoom: 12,
    );
    // await _navigationpinService.getPins(
    //   LatLng(currentPosition!.latitude, currentPosition!.longitude),
    // );
    setBusy(false);
  }

  Future<void> showMyLocation() async {
    // currentPosition = await getCurrentLocation();
   
    if (currentPosition != null) {
      controllermap!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(currentPosition!.latitude, currentPosition!.longitude),
            zoom: 15,
          ),
        ),
      );
      rebuildUi();
      // allMarkers['currentLocation'] = Marker(
      //   markerId: const MarkerId('currentLocation'),
      //   position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
      //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      //   infoWindow: const InfoWindow(title: 'My Location'),
      // );
    }
  }
 

   void callDetailsDialog(PinnedLocation pinnedLoco) {
     controllermap!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(pinnedLoco.location.latitude, pinnedLoco.location.longitude),
            zoom: 15,
          ),
        ),
      );
      Future.delayed(Durations.long4, () {
        Future.delayed(Durations.short1);
        _dialogService.showCustomDialog(
      variant: DialogType.pindetails,
      data: pinnedLoco,

      title: 'placeMark',
      // additionalButtonTitle: curLat,
      // description: curLong,
    );
      });
    
  }

  Future<void> showAllMarkers(String id) async {
    try {
  
          await _navigationpinService.getPinsNearUserLocation(
        LatLng(currentPosition!.latitude, currentPosition!.longitude),
      );

      // pins.addAll(newPins);

      for (PinnedLocation pin in pins) {
        addMarkers(pin.id ?? id,
            LatLng(pin.location.latitude, pin.location.longitude));
        pinnedLocation = pin;
      }
      notifyListeners();
    } catch (e) {
      log('Error fetching pins: $e');
    }
  }
  

  void showAllMarkersWithTags() async {
    try {
      final filteredPin = List<PinnedLocation>.empty(growable: true);

      if (totalFilters == 0) {
        filteredPin.addAll(pins);
      } else {
        for (final pin in pins) {
          if (tagTabSelections.where((e) => pin.tags.contains(e)).isNotEmpty) {
            filteredPins.add(pin);
            filteredPin.add(pin);
          }
        }
      }
      allMarkers.clear();
      rebuildUi();

      for (PinnedLocation pin in filteredPin) {
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
    filteredPins.clear();
    notifyListeners();
    rebuildUi();
  }

  // Marker createMarkerwithTags(String markerId, LatLng location,
  //     [bool isSelected = false]) {
  //   var marker = Marker(
  //     markerId: MarkerId(markerId),
  //     draggable: true,
  //     position: location,
  //     infoWindow: InfoWindow(
  //       title: location.latitude.toString(),
  //     ),
  //     onTap: () async {
  //       final place = await getCityCountry(pinnedLocation.location.latitude,
  //           pinnedLocation.location.longitude);

  //       List<PinnedLocation> pins =
  //           await _navigationpinService.getPinsUsingTags(
  //               LatLng(currentPosition!.latitude, currentPosition!.longitude),
  //               tagTabSelections);

  //       for (PinnedLocation pinInList in pins) {
  //         if (pinInList.location.latitude == location.latitude &&
  //             pinInList.location.longitude == location.longitude) {
  //           final newMarker = createMarker(markerId, location, true);
  //           allMarkers[markerId] = newMarker;

  //           pinnedLocation = pinInList;
  //           // Map<String, dynamic> test = {
  //           //   "pinList": pinnedLocation,
  //           //   "currLoc": currentPosition
  //           // };
  //           _dialogService.showCustomDialog(
  //             variant: DialogType.pindropDialoguebox,
  //             title: place,
  //             data: pinnedLocation,
  //             // additionalButtonTitle: currentPosition!.latitude.toString(),
  //             // description: currentPosition!.longitude.toString(),
  //           );

  //           notifyListeners();
  //           rebuildUi();
  //         }
  //       }
  //     },
  //     icon: locator<BitmapImageService>().getIcon(isSelected),
  //   );
  //   log("logging the value: ${isClicked.toString()}");

  //   return marker;
  // }

  void showPindropDialogueBox() async {
    showList = false;
    rebuildUi();
    await _dialogService.showCustomDialog(
      variant: DialogType.addpindropshow,
    );
    

    showMarker = true;
    rebuildUi();
  }
   String calculateAverageRating(List<ReviewsModel> comments) {
    if (comments.isEmpty) {
      return "0.0"; // Return 0 if there are no comments
    }

    double totalRating = 0.0;

    // Calculate the total rating
    for (var comment in comments) {
      if (comment.rating != null) {
        totalRating += comment.rating!;
      }
    }

    // Calculate the average rating
    double averageRating = totalRating / comments.length;
   return averageRating.toStringAsFixed(1);
  }
}
