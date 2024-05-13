import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/user_details/widgets/semibio.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class FormUserDetailsScrenn extends ViewModelWidget<UserDetailsViewModel> {
  const FormUserDetailsScrenn({required this.userRole, super.key});
  final String userRole;
  @override
  Widget build(BuildContext context, UserDetailsViewModel viewModel) {
    bool islocationempty = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                verticalSpaceMedium,
                (userRole == 'chef')
                    ? Column(
                        children: [
                          SemiRoundedTranpaentTextField(
                            validator: (value) => viewModel.validateName(value),
                            controller: viewModel.nameController,
                            labelText: 'Name',
                            suffixIcon: false,
                          ),
                          verticalSpaceSmall,
                          SemiRoundedTranpaentTextFieldBio(
                            validator: (value) => viewModel.validateBio(value),
                            controller: viewModel.bioController,
                            labelText: 'Bio',
                          ),
                          verticalSpaceSmall,
                          SemiRoundedTranpaentTextField(
                              validator: (value) =>
                                  viewModel.validateLink(value),
                              controller: viewModel.linkController,
                              suffixIcon: false,
                              labelText: 'Link*'),
                          verticalSpaceSmall,
                          SemiRoundedTranpaentTextField(
                              suffixIcon: false,
                              validator: (value) =>
                                  viewModel.validateBoatName(value),
                              controller: viewModel.boatNameController,
                              labelText: 'Boat Name*'),
                          verticalSpaceSmall,
                          GestureDetector(
                            onTap: viewModel.getLocation,
                            child: Container(
                              height: 45.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0.dg),
                                child: Text(
                                  viewModel.locationController.text.isNotEmpty
                                      ? viewModel.locationController.text
                                      : 'Location',
                                  style: globalTextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: kcBlackColor.withOpacity(0.6)),
                                ),
                              ),
                            ),
                          ),
                          verticalSpaceTiny,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Text(
                                '*optional',
                                style: globalTextStyle(
                                    fontSize: 14.sp,
                                    color: editIconColor.withOpacity(0.6),
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      )
                    : (userRole == 'culinarySchool')
                        ? Column(
                            children: [
                              SemiRoundedTranpaentTextField(
                                validator: (value) =>
                                    viewModel.validateName(value),
                                controller: viewModel.nameController,
                                labelText: 'Company Name',
                                suffixIcon: false,
                              ),
                              verticalSpaceSmall,
                              SemiRoundedTranpaentTextFieldBio(
                                  validator: (value) =>
                                      viewModel.validateBio(value),
                                  controller: viewModel.bioController,
                                  labelText: 'Description'),
                              verticalSpaceSmall,
                              SemiRoundedTranpaentTextField(
                                  validator: (value) =>
                                      viewModel.validateLink(value),
                                  controller: viewModel.linkController,
                                  suffixIcon: false,
                                  labelText: 'Link'),
                              verticalSpaceSmall,
                              GestureDetector(
                                onTap: viewModel.getLocation,
                                // child: GooglePlaceAutoCompleteTextField(
                                //   textEditingController:
                                //       viewModel.locationController,

                                //   googleAPIKey:
                                //       "AIzaSyDGaiYFveXnwbag-ORPYbsV6m3XuWsX1jk",
                                //   inputDecoration: const InputDecoration(
                                //     hintText: "Search your location",
                                //     border: InputBorder.none,
                                //     enabledBorder: InputBorder.none,
                                //   ),
                                //   debounceTime: 400,
                                //   isLatLngRequired: true,
                                //   getPlaceDetailWithLatLng:
                                //       (Prediction prediction) {
                                //     viewModel.latitude = prediction.lat;
                                //     viewModel.longitude = prediction.lng;
                                //   },
                                //   itemClick: (Prediction prediction) {
                                //     viewModel.locationController.text =
                                //         prediction.description ?? "";
                                //     viewModel.locationController.selection =
                                //         TextSelection.fromPosition(TextPosition(
                                //             offset: prediction
                                //                     .description?.length ??
                                //                 0));
                                //   },
                                //   seperatedBuilder: const Divider(),

                                //   itemBuilder:
                                //       (context, index, Prediction prediction) {
                                //     return Container(
                                //       padding: const EdgeInsets.all(10),
                                //       child: Row(
                                //         children: [
                                //           const Icon(Icons.location_on),
                                //           const SizedBox(
                                //             width: 7,
                                //           ),
                                //           Expanded(
                                //               child: Text(
                                //                   prediction.description ?? ""))
                                //         ],
                                //       ),
                                //     );
                                //   },
                                //   isCrossBtnShown: true,
                                // ),
                                child: Container(
                                  height: 45.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0.dg),
                                    child: Text(
                                      viewModel.locationController.text
                                              .isNotEmpty
                                          ? viewModel.locationController.text
                                          : 'Location',
                                      style: globalTextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: kcBlackColor.withOpacity(0.6)),
                                    ),
                                  ),
                                ),
                              ),
                              // GooglePlaceAutoCompleteTextField(
                              //   textEditingController:
                              //       viewModel.locationController,
                              //   googleAPIKey:
                              //       'AIzaSyDGaiYFveXnwbag-ORPYbsV6m3XuWsX1jk',
                              //   inputDecoration: const InputDecoration(
                              //     hintText: "Search your location",
                              //     contentPadding: const EdgeInsets.only(left: 10.0),
                              //     border: InputBorder.none,
                              //     enabledBorder: InputBorder.none,
                              //   ),
                              //   debounceTime: 400,
                              //   isLatLngRequired: true,
                              //   getPlaceDetailWithLatLng: viewModel.onLocationChanged,
                              //   itemClick: viewModel.onLocationItemClicked,
                              //   // itemClick: (Prediction prediction) {
                              //   //   viewModel.locationController.text =
                              //   //       prediction.description ?? "";
                              //   //   viewModel.locationController.selection =
                              //   //       TextSelection.fromPosition(
                              //   //     TextPosition(
                              //   //         offset:
                              //   //             prediction.description?.length ??
                              //   //                 0),
                              //   //   );
                              //   // },
                              //   seperatedBuilder: const Divider(),
                              //   itemBuilder:
                              //       (context, index, Prediction prediction) {
                              //     return Container(
                              //       padding: const EdgeInsets.all(10),
                              //       child: Row(
                              //         children: [
                              //           const Icon(Icons.location_on),
                              //           const SizedBox(width: 7),
                              //           Expanded(
                              //               child: Text(
                              //                   prediction.description ?? "")),
                              //         ],
                              //       ),
                              //     );
                              //   },
                              //   isCrossBtnShown: true,
                              // ),
                            ],
                          )
                        : Column(
                            children: [
                              SemiRoundedTranpaentTextField(
                                validator: (value) =>
                                    viewModel.validateName(value),
                                controller: viewModel.nameController,
                                labelText: 'Name',
                                suffixIcon: false,
                              ),
                              verticalSpaceSmall,
                              SemiRoundedTranpaentTextFieldBio(
                                  validator: (value) =>
                                      viewModel.validateBio(value),
                                  controller: viewModel.bioController,
                                  labelText: 'Bio'),
                              verticalSpaceMedium,
                            ],
                          ),
              ],
            ),
          ),
        ),
        verticalSpaceMassive,
        PrimaryColorRoundedElevatedButton(
          onPressed: () {
            if (userRole == 'chef' || userRole == 'culinarySchool') {
              if (viewModel.formKey.currentState!.validate()) {
                if (viewModel.locationController.text.isEmpty) {
                  log('location empty');
                  islocationempty = false;
                } else {
                  islocationempty = true;
                }
                viewModel.saveUserDetails();
              }
            } else {
              viewModel.saveUserDetails();
            }
          },
          buttonText: 'SAVE',
        ),
      ],
    );
  }
}
