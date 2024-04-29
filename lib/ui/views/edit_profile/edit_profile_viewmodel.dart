import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController numberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  UserdataServiceService userDataService = locator<UserdataServiceService>();
  final ImagePicker picker = ImagePicker();
  File? selectedImageFile;
  String? selectedImagePath;
  // final _userService = locator<UserServices>();
  List<UserModel>? userList;

  void onViewModelReady() async {
    setBusy(true);
    userList = await userDataService.fetchUsersDocuments();
    setBusy(false);
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

  void saveEditDetails(
      String name, String email, String number, String dob, String bio) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'display_picture': selectedImagePath,
        'display_name': name,
        'email': email,
        'phone_number': number,
        'dob': dob,
        'bio': bio,
      };
      userDataService.storeUserDetails(
          userData, FirebaseAuth.instance.currentUser!.uid);
    }
  }
}