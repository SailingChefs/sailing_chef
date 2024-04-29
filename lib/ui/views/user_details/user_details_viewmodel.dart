import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/location_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class UserDetailsViewModel extends BaseViewModel {
  final String userrole;
  UserDetailsViewModel(this.userrole);
  final _navigationService = locator<NavigationService>();
  GlobalObjectKey<FormState> formKey = GlobalObjectKey<FormState>(UniqueKey());
  final _userService = locator<UserServices>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController boatNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final _locationService = locator<LocationService>();
  Map<String, dynamic>? userlocation;
  final ImagePicker picker = ImagePicker();
  Position? location;
  File? selectedImageFile;
  String? selectedImagePath;
  List<Placemark>? placemarks;
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

  getUserLocation(Position location) async {
    placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    locationController.text =
        ' ${placemarks![0].street} - ${placemarks![0].locality},${placemarks![0].country}';
  }

  void getLocation() async {
    EasyLoading.show();
    location = await _locationService.determinePosition();
    userlocation = {
      'latitude': location!.latitude,
      'longitude': location!.longitude,
      'timestamp': location!.timestamp.toString(),
      'accuracy': location!.accuracy,
      'altitude': location!.altitude,
      'altitudeAccuracy': location!.altitudeAccuracy,
      'heading': location!.heading,
      'headingAccuracy': location!.headingAccuracy,
      'speed': location!.speed,
      'speedAccuracy': location!.speedAccuracy,
    };
    notifyListeners();
    await getUserLocation(location!);
    EasyLoading.dismiss();
    notifyListeners();
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

    // You can add additional validation criteria for the bio here
    // For example, checking if the bio length is within a certain range

    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }

    // You can add additional validation criteria for the name here
    // For example, checking if the name contains only alphabetic characters

    return null;
  }

  String? validateBoatName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }

    // You can add additional validation criteria for the name here
    // For example, checking if the name contains only alphabetic characters

    return null;
  }

  void saveUserDetails() async {
    if (formKey.currentState!.validate()) {
      if (selectedImageFile == null) {
        showToast(message: 'Please select image to proceed');
        return;
      }
      if (userrole == 'chef' || userrole == 'culinarySchool') {
        if (locationController.text.isEmpty) {
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
          'location': userlocation,
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
    _navigationService.navigateToIndexView();
  }

  void moveBack() {
    _navigationService.back();
  }
}
