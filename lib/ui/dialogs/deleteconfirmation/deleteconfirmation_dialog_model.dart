import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';

class DeleteconfirmationDialogModel extends BaseViewModel {
  final _navigatorlocator = locator<NavigationService>();
  final _cullinaryschoolService = locator<CullinaryschoolService>();

  Future<void> yesButton(String course) async {
    await _cullinaryschoolService.deleteCullinaryCoursesData(course);
    notifyListeners();
    rebuildUi();
    _navigatorlocator.back();
  }

  void noButton() {
    _navigatorlocator.back();
  }
}
