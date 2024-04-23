import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class PinDropMapViewModel extends BaseViewModel {
  GoogleMapController? controllermap;
  Map<String, Marker> markers = {};
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationLoactor = locator<NavigationService>();
  late bool serviceEnabled;
  late LocationPermission permission;
  Position? currentPosition;

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

  void addMarkers(String markerId, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(markerId),
      draggable: true,
      position: location,
      infoWindow: InfoWindow(
        title: location.latitude.toString(),
      ),
      onTap: () async {
        final res = await _bottomSheetService.showCustomSheet(
          variant: BottomSheetType.dropPinButtons,
        );

        if (res?.data == null || res?.data == false) return;
        _bottomSheetService.showCustomSheet(
            variant: BottomSheetType.dropPinSheet, data: location);
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
}
