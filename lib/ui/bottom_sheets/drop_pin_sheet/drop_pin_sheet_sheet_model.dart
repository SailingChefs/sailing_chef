

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/checkdatatype.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class DropPinSheetSheetModel extends BaseViewModel {
  final bool isNew;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Function(SheetResponse response)? completer;
  DropPinSheetSheetModel(this.completer, this.location, {required this.isNew});
  PinnedLocationData location;
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
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
      final place = await getCityCountry(
          location.location!.latitude, location.location!.longitude);
      if (selectedImageFile != null) {
        imageUrls =
            await _navigationpinService.uploadImages(selectedImageFile!);
      }

      PinnedLocation pinnedLocation = PinnedLocation(
        contactNumber: phone.text,
        uid: userDetails!.uid,
        place: place,
        createdTime: Timestamp.now(),
        description: description.text,
        email: email.text,
        link: link.text,
        name: name.text,
        picture: imageUrls ?? [],
        tags: selectedTabSelections,
        location:
            GeoPoint(location.location!.latitude, location.location!.longitude),
        rating: ratings,
        // place: place,
      );

      isNew
          ? await _navigationpinService.savePinnedLocation(pinnedLocation)
          : await _navigationpinService.saveEditPin(pinnedLocation);
      name.text = '';
      email.text = '';
      link.text = '';
      phone.text = '';
      description.text = '';
      selectedImagePath = '';
      selectedTabSelections = [];
      // imageUrls!.clear();
      ratings = 0;
      reset();
      completer!(SheetResponse(data: true));
    } else if (imageUrls == null) {
      showToast(message: 'Please upload image!');
    } else if (selectedTabSelections.isEmpty) {
      showToast(message: 'Please select at least one tag!');
    } else if (ratings == 0) {
      showToast(message: 'Please add ratings!');
    } else {}
  }

  Future<String> getCityCountry(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      // ignore: unnecessary_null_comparison
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return ' ${placemark.locality}, ${placemark.country}';
      } else {
        return 'Unknown';
      }
    } catch (e) {
      return 'Unknown';
    }
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

  void onViewModelReady() {
    if (location.pinnedLocation != null) {
      link.text = location.pinnedLocation!.link;
      name.text = location.pinnedLocation!.name;
      email.text = location.pinnedLocation!.email;
      phone.text = location.pinnedLocation!.contactNumber;
      description.text = location.pinnedLocation!.description;
      selectedImagePath = location.pinnedLocation!.picture.first;
      selectedTabSelections = location.pinnedLocation!.tags;
      ratings = location.pinnedLocation!.rating;
    }
  }

  void deletePin() {
    _dialogService.showCustomDialog(
      variant: DialogType.deletePin,
      title: location.pinnedLocation!.id!,
    );

    rebuildUi();
  }
}
