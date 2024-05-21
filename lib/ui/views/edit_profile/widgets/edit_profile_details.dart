import 'package:csc_picker/csc_picker.dart';
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
                          prefixIcons: false,
                          borderRadius: 27.dg,
                          maxLength: 200,

                          maxLines: 5,
                          
                          controller: viewModel.bioController,
                          labelText: '',
                        ),
                        const LablesText(text: 'Email'),
                        SemiRoundedTranpaentTextField(
                          suffixIcon: false,
                          prefixIcons: true,
                          readOnly: true,
                          controller: viewModel.emailController,
                          borderRadius: 27.dg,
                          labelText: '',
                          prefixIcon: Icons.email_outlined,
                          size: 20,
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
                          child: CSCPicker(
                            key: ValueKey(viewModel.countryValue),
                            showStates: true,

                            showCities: true,

                            flagState: CountryFlag.DISABLE,

                            dropdownDecoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.withOpacity(0.2),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),

                            disabledDropdownDecoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.withOpacity(0.2),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),

                           
                            countrySearchPlaceholder: "Country",
                            stateSearchPlaceholder: "State",
                            citySearchPlaceholder: "City",

                            countryDropdownLabel: "Country*",
                            stateDropdownLabel: "State*",
                            cityDropdownLabel: "City*",

                            selectedItemStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14,
                            ),

                            dropdownHeadingStyle: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 17,
                                fontWeight: FontWeight.bold),

                            dropdownItemStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14,
                            ),

                            dropdownDialogRadius: 10.0,

                            searchBarRadius: 10.0,

                            onCountryChanged: (value) =>
                                viewModel.setCountryValue(value.toString()),

                            onStateChanged: (value) =>
                                viewModel.setStateValue(value.toString()),

                            onCityChanged: (value) =>
                                viewModel.setCityValue(value.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
                PrimaryColorRoundedElevatedButton(
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
                              prefixIcons: false,
                              borderRadius: 27.dg,
                              maxLength: 200,
                              maxLines: 5,
                              controller: viewModel.bioController,
                              labelText: '',
                            ),
                            const LablesText(text: 'Email'),
                            SemiRoundedTranpaentTextField(
                              suffixIcon: false,
                              prefixIcons: true,
                              controller: viewModel.emailController,
                              borderRadius: 27.dg,
                              labelText: '',
                              prefixIcon: Icons.email_outlined,
                              size: 20,
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
                              child: CSCPicker(
                                showStates: true,

                                showCities: true,

                                flagState: CountryFlag.DISABLE,

                                dropdownDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: Colors.grey.withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1)),

                                disabledDropdownDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: Colors.grey.withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1)),

                                ///placeholders for dropdown search field
                                countrySearchPlaceholder: "Country",
                                stateSearchPlaceholder: "State",
                                citySearchPlaceholder: "City",

                                ///labels for dropdown
                                countryDropdownLabel: 'country*',
                                stateDropdownLabel: 'state*',
                                cityDropdownLabel: 'city*',

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
                                    viewModel.setCountryValue(value.toString()),

                                ///triggers once state selected in dropdown
                                onStateChanged: (value) =>
                                    viewModel.setStateValue(value.toString()),

                                ///triggers once city selected in dropdown
                                onCityChanged: (value) =>
                                    viewModel.setCityValue(value.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    PrimaryColorRoundedElevatedButton(
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
                              suffixIcon: false,
                              prefixIcons: false,
                              borderRadius: 27.dg,
                              maxLength: 500,
                              maxLines: 5,
                              controller: viewModel.bioController,
                              labelText: '',
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    PrimaryColorRoundedElevatedButton(
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
