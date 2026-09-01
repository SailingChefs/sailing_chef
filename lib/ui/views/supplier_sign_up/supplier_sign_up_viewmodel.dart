import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/services/location_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class SupplierSignUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _pinDropService = locator<PinDropService>();
  final _locationService = locator<LocationService>();

  int wizardStep = 0;

  // Step 1 – Business Details
  final businessNameController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedCategory = 'Restaurant';
  static const List<String> categoryOptions = [
    'Restaurant',
    'Grocery Store',
    'Fish Market',
    'Marine Supply',
    'Bakery',
    'Butcher',
    'Other',
  ];
  final GlobalKey<FormState> step1FormKey = GlobalKey<FormState>();

  // Step 2 – Map
  GoogleMapController? mapController;
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(-33.8688, 151.2093),
    zoom: 13,
  );
  LatLng selectedLocation = const LatLng(-33.8688, 151.2093);

  // Step 3 – Account
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  final GlobalKey<FormState> step3FormKey = GlobalKey<FormState>();

  void onViewModelReady() async {
    try {
      final position = await _locationService.determinePosition();
      selectedLocation = LatLng(position.latitude, position.longitude);
      initialCameraPosition = CameraPosition(
        target: selectedLocation,
        zoom: 14,
      );
      notifyListeners();
    } catch (_) {}
  }

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  void onCameraMove(CameraPosition position) {
    selectedLocation = position.target;
  }

  void goToNextStep() {
    if (wizardStep == 0 && !_validateStep1()) return;
    if (wizardStep < 2) {
      wizardStep++;
      notifyListeners();
    }
  }

  void goToPreviousStep() {
    if (wizardStep > 0) {
      wizardStep--;
      notifyListeners();
    }
  }

  bool _validateStep1() {
    if (businessNameController.text.trim().isEmpty) {
      showToast(message: 'Please enter your business name');
      return false;
    }
    if (descriptionController.text.trim().isEmpty) {
      showToast(message: 'Please add a description');
      return false;
    }
    return true;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email';
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return regex.hasMatch(value) ? null : 'Please enter a valid email';
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    return value.length >= 8 ? null : 'Password must be at least 8 characters';
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    return value == passwordController.text ? null : 'Passwords do not match';
  }

  Future<void> createAccount() async {
    if (!(step3FormKey.currentState?.validate() ?? false)) return;

    EasyLoading.show();

    final supplierUser = UserModel(
      displayName: businessNameController.text.trim(),
      email: emailController.text.trim(),
      userRole: 'supplier',
      uid: '',
      bio: descriptionController.text.trim(),
      boatName: '',
      createdTime: DateTime.now(),
      displayPicture: '',
      followers: [],
      following: [],
      link: websiteController.text.trim(),
      savedRecipes: [],
      blockedAccounts: [],
      businessName: businessNameController.text.trim(),
      businessCategory: selectedCategory,
      businessContact: phoneController.text.trim(),
      businessWebsite: websiteController.text.trim(),
      businessDescription: descriptionController.text.trim(),
      supplierLocation: GeoPoint(
        selectedLocation.latitude,
        selectedLocation.longitude,
      ),
    );

    final registered = await _authService.signUp(
      password: passwordController.text.trim(),
      userModel: supplierUser,
    );

    if (registered) {
      final pin = PinnedLocation(
        uid: userDetails?.uid ?? '',
        contactNumber: phoneController.text.trim(),
        createdTime: Timestamp.now(),
        description: descriptionController.text.trim(),
        email: emailController.text.trim(),
        link: websiteController.text.trim(),
        location: GeoPoint(
          selectedLocation.latitude,
          selectedLocation.longitude,
        ),
        name: businessNameController.text.trim(),
        picture: [],
        tags: [selectedCategory, 'supplier'],
        rating: 0.0,
        place: selectedCategory,
      );
      await _pinDropService.savePinnedLocation(pin);

      EasyLoading.dismiss();
      _navigationService.replaceWithSupplierConfirmationView();
    } else {
      EasyLoading.dismiss();
    }
  }

  void goBack() => _navigationService.back();

  @override
  void dispose() {
    businessNameController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
