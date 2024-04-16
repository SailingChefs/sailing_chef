
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'pin_drop_map_viewmodel.dart';

 LatLng currentPosition = userDetails!.location!['longitude'] != null
    ? LatLng(
        userDetails!.location!['latitude'] as double,
        userDetails!.location!['longitude'] as double,
      )
    : const LatLng(0, 0);

class PinDropMapView extends StackedView<PinDropMapViewModel> {
  const PinDropMapView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PinDropMapViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Column(
        children: [
         
          Flexible(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: currentPosition, zoom: 14),
              onMapCreated: (controller) {
                viewModel.controllermap = controller;
                viewModel.addMarkers('test', currentPosition);
              },
              markers: viewModel.markers.values.toSet(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PinDropMapViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PinDropMapViewModel();
}
