import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class PinDropMapViewModel extends BaseViewModel {
  late GoogleMapController controllermap;
  Map<String, Marker> markers = {};
  final _bottomSheetService = locator<BottomSheetService>();

  void addMarkers(String markerId, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(markerId),
      position: location,
      infoWindow: InfoWindow(
        onTap: () {
          _bottomSheetService.showCustomSheet(
            variant: BottomSheetType.dropPinSheet,
          );
        },
      ),
    );
    markers[markerId] = marker;
    notifyListeners();
    rebuildUi();
  }
}
