import 'package:csc_picker/csc_picker.dart';
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

                          
                        
                          CSCPicker(
                            showStates: true,

                            showCities: true,

                            flagState: CountryFlag.DISABLE,

                            dropdownDecoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.withOpacity(0.2),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),

                            disabledDropdownDecoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.withOpacity(0.2),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),

                            ///placeholders for dropdown search field
                            countrySearchPlaceholder: "Country",
                            stateSearchPlaceholder: "State",
                            citySearchPlaceholder: "City",

                            ///labels for dropdown
                            countryDropdownLabel: "*Country",
                            stateDropdownLabel: "*State",
                            cityDropdownLabel: "*City",

                            selectedItemStyle:  TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14,
                            ),

                            ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                            dropdownHeadingStyle:  TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 17,
                                fontWeight: FontWeight.bold),

                            ///DropdownDialog Item style [OPTIONAL PARAMETER]
                            dropdownItemStyle:  TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14,
                            ),

                            dropdownDialogRadius: 10.0,

                            searchBarRadius: 10.0,

                            onCountryChanged: (value) =>
                                viewModel.setCountryValue(value.toString()),

                            ///triggers once state selected in dropdown
                            onStateChanged: (value) =>
                                viewModel.setStateValue(value.toString()),

                            ///triggers once city selected in dropdown
                            onCityChanged: (value) =>
                                viewModel.setCityValue(value.toString()),
                          ),
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
                              CSCPicker(
                                showStates: true,

                                showCities: true,

                                flagState: CountryFlag.DISABLE,

                                dropdownDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.grey.withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1)),

                                disabledDropdownDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.grey.withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1)),

                                ///placeholders for dropdown search field
                                countrySearchPlaceholder: "Country",
                                stateSearchPlaceholder: "State",
                                citySearchPlaceholder: "City",

                                ///labels for dropdown
                                countryDropdownLabel: "*Country",
                                stateDropdownLabel: "*State",
                                cityDropdownLabel: "*City",

                                selectedItemStyle:  TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 14,
                                ),

                                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                dropdownHeadingStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),

                                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                dropdownItemStyle:  TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 14,
                                ),

                                dropdownDialogRadius: 10.0,

                                searchBarRadius: 10.0,

                                onCountryChanged: (value) =>
                                    viewModel.setCountryValue(value.toString()),

                                ///triggers once state selected in dropdown
                                onStateChanged: (value) =>
                                    viewModel.setStateValue(value.toString()),

                                ///triggers once city selected in dropdown
                                onCityChanged: (value) =>
                                    viewModel.setCityValue(value.toString()),
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
