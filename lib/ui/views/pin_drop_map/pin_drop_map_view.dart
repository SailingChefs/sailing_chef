import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/bottom_buttons.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/pin_detail_list.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/tags.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/topbar_search.dart';
import 'package:uuid/uuid.dart';

class PinDropMapView extends StackedView<PinDropMapViewModel> {
  const PinDropMapView({super.key});

  @override
  Widget builder(
    BuildContext context,
    PinDropMapViewModel viewModel,
    Widget? child,
  ) {
    final markerId = const Uuid().v4();
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
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            buildingsEnabled: false,
                            myLocationButtonEnabled: false,
                            onCameraMove: (position) {
                              viewModel.onCameraMove(position);
                            },
                            onCameraIdle: () {
                              viewModel.showBottomSheet();
                            },
                            initialCameraPosition: viewModel.initialCameraPosition!,
                            onMapCreated: (controller) {
                              viewModel.controllermap = controller;
                            },
                            markers: viewModel.allMarkers.values.toSet(),
                          ),
                          if (viewModel.showMarker)
                            Center(
                              child: SvgPicture.asset(
                                'assets/images/misc/location.svg',
                                height: 40,
                                width: 40,
                              ),
                            )
                          else
                            const SizedBox.shrink(),
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
                        onTap: viewModel.showPindropDialogueBox,
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
                if (viewModel.showBottomButtons && viewModel.showMarker)
                  const Positioned(
                    bottom: 0,
                    child: BottomButtonPinsDropView(
                        // isNew: true,
                        ),
                  )
                else
                  Container(),
                if (viewModel.showList ||
                    viewModel.totalFilters != 0 && viewModel.allMarkers.isNotEmpty)
                  Positioned(
                    bottom: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: const PinDetailList(),
                    ),
                  )
                else
                  Container(),
                if (viewModel.isSelected)
                  Container()
                else
                  TagsSelectionWidget(
                    id: markerId,
                  ),
              ],
            ),
          );
  }

  @override
  void onViewModelReady(PinDropMapViewModel viewModel) {
    final markerId = const Uuid().v4();

    viewModel.onViewModelReady(markerId);
    super.onViewModelReady(viewModel);
  }

  @override
  PinDropMapViewModel viewModelBuilder(
    BuildContext context,
  ) {
    return PinDropMapViewModel();
  }
}
