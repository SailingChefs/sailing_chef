import 'package:firebase_auth/firebase_auth.dart';

import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

import '../../../core/imports/core_imports.dart';

class BecomechefViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  GlobalObjectKey<FormState> formKey = GlobalObjectKey<FormState>(UniqueKey());

  UserdataServiceService userDataService = locator<UserdataServiceService>();
  UserServices userService = locator<UserServices>();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController boatNameController = TextEditingController();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String? address;

  void onViewModelReady() async {
    setBusy(true);

    setBusy(false);
  }

  String? validateBoatName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }

    return null;
  }

  getBack() {
    _navigationService.back();
  }

  String? validateLink(String? value) {
    // Check if the input is null or empty
    if (value == null || value.isEmpty) {
      return 'Please enter a link';
    }

    // Use a regular expression for basic URL validation without protocol
    RegExp urlRegex = RegExp(
      r'^(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+(?:\/[\w/.]*)?$',
    );

    // Check if the input matches the URL pattern
    return urlRegex.hasMatch(value)
        ? null // Return null if the link is valid
        : 'Please enter a valid link';
  }

  void setCountryValue(String value) {
    countryValue = value;

    //
    rebuildUi();
  }

  void setStateValue(String? value) {
    if (value == 'state*') {
      stateValue = '';
      cityValue = '';

      rebuildUi();
    } else if (value == 'null') {
      stateValue = '';

      rebuildUi();
    } else if (value == null) {
      stateValue = '';

      rebuildUi();
    } else {
      stateValue = value;
      cityValue = '';
      rebuildUi();
    }

    rebuildUi();
  }

  void setCityValue(String? value) {
    if (value == 'city*') {
      cityValue = '';
      rebuildUi();
    } else if (value == 'null') {
      cityValue = '';
      rebuildUi();
    } else if (value == null) {
      cityValue = '';
      rebuildUi();
    } else {
      cityValue = value;
      rebuildUi();
    }
    if (countryValue != '' && stateValue == '' && cityValue == '') {
      address = countryValue;
    }
    if (countryValue != '' && stateValue != '' && cityValue == '') {
      address = '$stateValue,$countryValue';
    }
    if (cityValue != '' && stateValue != '' && countryValue != '') {
      address = '$cityValue,$stateValue,$countryValue';
    }

    rebuildUi();
  }

  void saveEditDetails() async {
   
    if (formKey.currentState!.validate()) {
      if (countryValue == '') {
        showToast(message: 'Please select your location to proceed');
        return;
      }
      Map<String, dynamic> userData = {
        'user_role': 'chef',
        'link': linkController.text,
        'boat_name': boatNameController.text,
        'address': address,
      };
      await userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);

      _navigationService.navigateToBottomNavBarView();
    }
  }
}
