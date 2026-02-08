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

  Widget _buildLocationInputs(EditProfileViewModel viewModel,
      {required double selectedTextOpacity}) {
    final pickerDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
      color: kcPrimaryColor.withOpacity(0.07),
    );

    final selectedStyle = globalTextStyle(
      color: kcBlackColor.withOpacity(selectedTextOpacity),
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      height: 2,
    );

    final headingStyle = globalTextStyle(
      color: kcBlackColor.withOpacity(0.5),
      fontSize: 17.sp,
      letterSpacing: -0.5,
      fontWeight: FontWeight.w400,
    );

    final itemStyle = globalTextStyle(
      color: Colors.black.withOpacity(0.4),
      fontSize: 14.sp,
      letterSpacing: -0.5,
      fontWeight: FontWeight.w400,
    );

    if (viewModel.useManualLocationInputs) {
      return Column(
        children: [
          CSCPickerPlus(
            flagState: CountryFlag.DISABLE,
            showStates: false,
            showCities: false,
            currentCountry: viewModel.countryValue.isEmpty ? null : viewModel.countryValue,
            dropdownDecoration: pickerDecoration,
            disabledDropdownDecoration: pickerDecoration,
            countrySearchPlaceholder: 'Country',
            countryDropdownLabel: '  Country*',
            selectedItemStyle: selectedStyle,
            dropdownHeadingStyle: headingStyle,
            dropdownItemStyle: itemStyle,
            dropdownDialogRadius: 10.0,
            searchBarRadius: 10.0,
            onCountryChanged: (value) {
              viewModel.setCountryValue(value);
            },
          ),
          verticalSpaceTiny,
          SemiRoundedTranpaentTextField(
            suffixIcon: false,
            borderRadius: 27.dg,
            controller: viewModel.manualStateController,
            labelText: 'State*',
            textColor: viewModel.manualStateController.text.isNotEmpty
                ? Colors.black.withOpacity(0.8)
                : Colors.black.withOpacity(0.4),
            onChanged: viewModel.setManualStateValue,
          ),
          verticalSpaceSmall,
          SemiRoundedTranpaentTextField(
            suffixIcon: false,
            borderRadius: 27.dg,
            controller: viewModel.manualCityController,
            labelText: 'City*',
            textColor: viewModel.manualCityController.text.isNotEmpty
                ? Colors.black.withOpacity(0.8)
                : Colors.black.withOpacity(0.4),
            onChanged: viewModel.setManualCityValue,
          ),
        ],
      );
    }

    return CSCPickerPlus(
      flagState: CountryFlag.DISABLE,
      currentCountry: viewModel.countryValue.isEmpty ? null : viewModel.countryValue,
      currentState: viewModel.stateValue.isEmpty ? null : viewModel.stateValue,
      currentCity: viewModel.cityValue.isEmpty ? null : viewModel.cityValue,
      dropdownDecoration: pickerDecoration,
      disabledDropdownDecoration: pickerDecoration,
      countrySearchPlaceholder: 'Country',
      stateSearchPlaceholder: 'State',
      citySearchPlaceholder: 'City',
      countryDropdownLabel: '  Country*',
      stateDropdownLabel: '  State*',
      cityDropdownLabel: '  City*',
      selectedItemStyle: selectedStyle,
      dropdownHeadingStyle: headingStyle,
      dropdownItemStyle: itemStyle,
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,
      onCountryChanged: (value) {
        viewModel.setCountryValue(value);
      },
      onStateChanged: (value) => viewModel.setStateValue(value ?? ''),
      onCityChanged: (value) => viewModel.setCityValue(value ?? ''),
    );
  }

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
                          inputFormatters: [LengthLimitingTextInputFormatter(250)],
                          controller: viewModel.bioController,
                          fillColor: kcPrimaryColor.withOpacity(0.08),
                          borderRadius: 27.dg,
                          labelText: 'Bio',
                          spellCheckOn: true,
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
                          visible: !viewModel.isChange,
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
                          visible: viewModel.isChange,
                          child: _buildLocationInputs(
                            viewModel,
                            selectedTextOpacity: 0.8,
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
                              inputFormatters: [LengthLimitingTextInputFormatter(250)],
                              controller: viewModel.bioController,
                              fillColor: kcPrimaryColor.withOpacity(0.08),
                              labelText: 'Bio',
                              spellCheckOn: true,
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
                              visible: !viewModel.isChange,
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
                              visible: viewModel.isChange,
                              child: _buildLocationInputs(
                                viewModel,
                                selectedTextOpacity: 0.8,
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
                              inputFormatters: [LengthLimitingTextInputFormatter(250)],
                              controller: viewModel.bioController,
                              fillColor: kcPrimaryColor.withOpacity(0.08),
                              labelText: 'Bio',
                              spellCheckOn: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    PrimaryColorRoundedElevatedButton(
                      100.w,
                      onPressed: () {
                        final name = viewModel.nameController.text.trim();
                        final bio = viewModel.bioController.text.trim();

                        viewModel.saveEditDetailsGuest(
                            name.isEmpty ? (UserdataServiceService.user.displayName ?? '') : name,
                            bio.isEmpty ? (UserdataServiceService.user.bio ?? '') : bio);
                      },
                      buttonText: 'Save',
                    ),
                  ],
                ),
    );
  }
}
