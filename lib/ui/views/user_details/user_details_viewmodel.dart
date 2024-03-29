import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

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
    else{
      showToast(message: 'No image slected Please Select image to proceed');
      
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
        userDetails = await _userService.getUserDetails();
      if(userDetails!.userRole == 'guest'){
        _navigationService.replaceWithBottomBarGuestView();
      }
      else
   { _navigationService.replaceWithBottomNavBarView();}
      }
      else{
        _navigationService.replaceWithUserDetailsView();
      }
    
  }

  Future<void> getImagefromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
       selectedImageFile = File(pickedFile.path);
      selectedImagePath = pickedFile.path;
      notifyListeners();
      rebuildUi();
      
    }
    else{
      showToast(message: 'No image slected Please Select image to proceed');
    }
  }
  onViewModelReady() async{
    setBusy(true);
    userDetails = await _userService.getUserDetails() ;
    nameController.text = userDetails!.displayName ?? '';
    setBusy(false);
  }
}
