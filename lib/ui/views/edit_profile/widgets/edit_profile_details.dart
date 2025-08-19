import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/views/edit_profile/widgets/lables_text.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class EditProfileForm extends ViewModelWidget<EditProfileViewModel> {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context, EditProfileViewModel viewModel) {
    return SingleChildScrollView(
      child: userDetails!.userRole == 'culinarySchool'
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LablesText(text: 'Company Name'),
                        SemiRoundedTranpaentTextField(
                          suffixIcon: false,
                          controller: viewModel.nameController,
                          borderRadius: 27.dg,
                          labelText: '',
                        ),
                        verticalSpaceTiny,
                        const LablesText(text: 'Description'),

                        SemiRoundedTranpaentTextField(
                          suffixIcon: false,
                          maxLines: 5,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(250)
                          ],
                          controller: viewModel.bioController,
                          fillColor: kcPrimaryColor.withOpacity(0.08),
                          borderRadius: 27.dg,
                          labelText: 'Bio',
                        ),
                        // const LablesText(text: 'Email'),
                        //  Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //   decoration: BoxDecoration(
                        //     color: kcPrimaryColor.withOpacity(0.07),
                        //     borderRadius: BorderRadius.circular(27.dg),
                        //     // border: Border.all(color: filterIconColor),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 10),
                        //     child: Row(
                        //       children: [

                        //          Icon(
                        //           Icons.email_outlined,
                        //           color: kcBlackColor.withOpacity(0.4),
                        //           size: 16.0.dg,
                        //         ),
                        //         horizontalSpaceSmall,
                        //         Text(
                        //           viewModel.emailController.text,
                        //           style: globalTextStyle(
                        //             fontSize: 14.sp,
                        //             letterSpacing: -0.5,
                        //             fontWeight: FontWeight.w500,
                        //             color: kcBlackColor.withOpacity(0.5),
                        //           ),
                        //         ),
                        //       ],
                        //     ),),
                        // ),
                        verticalSpaceTiny,
                        const LablesText(text: 'Link'),

                        SemiRoundedTranpaentTextField(
                          suffixIcon: false,
                          prefixIcons: true,
                          borderRadius: 27.dg,
                          controller: viewModel.linkController,
                          prefixIcon: Icons.link,
                          size: 20,
                          labelText: '',
                        ),
                        verticalSpaceTiny,
                        const LablesText(text: 'Location'),
                        Visibility(
                          visible: viewModel.isChange == false,
                          child: SemiRoundedTranpaentTextField(
                            suffixIcon: false,
                            prefixIcons: false,
                            readOnly: true,
                            borderRadius: 27.dg,
                            controller: viewModel.location,
                            prefixIcon: Icons.link,
                            size: 20,
                            labelText: '',
                            suffixIconData: IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              color: filterIconColor,
                              onPressed: () {
                                viewModel.changeLocation();
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: viewModel.isChange == true,
                          child: CSCPickerPlus(
                            showStates: true,

                            showCities: true,

                            flagState: CountryFlag.DISABLE,

                            dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                              color: kcPrimaryColor.withOpacity(0.07),
                            ),

                            disabledDropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                              color: kcPrimaryColor.withOpacity(0.07),
                            ),

                            ///placeholders for dropdown search field
                            countrySearchPlaceholder: "Country",
                            stateSearchPlaceholder: "State",
                            citySearchPlaceholder: "City",

                            ///labels for dropdown
                            countryDropdownLabel: 'country*',
                            stateDropdownLabel: 'state*',
                            cityDropdownLabel: 'city*',

                            selectedItemStyle: globalTextStyle(
                                color: kcBlackColor.withOpacity(0.6),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),

                            ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                            dropdownHeadingStyle: globalTextStyle(
                              color: kcBlackColor.withOpacity(0.5),
                              fontSize: 17.sp,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                            ),

                            ///DropdownDialog Item style [OPTIONAL PARAMETER]
                            dropdownItemStyle: globalTextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 14.sp,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w400),

                            dropdownDialogRadius: 10.0,

                            searchBarRadius: 10.0,

                            onCountryChanged: (value) =>
                                viewModel.setCountryValue(value),

                            ///triggers once state selected in dropdown
                            onStateChanged: (value) =>
                                viewModel.setStateValue(value ?? ''),

                            ///triggers once city selected in dropdown
                            onCityChanged: (value) =>
                                viewModel.setCityValue(value ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
                PrimaryColorRoundedElevatedButton(
                  100,
                  onPressed: viewModel.saveEditDetailsCullinary,
                  buttonText: 'Save',
                ),
              ],
            )
          : userDetails!.userRole == 'chef'
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: viewModel.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LablesText(text: 'Full Name'),
                            SemiRoundedTranpaentTextField(
                              suffixIcon: false,
                              controller: viewModel.nameController,
                              borderRadius: 27.dg,
                              labelText: '',
                            ),
                            verticalSpaceTiny,
                            const LablesText(text: 'Bio'),
                            SemiRoundedTranpaentTextField(
                              suffixIcon: false,
                              maxLines: 5,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(250)
                              ],
                              controller: viewModel.bioController,
                              fillColor: kcPrimaryColor.withOpacity(0.08),
                              labelText: 'Bio',
                            ),
                            verticalSpaceTiny,
                            const LablesText(text: 'Link'),
                            SemiRoundedTranpaentTextField(
                              suffixIcon: false,
                              prefixIcons: true,
                              borderRadius: 27.dg,
                              controller: viewModel.linkController,
                              prefixIcon: Icons.link,
                              size: 20,
                              labelText: '',
                            ),
                            verticalSpaceTiny,
                            const LablesText(text: 'Boat Name'),
                            SemiRoundedTranpaentTextField(
                              suffixIcon: false,
                              prefixIcons: false,
                              borderRadius: 27.dg,
                              controller: viewModel.boatController,
                              labelText: '',
                            ),
                            verticalSpaceTiny,
                            const LablesText(text: 'Location'),
                            Visibility(
                              visible: viewModel.isChange == false,
                              child: SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                prefixIcons: false,
                                readOnly: true,
                                borderRadius: 27.dg,
                                controller: viewModel.location,
                                prefixIcon: Icons.link,
                                size: 20,
                                labelText: '',
                                suffixIconData: IconButton(
                                  icon: const Icon(Icons.edit_outlined),
                                  color: filterIconColor,
                                  onPressed: () {
                                    viewModel.changeLocation();
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: viewModel.isChange == true,
                              child: CSCPickerPlus(
                                showStates: true,

                                showCities: true,

                                flagState: CountryFlag.DISABLE,

                                dropdownDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r)),
                                  color: kcPrimaryColor.withOpacity(0.07),
                                ),

                                disabledDropdownDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r)),
                                  color: kcPrimaryColor.withOpacity(0.07),
                                ),

                                ///placeholders for dropdown search field
                                countrySearchPlaceholder: "Country",
                                stateSearchPlaceholder: "State",
                                citySearchPlaceholder: "City",

                                ///labels for dropdown
                                countryDropdownLabel: 'country*',
                                stateDropdownLabel: 'state*',
                                cityDropdownLabel: 'city*',

                                selectedItemStyle: globalTextStyle(
                                    color: kcBlackColor.withOpacity(0.5),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),

                                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                dropdownHeadingStyle: globalTextStyle(
                                  color: kcBlackColor.withOpacity(0.5),
                                  fontSize: 17.sp,
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w400,
                                ),

                                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                dropdownItemStyle: globalTextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 14.sp,
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.w400),

                                dropdownDialogRadius: 10.0,

                                searchBarRadius: 10.0,

                                onCountryChanged: (value) =>
                                    viewModel.setCountryValue(value),

                                ///triggers once state selected in dropdown
                                onStateChanged: (value) =>
                                    viewModel.setStateValue(value ?? ''),

                                ///triggers once city selected in dropdown
                                onCityChanged: (value) =>
                                    viewModel.setCityValue(value ?? ''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    PrimaryColorRoundedElevatedButton(
                      100.w,
                      onPressed: viewModel.saveEditDetailsChef,
                      buttonText: 'Save',
                    ),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: viewModel.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LablesText(text: 'Full Name'),
                            SemiRoundedTranpaentTextField(
                              suffixIcon: false,
                              controller: viewModel.nameController,
                              borderRadius: 27.dg,
                              labelText: '',
                            ),
                            verticalSpaceTiny,
                            const LablesText(text: 'Bio'),
                            SemiRoundedTranpaentTextField(
                              maxLines: 5,
                              borderRadius: 27.dg,
                              suffixIcon: false,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(250)
                              ],
                              controller: viewModel.bioController,
                              fillColor: kcPrimaryColor.withOpacity(0.08),
                              labelText: 'Bio',
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    PrimaryColorRoundedElevatedButton(
                      100.w,
                      onPressed: () {
                        viewModel.saveEditDetailsGuest(
                            viewModel.nameController.text.isEmpty
                                ? UserdataServiceService.user.displayName!
                                : viewModel.nameController.text.isEmpty
                                    ? UserdataServiceService.user.displayName!
                                    : viewModel.nameController.text,
                            viewModel.bioController.text.isEmpty
                                ? UserdataServiceService.user.bio!
                                : viewModel.bioController.text);
                      },
                      buttonText: 'Save',
                    ),
                  ],
                ),
    );
  }
}
