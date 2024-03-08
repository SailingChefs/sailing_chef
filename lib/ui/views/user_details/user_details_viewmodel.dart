import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class UserDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  GlobalObjectKey<FormState> formKey = GlobalObjectKey<FormState>(UniqueKey());
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController boatNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController syjoyController = TextEditingController();
  TextEditingController location2Controller = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String? selectedImagePath;
  Future<void> getImagefromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;

      notifyListeners();
      rebuildUi();
    }
  }

  void saveUserDetails() {
    // if (formKey.currentState?.validate() ?? false) {

    _navigationService.navigateToBottomNavBarView();
    // }
  }

  Future<void> getImagefromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;
      notifyListeners();
      rebuildUi();
    }
  }
}
