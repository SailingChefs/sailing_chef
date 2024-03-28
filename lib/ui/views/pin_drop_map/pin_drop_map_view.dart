// ignore_for_file: prefer_const_constructors

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/widgets/search_bar.dart';

import 'pin_drop_map_viewmodel.dart';

const LatLng currentPosition = LatLng(25.1193, 55.3773);

class PinDropMapView extends StackedView<PinDropMapViewModel> {
  const PinDropMapView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PinDropMapViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          height: 800,
          color: Colors.amberAccent,
          child: Column(children: [
            verticalSpaceMedium,
            const SearchBarIndexView(),
            verticalSpaceMedium,
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: currentPosition, zoom: 14),
              onMapCreated: (controller) {
                viewModel.controllermap = controller;
                viewModel.addMarkers('test', currentPosition);
              },
              markers: viewModel.markers.values.toSet(),
            ),
          ])),
    );
  }

  @override
  PinDropMapViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PinDropMapViewModel();
}
