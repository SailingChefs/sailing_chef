import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
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
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: location.latitude.toString(),
      ),
      onTap: () {
        isClicked = !isClicked;
        _dialogService.showCustomDialog(
          variant: DialogType.pindropDialoguebox,
        );
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
      }
    } catch (e) {
      log('Error fetching pins: $e');
    }
  }
}
