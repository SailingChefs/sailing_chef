import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class FormUserDetailsScrenn extends ViewModelWidget<UserDetailsViewModel> {
  const FormUserDetailsScrenn({required this.userRole, super.key});
  final String userRole;

  Widget _buildLocationPicker(UserDetailsViewModel viewModel) {
    if (viewModel.useManualLocationInputs) {
      return Column(
        children: [
          CSCPickerPlus(
            flagState: CountryFlag.DISABLE,
            showStates: false,
            showCities: false,
            currentCountry: viewModel.countryValue.isEmpty ? null : viewModel.countryValue,
            dropdownDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: kcPrimaryColor.withOpacity(0.09),
            ),
            disabledDropdownDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: kcPrimaryColor.withOpacity(0.09),
            ),
            countrySearchPlaceholder: 'Country',
            countryDropdownLabel: '  *Country',
            selectedItemStyle: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 14,
              height: 2,
            ),
            dropdownHeadingStyle: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            dropdownItemStyle: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 14,
            ),
            dropdownDialogRadius: 10.0,
            searchBarRadius: 10.0,
            onCountryChanged: (value) => viewModel.setCountryValue(value),
          ),
          verticalSpaceSmall,
          SemiRoundedTranpaentTextField(
            suffixIcon: false,
            controller: viewModel.manualStateController,
            labelText: 'State*',
            onChanged: viewModel.setManualStateValue,
          ),
          verticalSpaceSmall,
          SemiRoundedTranpaentTextField(
            suffixIcon: false,
            controller: viewModel.manualCityController,
            labelText: 'City*',
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
      dropdownDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: kcPrimaryColor.withOpacity(0.09),
      ),
      disabledDropdownDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: kcPrimaryColor.withOpacity(0.09),
      ),
      countrySearchPlaceholder: 'Country',
      stateSearchPlaceholder: 'State',
      citySearchPlaceholder: 'City',
      countryDropdownLabel: '  *Country',
      stateDropdownLabel: '  *State',
      cityDropdownLabel: '  *City',
      selectedItemStyle: TextStyle(
        color: Colors.black.withOpacity(0.6),
        fontSize: 14,
        height: 2,
      ),
      dropdownHeadingStyle: TextStyle(
        color: Colors.black.withOpacity(0.6),
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      dropdownItemStyle: TextStyle(
        color: Colors.black.withOpacity(0.6),
        fontSize: 14,
      ),
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,
      onCountryChanged: (value) => viewModel.setCountryValue(value),
      onStateChanged: (value) => viewModel.setStateValue(value ?? ''),
      onCityChanged: (value) => viewModel.setCityValue(value ?? ''),
    );
  }

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
                        inputFormatters: [LengthLimitingTextInputFormatter(200)],
                        maxLines: 5,
                        suffixIcon: false,
                        validator: (value) => viewModel.validateBio(value),
                        fillColor: kcPrimaryColor.withOpacity(0.09),
                        controller: viewModel.bioController,
                        labelText: 'Bio',
                        spellCheckOn: true,
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
                      _buildLocationPicker(viewModel),
                    ],
                  )
                else if (userRole == 'supplier')
                  _SupplierForm(viewModel: viewModel)
                else
                  (userRole == 'culinarySchool')
                      ? Column(
                          children: [
                            SemiRoundedTranpaentTextField(
                              validator: (value) => viewModel.validateName(value),
                              controller: viewModel.nameController,
                              labelText: 'Company Name',
                              suffixIcon: false,
                            ),
                            verticalSpaceSmall,
                            SemiRoundedTranpaentTextField(
                                inputFormatters: [LengthLimitingTextInputFormatter(200)],
                                maxLines: 5,
                                suffixIcon: false,
                                fillColor: kcPrimaryColor.withOpacity(0.09),
                                validator: (value) => viewModel.validateBio(value),
                                controller: viewModel.bioController,
                                labelText: 'Description'),
                            verticalSpaceSmall,
                            SemiRoundedTranpaentTextField(
                                validator: (value) => viewModel.validateLink(value),
                                controller: viewModel.linkController,
                                suffixIcon: false,
                                labelText: 'Link'),
                            verticalSpaceSmall,
                            _buildLocationPicker(viewModel),
                          ],
                        )
                      : Column(
                          children: [
                            SemiRoundedTranpaentTextField(
                              validator: (value) => viewModel.validateName(value),
                              controller: viewModel.nameController,
                              labelText: 'Name',
                              suffixIcon: false,
                            ),
                            verticalSpaceSmall,
                            SemiRoundedTranpaentTextField(
                              inputFormatters: [LengthLimitingTextInputFormatter(200)],
                              maxLines: 5,
                              suffixIcon: false,
                              fillColor: kcPrimaryColor.withOpacity(0.09),
                              validator: (value) => viewModel.validateBio(value),
                              controller: viewModel.bioController,
                              labelText: 'Bio',
                              spellCheckOn: true,
                            ),
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
            if (userRole == 'supplier') {
              viewModel.saveSupplierDetails();
            } else if (userRole == 'chef' || userRole == 'culinarySchool') {
              viewModel.saveUserDetails();
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

// ─── Supplier-specific form fields ───────────────────────────────────────────

class _SupplierForm extends ViewModelWidget<UserDetailsViewModel> {
  final UserDetailsViewModel viewModel;
  const _SupplierForm({required this.viewModel});

  static const _categories = [
    'Fresh Produce',
    'Seafood & Fish',
    'Dairy & Eggs',
    'Meat & Poultry',
    'Beverages',
    'Dry Goods & Pantry',
    'Equipment & Tools',
    'Safety & Marine',
    'Spices & Condiments',
    'Other',
  ];

  @override
  Widget build(BuildContext context, UserDetailsViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SemiRoundedTranpaentTextField(
          validator: (value) => vm.validateName(value),
          controller: vm.nameController,
          labelText: 'Business Name*',
          suffixIcon: false,
        ),
        verticalSpaceSmall,
        DropdownButtonFormField<String>(
          value: vm.businessCategory.isEmpty ? null : vm.businessCategory,
          decoration: InputDecoration(
            labelText: 'Category*',
            labelStyle: TextStyle(color: kcBlackColor.withOpacity(0.6)),
            filled: true,
            fillColor: kcPrimaryColor.withOpacity(0.09),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          items: _categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (val) => val != null ? vm.setBusinessCategory(val) : null,
          validator: (val) => (val == null || val.isEmpty) ? 'Please select a category' : null,
        ),
        verticalSpaceSmall,
        SemiRoundedTranpaentTextField(
          controller: vm.contactController,
          labelText: 'Contact Number*',
          suffixIcon: false,
          keyboardType: TextInputType.phone,
          validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter a contact number' : null,
        ),
        verticalSpaceSmall,
        SemiRoundedTranpaentTextField(
          controller: vm.linkController,
          suffixIcon: false,
          labelText: 'Website',
        ),
        verticalSpaceSmall,
        SemiRoundedTranpaentTextField(
          inputFormatters: [LengthLimitingTextInputFormatter(300)],
          maxLines: 4,
          suffixIcon: false,
          fillColor: kcPrimaryColor.withOpacity(0.09),
          controller: vm.bioController,
          labelText: 'Description',
          spellCheckOn: true,
        ),
      ],
    );
  }
}
