// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/topbar_search.dart';

import 'pin_drop_map_viewmodel.dart';

//  LatLng currentPosition = userDetails!.location!['longitude'] != null
//     ? LatLng(
//         userDetails!.location!['latitude'] as double,
//         userDetails!.location!['longitude'] as double,
//       )
//     : const LatLng(0, 0);

class PinDropMapView extends StackedView<PinDropMapViewModel> {
  const PinDropMapView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PinDropMapViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Column(
              children: [
                verticalSpace(40),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SearchBarPinDrop(),
                ),
                verticalSpace(10),
                Flexible(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    mapToolbarEnabled: false,
                    onTap: (value) {
                      String markerId = Uuid().v4();
                      viewModel.addMarkers(
                        markerId,
                          value,
                      );
                      log(value.toString());
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                          viewModel.currentPosition!.latitude,
                          viewModel.currentPosition!.longitude,
                        ),
                        zoom: 14),
                    onMapCreated: (controller) {
                      viewModel.controllermap = controller;
                      log(viewModel.currentPosition!.latitude.toString());
                      log(viewModel.currentPosition!.longitude.toString());
                    },
                    markers: viewModel.markers.values.toSet(),
                  ),
                ),
              ],
            ),
          );
  }

  @override
  void onViewModelReady(PinDropMapViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  PinDropMapViewModel viewModelBuilder(
    BuildContext context,
  ) {
    final viewModel = PinDropMapViewModel();
    viewModel.getCurrentLocation();
    return viewModel;
  }
}
