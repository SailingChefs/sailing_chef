import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class CoursesSheetModel extends BaseViewModel {
  String? linkErrorMessage;
  final TextEditingController name = TextEditingController();
  final TextEditingController link = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController numOfDays = TextEditingController();
  final CullinaryschoolService _cullinaryService =
      locator<CullinaryschoolService>();
  final DialogService _dialogSaved =
      locator<DialogService>();
  bool isLinkValid(String input) {
    if (!input.contains("www.") ||
        !input.contains(".com") ||
        input.isEmpty ||
        input.length < 10) {
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

  void saveCourse() {
    if (name.text.isEmpty ||
        link.text.isEmpty ||
        desc.text.isEmpty ||
        numOfDays.text.isEmpty) {
      showToast(message: 'Please enter all fields!');
    } else {
      String uid = FirebaseAuth.instance.currentUser!.uid;
       _cullinaryService.addCourseToDatabase(
          userId: uid,
          name: name.text,
          link: link.text,
          desc: desc.text,
          numOfDays: numOfDays.text);
      showToast(message: 'Course added successfully!');
      name.clear();
      link.clear();
      desc.clear();
      numOfDays.clear();

    // Show the dialog using the DialogService
    _dialogSaved.showCustomDialog(variant: DialogType.courseSaved);
  }
    
  }
}
