import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/services/bitmap_image_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';

class PinDropMapViewModel extends BaseViewModel {
  GoogleMapController? controllermap;
  Map<String, Marker> markers = {};
  final bottomSheetService = locator<BottomSheetService>();
  final _navigationLoactor = locator<NavigationService>();
  final _navigationpinService = locator<PinDropService>();
  final DialogService _dialogService = locator<DialogService>();
  late bool serviceEnabled;
  late LocationPermission permission;
  Position? currentPosition;
  bool isClicked = false;
  late PinnedLocation pinnedLocation;

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


   Future<String> getCityCountry(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return '${placemark.subLocality}, ${placemark.locality}, ${placemark.country}';
    } else {
      return 'Unknown';
    }
  } catch (e) {
    print('Error getting city and country: $e');
    return 'Unknown';
  }
}

  void addMarkers(String markerId, LatLng location) async {
    var marker = Marker(
      markerId: MarkerId(markerId),
      draggable: true,
      position: location,
      icon: locator<BitmapImageService>().getIcon(isClicked),
      infoWindow: InfoWindow(
        title: location.latitude.toString(),
      ),
      onTap: () async {
        isClicked = true;
        notifyListeners();
        rebuildUi();
     final place =  await   getCityCountry(pinnedLocation.location.latitude, pinnedLocation.location.longitude);
        List<PinnedLocation> pins =
            await _navigationpinService.getPinsNearUserLocation(
          LatLng(currentPosition!.latitude, currentPosition!.longitude),
        );

        for (PinnedLocation pinInList in pins) {
          if (pinInList.location.latitude == location.latitude &&
              pinInList.location.longitude == location.longitude) {
            log("logged ${pinInList.location.latitude}");
            log("pinnedlogged ${pinnedLocation.location.latitude}");
            List<Placemark> placemarks = await placemarkFromCoordinates(
                pinnedLocation.location.latitude,
                pinnedLocation.location.longitude);

            pinnedLocation.placemarks = placemarks;
            log("logged ${pinnedLocation.placemarks!.first.toString()}");
            pinnedLocation = pinInList;
            _dialogService.showCustomDialog(
              variant: DialogType.pindropDialoguebox,
              title: place,
              data: pinnedLocation,
            );
          }
        }
      },
    );
    markers[markerId] = marker;
    rebuildUi();
  }

  void goToFilterView() {
    _navigationLoactor.navigateTo(Routes.filterView);
  }

  void onViewModelReady() async {
    setBusy(true);
    currentPosition = await getCurrentLocation();
    setBusy(false);
  }

  void showAllMarkers(String id) async {
    try {
      List<PinnedLocation> pins =
          await _navigationpinService.getPinsNearUserLocation(
        LatLng(currentPosition!.latitude, currentPosition!.longitude),
      );

      for (PinnedLocation pin in pins) {
        addMarkers(pin.id ?? id,
            LatLng(pin.location.latitude, pin.location.longitude));
        pinnedLocation = pin;
      }
    } catch (e) {
      log('Error fetching pins: $e');
    }
  }
}
