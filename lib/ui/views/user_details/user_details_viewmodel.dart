import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/views/bottom_bar_guest/bottom_bar_guest_view.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_viewmodel.dart';

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
  final TextEditingController contactController = TextEditingController();
  String businessCategory = '';
  final TextEditingController locationController = TextEditingController();
  final TextEditingController manualStateController = TextEditingController();
  final TextEditingController manualCityController = TextEditingController();

  // Focus nodes with skipTraversal so they are only focused via explicit taps
  // final nameFocusNode = FocusNode(skipTraversal: true);
  // final bioFocusNode = FocusNode(skipTraversal: true);
  // final linkFocusNode = FocusNode(skipTraversal: true);
  // final boatNameFocusNode = FocusNode(skipTraversal: true);

  Map<String, dynamic>? userlocation;
  final ImagePicker picker = ImagePicker();
  String countryValue = '';
  String stateValue = '';
  String cityValue = '';
  String? address;
  bool useManualLocationInputs = false;
  final Map<String, bool> _countryHasStatesByName = {};

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
    if (value == 'state*') {
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
    if (value == 'city*') {
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

  String? validateLink(String? value) {
    // Check if the input is null or empty
    if (value == null || value.isEmpty) {
      return 'Please enter a link';
    }

    // Use a regular expression for basic URL validation without protocol
    final urlRegex = RegExp(
      // Allow optional http:// or https://, optional www., domain and optional path/query.
      // Accepts characters commonly used in URLs: alphanumerics, -, ., /, ?, &, =, %, and _
      r'^(?:https:\/\/)?(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+(?:\/[\w\-.?&=/%]*)?$',
      caseSensitive: false,
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

  Future<void> saveUserDetails() async {
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
        if (countryValue == '') {
          showToast(message: 'Please select your location to proceed');
          return;
        }
      }

      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        final user = FirebaseAuth.instance.currentUser!;
        await user.reload();
        if (!user.emailVerified) {
          showToast(message: 'Please verify your email first');
          return;
        }
      }

      final imageLink = await _userService.uploadImage(
        selectedImageFile!,
        selectedImageFile!.path.split('/').last,
      );

      // Prepare link value: remove leading https:// (or http://) if present
      var processedLink = linkController.text.trim().toLowerCase();
      if (processedLink.startsWith('https://')) {
        processedLink = processedLink.substring('https://'.length);
      } else if (processedLink.startsWith('http://')) {
        processedLink = processedLink.substring('http://'.length);
      }

      final userDetailsStatus = await _userService.storeUserDetails(
        {
          'display_name': nameController.text,
          'bio': bioController.text,
          'link': processedLink,
          'boat_name': boatNameController.text,
          'address': address,
          'display_picture': imageLink,
        },
        FirebaseAuth.instance.currentUser!.uid,
      );

      if (userDetailsStatus) {
        userDetails = await _userService.getUserDetails();
        if (userDetails!.userRole == 'guest') {
          locator.removeRegistrationIfExists<BottomNavBarViewModel>();
          locator.registerLazySingleton<BottomNavBarViewModel>(BottomNavBarViewModel.new);
          _navigationService.replaceWithBottomBarGuestView();
        } else {
          locator.removeRegistrationIfExists<BottomNavBarViewModel>();
          locator.registerLazySingleton<BottomNavBarViewModel>(BottomNavBarViewModel.new);
          _navigationService.replaceWithBottomNavBarView();
        }
      } else {
        _navigationService.replaceWithUserDetailsView(userRole: userrole);
      }
    } else {
      showToast(message: 'Please fill all the fields');
    }
  }

  Future<void> saveguestDetails() async {
    var imageLink = '';
    if (formKey.currentState!.validate()) {
      if (selectedImageFile == null) {
        imageLink = 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg';
      } else {
        imageLink = await _userService.uploadImage(
          selectedImageFile!,
          selectedImageFile!.path.split('/').last,
        );
      }

      final userDetailsStatus = await _userService.storeUserDetails(
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

  void onViewModelReady() {
    setBusy(true);
    nameController.text = capitalizeEachWord(userDetails!.displayName!);
    setBusy(false);
  }

  Future<void> skipToHome() async {
    if (userDetails!.userRole == 'guest') {
      _navigationService.clearStackAndShowView<Widget>(
        const BottomBarGuestView(),
      );
    } else {
      await FirebaseAuth.instance.currentUser!.reload();

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        _navigationService.clearStackAndShowView<Widget>(
          const BottomNavBarView(),
        );
      } else {
        // _snakbarService.showSnackbar(message: "Please varify your email first");
        showToast(message: 'Please verify your email first');
      }
    }
  }

  void setBusinessCategory(String val) {
    businessCategory = val;
    notifyListeners();
  }

  Future<void> saveSupplierDetails() async {
    if (formKey.currentState!.validate()) {
      if (selectedImageFile == null) {
        showToast(message: 'Please select a profile image to proceed');
        return;
      }
      if (businessCategory.isEmpty) {
        showToast(message: 'Please select a category');
        return;
      }

      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        final user = FirebaseAuth.instance.currentUser!;
        await user.reload();
        if (!user.emailVerified) {
          showToast(message: 'Please verify your email first');
          return;
        }
      }

      final imageLink = await _userService.uploadImage(
        selectedImageFile!,
        selectedImageFile!.path.split('/').last,
      );

      var processedLink = linkController.text.trim().toLowerCase();
      if (processedLink.startsWith('https://')) {
        processedLink = processedLink.substring('https://'.length);
      } else if (processedLink.startsWith('http://')) {
        processedLink = processedLink.substring('http://'.length);
      }

      final saved = await _userService.storeUserDetails(
        {
          'display_name': nameController.text.trim(),
          'bio': bioController.text.trim(),
          'link': processedLink,
          'business_category': businessCategory,
          'contact_number': contactController.text.trim(),
          'display_picture': imageLink,
        },
        FirebaseAuth.instance.currentUser!.uid,
      );

      if (saved) {
        userDetails = await _userService.getUserDetails();
        _navigationService.replaceWithPinDropMapView(onboardingMode: true);
      } else {
        _navigationService.replaceWithUserDetailsView(userRole: userrole);
      }
    } else {
      showToast(message: 'Please fill all required fields');
    }
  }

  @override
  void dispose() {
    // nameFocusNode.dispose();
    // bioFocusNode.dispose();
    // linkFocusNode.dispose();
    // boatNameFocusNode.dispose();
    nameController.dispose();
    bioController.dispose();
    linkController.dispose();
    boatNameController.dispose();
    contactController.dispose();
    locationController.dispose();
    manualStateController.dispose();
    manualCityController.dispose();
    super.dispose();
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
}
