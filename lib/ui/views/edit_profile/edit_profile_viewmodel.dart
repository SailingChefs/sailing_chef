import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
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
  final TextEditingController manualStateController = TextEditingController();
  final TextEditingController manualCityController = TextEditingController();
  final _userService = locator<UserServices>();
  UserdataServiceService userDataService = locator<UserdataServiceService>();
  final ImagePicker picker = ImagePicker();
  File? selectedImageFile;
  String? selectedImagePath;
  String countryValue = '';
  String stateValue = '';
  String cityValue = '';
  String? address;
  bool isChange = false;
  bool useManualLocationInputs = false;
  final Map<String, bool> _countryHasStatesByName = {};

  void onViewModelReady() {
    setBusy(true);

    nameController.text = userDetails!.displayName == null ? '' : userDetails!.displayName!;
    emailController.text = userDetails!.email == null ? '' : userDetails!.email!;
    linkController.text = userDetails!.link == null ? '' : userDetails!.link!;
    bioController.text = userDetails!.bio == null ? '' : userDetails!.bio!;
    location.text = userDetails!.namedLocation == null ? '' : userDetails!.namedLocation!;
    address = userDetails!.namedLocation == null ? '' : userDetails!.namedLocation!;

    boatController.text = userDetails!.boatName == null ? '' : userDetails!.boatName!;
    log(boatController.text);

    setBusy(false);
  }

  void setCountryValue(String value) {
    countryValue = _normalizeCountryName(value);
    stateValue = '';
    cityValue = '';
    manualStateController.clear();
    manualCityController.clear();
    useManualLocationInputs = false;
    _updateAddress();
    rebuildUi();
    unawaited(_resolveCountryLocationMode(countryValue));
  }

  void setStateValue(String? value) {
    if (value == '  State*') {
      stateValue = '';
      cityValue = '';
    } else if (value == 'null') {
      stateValue = '';
    } else if (value == null) {
      stateValue = '';
    } else {
      stateValue = value;
      cityValue = '';
    }
    _updateAddress();
    rebuildUi();
  }

  void setCityValue(String? value) {
    if (value == '  City*') {
      cityValue = '';
    } else if (value == 'null') {
      cityValue = '';
    } else if (value == null) {
      cityValue = '';
    } else {
      cityValue = value;
    }
    _updateAddress();
    rebuildUi();
  }

  void setManualStateValue(String value) {
    stateValue = value.trim();
    _updateAddress();
    rebuildUi();
  }

  void setManualCityValue(String value) {
    cityValue = value.trim();
    _updateAddress();
    rebuildUi();
  }

  @override
  void getBack() {
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

  Future<void> saveEditDetailsCullinary() async {
    log('Iam here');
    // address = '$cityValue,$stateValue,$countryValue';
    if (selectedImageFile != null) {
      await userDataService.deleteFileFromStorage(userDetails!.displayPicture!);
      final imageLink = await _userService.uploadImage(
        selectedImageFile!,
        selectedImageFile!.path.split('/').last,
      );

      log(imageLink);
      final userData = <String, dynamic>{
        'display_picture': imageLink,
        'display_name': nameController.text,
        'link': linkController.text,
        'bio': bioController.text,
        'address': address
      };
      await userDataService.storeUserDetails(userData, FirebaseAuth.instance.currentUser!.uid);
      userDetails!.displayPicture = imageLink;
      _navigationService.navigateToBottomNavBarView();
      notifyListeners();
    } else {
      final userData = <String, dynamic>{
        'display_name': nameController.text,
        'link': linkController.text,
        'bio': bioController.text,
        'address': address,
      };
      await userDataService
          .storeUserDetails(userData, FirebaseAuth.instance.currentUser!.uid)
          .then((value) => {
                showToast(message: 'Profile Updated'),
              });
      userDetails = await _userService.getUserDetails();
      _navigationService.navigateToBottomNavBarView();
    }
  }

  Future<void> saveEditDetailsChef() async {
    // address = '$cityValue,$stateValue,$countryValue';

    log('Iam here');

    final userData = <String, dynamic>{
      'display_name': nameController.text,
      'bio': bioController.text,
      'link': linkController.text,
      'boat_name': boatController.text,
      'address': address,
    };

    if (selectedImageFile != null) {
      await userDataService.deleteFileFromStorage(userDetails!.displayPicture!);
      final imageLink = await _userService.uploadImage(
        selectedImageFile!,
        selectedImageFile!.path.split('/').last,
      );
      userData['display_picture'] = imageLink;
    } else {
      userData['display_picture'] = userDetails!.displayPicture;
    }

    await userDataService.storeUserDetails(userData, FirebaseAuth.instance.currentUser!.uid);
    userDetails = await _userService.getUserDetails();
    _navigationService.navigateToBottomNavBarView();
  }

  Future<void> saveEditDetailsGuest(String name, String bio) async {
    if (formKey.currentState!.validate()) {
      final userData = <String, dynamic>{
        'display_name': name,
        'bio': bio,
      };
      if (selectedImageFile != null) {
        await userDataService.deleteFileFromStorage(userDetails!.displayPicture!);
        final imageLink = await _userService.uploadImage(
          selectedImageFile!,
          selectedImageFile!.path.split('/').last,
        );
        userData['display_picture'] = imageLink;
      }
      await userDataService.storeUserDetails(userData, FirebaseAuth.instance.currentUser!.uid);
      userDetails = await _userService.getUserDetails();
      _navigationService.navigateToBottomNavBarView();
      notifyListeners();
    }
  }

  void changeLocation() {
    isChange = true;
    notifyListeners();
    rebuildUi();
  }

  void _updateAddress() {
    final city = cityValue.trim();
    final state = stateValue.trim();
    final country = countryValue.trim();
    final parts = <String>[];
    if (city.isNotEmpty) parts.add(city);
    if (state.isNotEmpty) parts.add(state);
    if (country.isNotEmpty) parts.add(country);
    address = parts.join(',');
  }

  String _normalizeCountryName(String value) {
    if (value.contains('    ')) {
      return value.split('    ').last.trim();
    }
    return value.trim();
  }

  Future<bool> _countryHasStates(String countryName) async {
    await _ensureCountryStateAvailability();
    return _countryHasStatesByName[countryName] ?? true;
  }

  Future<void> _resolveCountryLocationMode(String country) async {
    final hasStates = await _countryHasStates(country);
    if (country != countryValue) return;
    useManualLocationInputs = !hasStates;
    _updateAddress();
    rebuildUi();
  }

  Future<void> _ensureCountryStateAvailability() async {
    if (_countryHasStatesByName.isNotEmpty) return;
    final raw = await rootBundle.loadString('packages/csc_picker_plus/lib/assets/countries.json');
    final parsed = jsonDecode(raw) as List<dynamic>;
    for (final item in parsed) {
      final map = item as Map<String, dynamic>;
      final name = (map['name'] as String?)?.trim();
      final states = map['state'] as List<dynamic>?;
      if (name == null || name.isEmpty) continue;
      _countryHasStatesByName[name] = (states ?? const []).isNotEmpty;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    emailController.dispose();
    linkController.dispose();
    boatController.dispose();
    location.dispose();
    manualStateController.dispose();
    manualCityController.dispose();
    super.dispose();
  }
}
