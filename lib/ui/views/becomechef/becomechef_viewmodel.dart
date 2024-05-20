
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
  String? address ;

  

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
    notifyListeners();
  }

  void setStateValue(String value) {
    stateValue = value;
    notifyListeners();
  }

  void setCityValue(String value) {
    cityValue = value;
    notifyListeners();
  }




  void saveEditDetails() async {
    address = "$cityValue,$stateValue,$countryValue".trim();
    if (formKey.currentState!.validate()) {
       if(cityValue == '' || stateValue == '' || countryValue == ''){
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
