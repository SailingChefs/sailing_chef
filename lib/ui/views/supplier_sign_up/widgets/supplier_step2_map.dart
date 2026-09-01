import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/supplier_sign_up/supplier_sign_up_viewmodel.dart';

class SupplierStep2Map extends ViewModelWidget<SupplierSignUpViewModel> {
  const SupplierStep2Map({super.key});

  @override
  Widget build(BuildContext context, SupplierSignUpViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
          child: Text(
            'Drag the map to place your pin at your exact business location.',
            style: globalTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: kcBlackColor.withOpacity(0.55),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                buildingsEnabled: false,
                initialCameraPosition: viewModel.initialCameraPosition,
                onMapCreated: (controller) {
                  viewModel.mapController = controller;
                },
                onCameraMove: viewModel.onCameraMove,
              ),
              // Fixed centre pin
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 36),
                  child: Icon(
                    Icons.location_pin,
                    color: kcPrimaryColor,
                    size: 48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
