import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
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
  UserdataServiceService userDataService = locator<UserdataServiceService>();
  final ImagePicker picker = ImagePicker();
  File? selectedImageFile;
  String? selectedImagePath;
  // final _userService = locator<UserServices>();
  List<UserModel>? userList;
  List<Placemark>? placemarks;
  void onViewModelReady() async {
    setBusy(true);
    userList = await userDataService.fetchUsersDocuments();
    nameController.text = userDetails!.displayName!;
    emailController.text = userDetails!.email!;
    linkController.text = userDetails!.link!;
    bioController.text = userDetails!.bio!;
    boatController.text = userDetails!.boatName == null ? '' : userDetails!.boatName!;
    await getUserLocation();
    log(placemarks!.first.locality.toString());
    location.text = placemarks!.first.locality.toString();
    log("location ${location.text}");
    setBusy(false);
  }

  getUserLocation() async {
    log(userDetails!.displayName.toString());
    if (userDetails!.location == null) {
      return placemarks = null;
    }
    placemarks = await placemarkFromCoordinates(
        userDetails!.location!['latitude'],
        userDetails!.location!['longitude']);
    log(placemarks.toString());
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

  void saveEditDetailsCullinary(
    String name,
    String bio,
    String email,
    String link,
  ) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'display_picture': selectedImagePath,
        'display_name': name,
        'email': email,
        'link': link,
        'location': placemarks,
        'bio': bio,
      };
      userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
    }
  }

  void saveEditDetailsChef(
    String name,
    String bio,
    String email,
    String link,
    String boatName,
  ) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'display_picture': selectedImagePath,
        'display_name': name,
        'email': email,
        'link': link,
        'location': userDetails!.location,
        'bio': bio,
        'boat_name': boatName,
      };
      userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
    }
  }

  void saveEditDetailsGuest(String name, String bio) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'display_picture': selectedImagePath,
        'display_name': name,
        'bio': bio,
      };
      userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
    }
  }
}
