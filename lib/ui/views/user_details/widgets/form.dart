import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class FormUserDetailsScrenn extends ViewModelWidget<UserDetailsViewModel> {
  const FormUserDetailsScrenn({required this.userRole, super.key});
  final String userRole;
  @override
  Widget build(BuildContext context, UserDetailsViewModel viewModel) {
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
                if (userRole == 'chef')
                  Column(
                    children: [
                      SemiRoundedTranpaentTextField(
                        validator: (value) => viewModel.validateName(value),
                        controller: viewModel.nameController,
                        labelText: 'Name',
                        suffixIcon: false,
                      ),
                      verticalSpaceSmall,
                      SemiRoundedTranpaentTextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200)
                        ],
                        maxLines: 5,
                        suffixIcon: false,
                        validator: (value) => viewModel.validateBio(value),
                        fillColor: kcPrimaryColor.withOpacity(0.09),
                        controller: viewModel.bioController,
                        labelText: 'Bio',
                        // focusNode: viewModel.bioFocusNode,
                      ),
                      verticalSpaceSmall,
                      SemiRoundedTranpaentTextField(
                          // validator: (value) =>
                          //     viewModel.validateLink(value),
                          controller: viewModel.linkController,
                          suffixIcon: false,
                          labelText: 'Link'),
                      verticalSpaceSmall,
                      SemiRoundedTranpaentTextField(
                          suffixIcon: false,
                          // validator: (value) =>
                          //     viewModel.validateBoatName(value),
                          controller: viewModel.boatNameController,
                          labelText: 'Boat Name '),
                      verticalSpaceSmall,
                      CSCPickerPlus(
                        flagState: CountryFlag.DISABLE,

                        dropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: kcPrimaryColor.withOpacity(0.09),
                        ),

                        disabledDropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: kcPrimaryColor.withOpacity(0.09),
                        ),

                        ///placeholders for dropdown search field
                        countrySearchPlaceholder: 'Country',
                        stateSearchPlaceholder: 'State',
                        citySearchPlaceholder: 'City',

                        selectedItemStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14,
                        ),

                        ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                        dropdownHeadingStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),

                        ///DropdownDialog Item style [OPTIONAL PARAMETER]
                        dropdownItemStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14,
                        ),

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
                    ],
                  )
                else
                  (userRole == 'culinarySchool')
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
                            SemiRoundedTranpaentTextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(200)
                                ],
                                maxLines: 5,
                                suffixIcon: false,
                                fillColor: kcPrimaryColor.withOpacity(0.09),
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
                            CSCPickerPlus(
                              flagState: CountryFlag.DISABLE,

                              dropdownDecoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: kcPrimaryColor.withOpacity(0.09),
                              ),

                              disabledDropdownDecoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: kcPrimaryColor.withOpacity(0.09),
                              ),

                              ///placeholders for dropdown search field
                              countrySearchPlaceholder: 'Country',
                              stateSearchPlaceholder: 'State',
                              citySearchPlaceholder: 'City',

                              ///labels for dropdown
                              countryDropdownLabel: '*Country',
                              stateDropdownLabel: '*State',
                              cityDropdownLabel: '*City',

                              selectedItemStyle: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 14,
                              ),

                              ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                              dropdownHeadingStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),

                              ///DropdownDialog Item style [OPTIONAL PARAMETER]
                              dropdownItemStyle: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 14,
                              ),

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
                            SemiRoundedTranpaentTextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(200)
                                ],
                                maxLines: 5,
                                suffixIcon: false,
                                fillColor: kcPrimaryColor.withOpacity(0.09),
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
        verticalSpaceMedium,
        PrimaryColorRoundedElevatedButton(
          100.w,
          onPressed: () {
            if (userRole == 'chef' || userRole == 'culinarySchool') {
              if (viewModel.formKey.currentState!.validate()) {
                viewModel.saveUserDetails();
              }
            } else {
              viewModel.saveguestDetails();
            }
          },
          buttonText: 'SAVE',
        ),
      ],
    );
  }
}
