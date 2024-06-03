import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class EditProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  GlobalObjectKey<FormState> formKey = GlobalObjectKey<FormState>(UniqueKey());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController boatController = TextEditingController();
  final TextEditingController location = TextEditingController();
  final _userService = locator<UserServices>();
  UserdataServiceService userDataService = locator<UserdataServiceService>();
  final ImagePicker picker = ImagePicker();
  File? selectedImageFile;
  String? selectedImagePath;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String? address;
  bool isChange = false;
  void onViewModelReady() async {
    setBusy(true);

    nameController.text =
        userDetails!.displayName == null ? '' : userDetails!.displayName!;
    emailController.text =
        userDetails!.email == null ? '' : userDetails!.email!;
    linkController.text = userDetails!.link == null ? '' : userDetails!.link!;
    bioController.text = userDetails!.bio == null ? '' : userDetails!.bio!;
    location.text =
        userDetails!.namedLocation == null ? '' : userDetails!.namedLocation!;
    address =
        userDetails!.namedLocation == null ? '' : userDetails!.namedLocation!;

    boatController.text =
        userDetails!.boatName == null ? '' : userDetails!.boatName!;
    log(boatController.text);

    setBusy(false);
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

  getBack() {
    _navigationService.back();
  }

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

  void saveEditDetailsCullinary() async {
    log('Iam here');
    // address = '$cityValue,$stateValue,$countryValue';
    if (selectedImageFile != null) {
      await userDataService.deleteFileFromStorage(userDetails!.displayPicture!);
      final imageLink = await _userService.uploadImage(
        selectedImageFile as File,
        selectedImageFile!.path.split('/').last,
      );

      log(imageLink.toString());
      Map<String, dynamic> userData = {
        'display_picture': imageLink,
        'display_name': nameController.text,
        'link': linkController.text,
        'bio': bioController.text,
        'address': address
      };
      await userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
      userDetails!.displayPicture = imageLink;
      _navigationService.navigateToBottomNavBarView();
      notifyListeners();
    } else {
      Map<String, dynamic> userData = {
        'display_name': nameController.text,
        'link': linkController.text,
        'bio': bioController.text,
        'address': address,
      };
      await userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
      userDetails = await _userService.getUserDetails();
      _navigationService.navigateToBottomNavBarView();
    }
  }

  void saveEditDetailsChef() async {
    // address = '$cityValue,$stateValue,$countryValue';

    log('Iam here');
    if (selectedImageFile != null) {
      await userDataService.deleteFileFromStorage(userDetails!.displayPicture!);
      final imageLink = await _userService.uploadImage(
        selectedImageFile as File,
        selectedImageFile!.path.split('/').last,
      );

      Map<String, dynamic> userData = {
        'display_picture': imageLink,
        'display_name': nameController.text,
        'link': linkController.text,
        'bio': bioController.text,
        'boat_name': boatController.text,
        'address': address,
      };
      await userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
      userDetails!.displayPicture = imageLink;
      _navigationService.navigateToBottomNavBarView();
    } else {
      Map<String, dynamic> userData = {
        'display_name': nameController.text,
        'link': linkController.text,
        'bio': bioController.text,
        'boat_name': boatController.text,
        'address': address,
      };
      await userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
      userDetails = await _userService.getUserDetails();
      _navigationService.navigateToBottomNavBarView();
    }
  }

  void saveEditDetailsGuest(String name, String bio) async {
    if (formKey.currentState!.validate()) {
      if (selectedImageFile != null) {
        await userDataService
            .deleteFileFromStorage(userDetails!.displayPicture!);
        final imageLink = await _userService.uploadImage(
          selectedImageFile as File,
          selectedImageFile!.path.split('/').last,
        );
        Map<String, dynamic> userData = {
          'display_picture': imageLink,
          'display_name': name,
          'bio': bio,
        };
        await userDataService.storeUserDetails(
            userData, FirebaseAuth.instance.currentUser!.uid);
        userDetails = await _userService.getUserDetails();
        _navigationService.navigateToBottomNavBarView();
        notifyListeners();
      }
    } else {
      Map<String, dynamic> userData = {
        'display_name': name,
        'bio': bio,
      };
      await userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
      _navigationService.navigateToBottomNavBarView();
    }
  }

  void changeLocation() {
    isChange = true;
    notifyListeners();
    rebuildUi();
  }
}
