import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

class UserDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  GlobalObjectKey<FormState> formKey = GlobalObjectKey<FormState>(UniqueKey());
  final _userService = locator<UserServices>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController boatNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController syjoyController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? selectedImageFile;
  String? selectedImagePath;
  Future<void> getImagefromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    

    if (pickedFile != null) {
       selectedImageFile = File(pickedFile.path);
      selectedImagePath = pickedFile.path;

      notifyListeners();
      rebuildUi();
    }
  }

  void saveUserDetails() async{
 
    final imageLink = await _userService.uploadImage(selectedImageFile as File, selectedImageFile!.path.split('/').last,);
  
      bool userDetailsStatus = await _userService.storeUserDetails(
       
          {
          
          'display_name': nameController.text,
         'bio': bioController.text,
          'link': linkController.text,
          'boat_name': boatNameController.text,
          'location': locationController.text,
          'sy_joy': syjoyController.text,
          'display_picture': imageLink,
          },
          FirebaseAuth.instance.currentUser!.uid,
          
        
      );
      if(userDetailsStatus){

    _navigationService.navigateToBottomNavBarView();
      }
      else{
        _navigationService.replaceWithUserDetailsView();
      }
    
  }

  Future<void> getImagefromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;
      notifyListeners();
      rebuildUi();
    }
  }
  onViewModelReady() async{
    setBusy(true);
   final UserModel user = await _userService.getUserDetails() ;
    nameController.text = user.displayName ?? '';
    setBusy(false);
  }
}
