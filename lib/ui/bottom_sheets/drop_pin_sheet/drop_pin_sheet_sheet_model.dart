import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class DropPinSheetSheetModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Function(SheetResponse response)? completer;
  DropPinSheetSheetModel(this.completer, {required this.location});
  final LatLng location;
  final _navigationService = locator<NavigationService>();
  List<XFile>? selectedImageFile;
  String? selectedImagePath;
  final ImagePicker picker = ImagePicker();
  final _navigationpinService = locator<PinDropService>();
  bool isTagsVisible = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController link = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController description = TextEditingController();
  double ratings = 0;
  String? image;
  List<String>? imageUrls;
  String? nameError;
  String? linkError;
  String? phoneError;
  String? emailError;
  String? descriptionError;
  Future<void> savePinDrop() async {
    if (formKey.currentState!.validate()) {
      imageUrls = await _navigationpinService.uploadImages(selectedImageFile!);
      image = imageUrls!.first;
      PinnedLocation pinnedLocation = PinnedLocation(
        contactNumber: phone.text,
        createdTime: Timestamp.now(),
        description: description.text,
        email: email.text,
        link: link.text,
        name: name.text,
        picture: imageUrls!,
        tags: selectedTabSelections,
        location: GeoPoint(location.latitude, location.longitude),
        rating: ratings,
      );
      await _navigationpinService.savePinnedLocation(pinnedLocation);
      name.text = '';
      email.text = '';
      link.text = '';
      phone.text = '';
      description.text = '';
      selectedImagePath = '';
      selectedTabSelections = [];
      imageUrls!.clear();
      ratings = 0;
      reset();
      completer!(SheetResponse(data: true));
    }else if (imageUrls == null) {
      showToast(message: 'Please upload image!');
    } else if (selectedTabSelections.isEmpty) {
      showToast(message: 'Please select at least one tag!');
    } else {}
    
  }

  void toggleTagsVisibility() {
    isTagsVisible = !isTagsVisible;
    notifyListeners();
  }

  List<String> selectedTabSelections = [];
  List<bool> selections = [];

  void handleTabSelection(String tabSelection) {
    if (selectedTabSelections.contains(tabSelection)) {
      selectedTabSelections.remove(tabSelection);
    } else {
      selectedTabSelections.add(tabSelection);
    }
    notifyListeners();
    rebuildUi();
  }

  Future<void> getPfpImage() async {
    final List<XFile> pickedFile = await picker.pickMultiImage(
      imageQuality:
          const int.fromEnvironment('imageQuality', defaultValue: 100),
      maxHeight: 500,
      maxWidth: 500,
    );
    // ignore: unnecessary_null_comparison
    if (pickedFile != null) {
      selectedImageFile = pickedFile;
      
      selectedImagePath = selectedImageFile!.first.path;
      notifyListeners();
      rebuildUi();
    } else {
      showToast(message: 'No image selected');
    }
  }

  void reset() {
    selectedTabSelections.clear();
    selectedImageFile = null;
    selectedImagePath = null;
    notifyListeners();
    rebuildUi();
  }

  void apply() {
    selectedTabSelections;
    selectedImageFile;
    selectedImagePath;

    _navigationService.back();
  }

  String? linkErrorMessage;

  bool isLinkValid(String input) {
    if (!input.contains("www.") || !input.contains(".com")) {
      return false;
    }
    try {
      Uri.parse(input);
    } catch (e) {
      return false;
    }
    return true;
  }

  void setLinkErrorMessage(String? s) {
    linkErrorMessage = s;
    notifyListeners();
  }

  void setRating(double value) {
    ratings = value;
    notifyListeners();
  }

  void setNameError(String? s) {
    nameError = s;
    notifyListeners();
  }

  void setLinkError(String? s) {
    linkError = s;
    notifyListeners();
  }

  void setPhoneError(String? s) {
    phoneError = s;
    notifyListeners();
  }

  void setEmailError(String? s) {
    emailError = s;
    notifyListeners();
  }

  void setDescriptionError(String? s) {
    descriptionError = s;
    notifyListeners();
  }
}
