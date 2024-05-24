import 'package:csc_picker/csc_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/becomechef/becomechef_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class BecomeChefForm extends ViewModelWidget<BecomechefViewModel> {
  const BecomeChefForm({super.key});

  @override
  Widget build(BuildContext context, BecomechefViewModel viewModel) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  SemiRoundedTranpaentTextField(
                      validator: (value) => viewModel.validateLink(value),
                      controller: viewModel.linkController,
                      suffixIcon: false,
                      labelText: 'Link'),
                  verticalSpaceMedium,
                  SemiRoundedTranpaentTextField(
                      validator: (value) => viewModel.validateBoatName(value),
                      controller: viewModel.boatNameController,
                      suffixIcon: false,
                      labelText: 'Boat Name'),
                  verticalSpaceMedium,
                  CSCPicker(
                    showStates: true,

                    showCities: true,

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
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: "*Country",
                    stateDropdownLabel: "*State",
                    cityDropdownLabel: "*City",

                    selectedItemStyle: globalTextStyle(
                      color: kcBlackColor.withOpacity(0.6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),

                    ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                    dropdownHeadingStyle: globalTextStyle(
                        color: kcBlackColor.withOpacity(0.6),
                        fontSize: 14.sp,
                       fontWeight: FontWeight.w500,),

                    ///DropdownDialog Item style [OPTIONAL PARAMETER]
                    dropdownItemStyle: globalTextStyle(
                      color: kcBlackColor.withOpacity(0.6),
                        fontSize: 14.sp,
                       fontWeight: FontWeight.w500,
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
                  verticalSpaceMedium,
                  PrimaryColorRoundedElevatedButton(
                    onPressed: () {
                      viewModel.saveEditDetails();
                    },
                    buttonText: 'Save',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
