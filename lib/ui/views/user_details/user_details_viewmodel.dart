import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController locationController = TextEditingController();

  final bioFocusNode = FocusNode();

  Map<String, dynamic>? userlocation;
  final ImagePicker picker = ImagePicker();
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String? address;

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
        if (countryValue == '') {
          showToast(message: 'Please select your location to proceed');
          return;
        }
      }

      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        showToast(message: 'Please verify your email first');
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
          'link': linkController.text,
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
          locator.registerLazySingleton<BottomNavBarViewModel>(
              () => BottomNavBarViewModel());
          _navigationService.replaceWithBottomBarGuestView();
        } else {
          locator.removeRegistrationIfExists<BottomNavBarViewModel>();
          locator.registerLazySingleton<BottomNavBarViewModel>(
              () => BottomNavBarViewModel());
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
    String imageLink = '';
    if (formKey.currentState!.validate()) {
      if (selectedImageFile == null) {
        imageLink =
            "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg";
      } else {
        imageLink = await _userService.uploadImage(
          selectedImageFile as File,
          selectedImageFile!.path.split('/').last,
        );
      }

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
    if (userDetails!.userRole == 'guest') {
      _navigationService.clearStackAndShowView(
        const BottomBarGuestView(),
      );
    } else {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        _navigationService.clearStackAndShowView(
          BottomNavBarView(),
        );
      } else {
        // _snakbarService.showSnackbar(message: "Please varify your email first");
        showToast(message: 'Please varify your email first');
      }
    }
  }
}
