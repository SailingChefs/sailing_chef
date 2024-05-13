import 'dart:developer';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
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
  final DialogService _dialogSaved = locator<DialogService>();
  String id = '';
  void onViewModelReady(Course? course) async {
    setBusy(true);

    if (course != null) {
      name.text = course.name;
      link.text = course.link;
      desc.text = course.description;
      numOfDays.text = course.numOfDays.toString();
      id = course.id!;
    } else {
      log("course is null");
    }
    setBusy(false);
  }

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
      if (isLinkValid(link.text)) {
        _cullinaryService.cullinaryCoursesAdd(Course(
            name: name.text,
            link: link.text,
            description: desc.text,
            numOfDays: numOfDays.text,
            id: id));

        name.clear();
        link.clear();
        desc.clear();
        numOfDays.clear();

        _dialogSaved.showCustomDialog(variant: DialogType.courseSaved);
      } else {
        showToast(message: 'Please Provide a valid link!');
      }
    }
  }

  void deleteCourse(String courseId) {
    _dialogSaved.showCustomDialog(
      variant: DialogType.deleteconfirmation,
      title: courseId,
    );

    notifyListeners();
    rebuildUi();
  }
}
