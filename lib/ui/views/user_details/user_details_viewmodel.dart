import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class UserDetailsViewModel extends BaseViewModel {
  final String userrole;
  UserDetailsViewModel(
    this.userrole,
  );
  final _navigationService = locator<NavigationService>();
  GlobalObjectKey<FormState> formKey = GlobalObjectKey<FormState>(UniqueKey());
  final _userService = locator<UserServices>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController boatNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  Map<String, dynamic>? userlocation;
  final ImagePicker picker = ImagePicker();
   String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String? address ;
 
  File? selectedImageFile;
  String? selectedImagePath;

  

  Future<void> getImagefromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path);
      selectedImagePath = pickedFile.path;

      notifyListeners();
      rebuildUi();
    } else {
      showToast(message: 'No image slected Please Select image to proceed');
    }
  }

 
  // 
 void setCountryValue(String value) {
    countryValue = value;

    //
    rebuildUi();
    log('cityValue : $cityValue');
    log('stateValue : $stateValue');
  }

  void setStateValue(String? value) {
     log(value.runtimeType.toString());
    log(value.toString());
    if (value == 'state*') {
      stateValue = '';
    cityValue = '';
      
   
      rebuildUi();
    
    }
    else if( value == 'null'){

      stateValue = '';  

      rebuildUi();
    }
    else{
      stateValue = value!;
      cityValue = '';
      rebuildUi();
    }
    

    rebuildUi();
  }

  void setCityValue(String? value) {
    log(value.runtimeType.toString());
    log(value.toString());
    if (value == 'city*') {
      cityValue = '';
      rebuildUi(); 
    }
    else if( value == 'null'){
      cityValue = '';
      rebuildUi();
    }
    else{
      cityValue = value!;
      rebuildUi();
    }
    if(countryValue != '' && stateValue == '' && cityValue == ''){
        address = countryValue;
      }
      if(countryValue != '' && stateValue != '' && cityValue == ''){
        address = '$stateValue,$countryValue';
      }
      if(cityValue != '' && stateValue != '' && countryValue != ''){
        address = '$cityValue,$stateValue,$countryValue';
      }

      log('address : $address');
    // isChange = false;

    rebuildUi();
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

  String? validateBio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a bio';
    }

    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? validateBoatName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  

  void saveUserDetails() async {
    if (formKey.currentState!.validate()) {
      if (selectedImageFile == null) {
        showToast(message: 'Please select image to proceed');
        return;
      }
      if (userrole == 'chef' || userrole == 'culinarySchool') {
        // if (locationController.text.isEmpty) {
        //   showToast(message: 'Please select your location to proceed');
        //   return;
        // }
        if( countryValue == ''){
        showToast(message: 'Please select your location to proceed');
        return;
      }
      }


      final imageLink = await _userService.uploadImage(
        selectedImageFile as File,
        selectedImageFile!.path.split('/').last,
      );
      
    
      

      bool userDetailsStatus = await _userService.storeUserDetails(
        {
          'display_name': nameController.text,
          'bio': bioController.text,
          'link': linkController.text,
          'boat_name': boatNameController.text,
          'address' : address,
         
          'display_picture': imageLink,
        },
        FirebaseAuth.instance.currentUser!.uid,
      );

      if (userDetailsStatus) {
        userDetails = await _userService.getUserDetails();
        if (userDetails!.userRole == 'guest') {
          _navigationService.replaceWithBottomBarGuestView();
        } else {
          _navigationService.replaceWithBottomNavBarView();
        }
      } else {
        _navigationService.replaceWithUserDetailsView(userRole: userrole);
      }
    } else {
      showToast(message: 'Please fill all the fields');
    }
  }
   void saveguestDetails() async {
    if (formKey.currentState!.validate()) {
      if (selectedImageFile == null) {
        showToast(message: 'Please select image to proceed');
        return;
      }
     
      


      final imageLink = await _userService.uploadImage(
        selectedImageFile as File,
        selectedImageFile!.path.split('/').last,
      );
      

      

      bool userDetailsStatus = await _userService.storeUserDetails(
        {
          'display_name': nameController.text,
          'bio': bioController.text,
          
         
          'display_picture': imageLink,
        },
        FirebaseAuth.instance.currentUser!.uid,
      );

      if (userDetailsStatus) {
        userDetails = await _userService.getUserDetails();
        if (userDetails!.userRole == 'guest') {
          _navigationService.replaceWithBottomBarGuestView();
        } else {
          _navigationService.replaceWithBottomNavBarView();
        }
      } else {
        _navigationService.replaceWithUserDetailsView(userRole: userrole);
      }
    } else {
      showToast(message: 'Please fill all the fields');
    }
  }

  Future<void> getImagefromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path);
      selectedImagePath = pickedFile.path;
      notifyListeners();
      rebuildUi();
    } else {
      showToast(message: 'No image slected Please Select image to proceed');
    }
  }

  onViewModelReady() async {
    setBusy(true);
    nameController.text = capitalizeEachWord(userDetails!.displayName!);
    setBusy(false);
  }

  void skipToHome() {
    if(userDetails!.userRole == 'guest'){
      _navigationService.replaceWithBottomBarGuestView();
    }else{
      _navigationService.replaceWithBottomNavBarView();
    }
  }

  void getBack() {
    _navigationService.navigateToSignUpView();
  }

  movetoDropPin() {
    _navigationService.navigateToPinDropMapView();
  }

 


}
