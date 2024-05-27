import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/bottom_buttons.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/pin_detail_list.dart';
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
    String markerId = const Uuid().v4();
    return viewModel.isBusy
        ? const Center(
            child: CircularProgressIndicator(
            color: kcPrimaryColor,
          ))
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
                      child: Stack(
                        children: [
                          GoogleMap(
                            onTap: (argument) => viewModel.onMapTap(),
                            mapType: MapType.normal,
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                            onCameraMove: (position) {
                              log('onCameraMove: $position');
                              //  viewModel.showAllMarkers(markerId);
                              viewModel.onCameraMove(position);
                            },
                            onCameraIdle: () async {
                              viewModel.showBottomSheet();
                            },
                            initialCameraPosition:
                                viewModel.initialCameraPosition!,
                            onMapCreated: (controller) {
                              viewModel.controllermap = controller;

                              viewModel.showAllMarkers(markerId);
                            },
                            markers: viewModel.allMarkers.values.toSet(),
                          ),
                          viewModel.showMarker
                              ? Center(
                                  child: SvgPicture.asset(
                                    'assets/images/misc/location.svg',
                                    height: 40,
                                    width: 40,
                                  ),
                                )
                              : Container(),
                        ],
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
                        onTap:
                          viewModel.showPindropDialogueBox,
                        child: SvgPicture.asset(
                          'assets/images/icons/icon_add.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      verticalSpaceMedium,
                      GestureDetector(
                        onTap: viewModel.showMyLocation,
                        child: SvgPicture.asset(
                          'assets/images/icons/share.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      verticalSpaceLarge,
                    ],
                  ),
                ),
                viewModel.showBottomButtons == true &&
                        viewModel.showMarker == true
                    ? const Positioned(
                        bottom: 0,
                        child: BottomButtonPinsDropView(),
                      )
                    : Container(),
                viewModel.showList == true
                    ? Positioned(
                        bottom: 10,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: const PinDetailList(),
                        ),
                      )
                    : Container(),
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
