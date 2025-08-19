import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/model/pin_model.dart';

class PinnedLocationData {
  final LatLng? location;
  final PinnedLocation? pinnedLocation;

  PinnedLocationData(this.location, this.pinnedLocation);
}
