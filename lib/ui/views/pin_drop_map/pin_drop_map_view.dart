// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/topbar_search.dart';

import 'pin_drop_map_viewmodel.dart';
import 'widgets/tags.dart';

class PinDropMapView extends StackedView<PinDropMapViewModel> {
  const PinDropMapView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PinDropMapViewModel viewModel,
    Widget? child,
  ) {
    String markerId = Uuid().v4();
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Column(
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
                        zoomControlsEnabled: false,
                        onTap: (value) async {
                          final res = await viewModel.bottomSheetService
                              .showCustomSheet(
                            variant: BottomSheetType.dropPinButtons,
                          );
                          if (res?.data == null || res?.data == false) return;
                          final res2 = await viewModel.bottomSheetService
                              .showCustomSheet(
                                  variant: BottomSheetType.dropPinSheet,
                                  data: LatLng(
                                      viewModel.currentPosition!.latitude,
                                      viewModel.currentPosition!.longitude));
                          if (res?.data == null ||
                              res?.data == false && res2?.data == false ||
                              res2?.data == null) return;

                          viewModel.value != value;
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
                          viewModel.showAllMarkers(markerId);
                        },
                        markers: viewModel.allMarkers.values.toSet(),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 40,
                  right: 40,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          viewModel.addMarkers(
                            
                              markerId,
                              LatLng(viewModel.currentPosition!.latitude,
                                  viewModel.currentPosition!.longitude));
                        },
                        child: SvgPicture.asset(
                          'assets/images/icons/icon_add.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      verticalSpaceMedium,
                      SvgPicture.asset(
                        'assets/images/icons/share.svg',
                        width: 40,
                        height: 40,
                      ),
                      verticalSpaceLarge,
                    ],
                  ),
                ),
                viewModel.isSelected
                    ? Container()
                    : TagsSelectionWidget(
                        id: markerId,
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
