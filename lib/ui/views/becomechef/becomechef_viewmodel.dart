import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/location_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import '../../../core/imports/core_imports.dart';

class BecomechefViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  GlobalObjectKey<FormState> formKey = GlobalObjectKey<FormState>(UniqueKey());
  final TextEditingController numberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  UserdataServiceService userDataService = locator<UserdataServiceService>();
  UserServices userService = locator<UserServices>();
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
  // final _userService = locator<UserServices>();
  List<UserModel>? userList;

  void onViewModelReady() async {
    setBusy(true);
    userList = await userDataService.fetchUsersDocuments();
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

  void saveEditDetails() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'user_role': 'chef',
        'link': linkController.text,
        'boat_name': boatNameController.text,
        'location': userlocation,
      };
      userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
    }
  }
}
