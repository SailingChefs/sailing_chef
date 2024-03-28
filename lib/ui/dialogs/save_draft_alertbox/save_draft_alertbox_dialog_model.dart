import 'package:sailing_chefs/core/imports/core_imports.dart';

class SaveDraftAlertboxDialogModel extends BaseViewModel {
  final _navigatorlocator = locator<NavigationService>();

  void yesButton() {
    _navigatorlocator.back();
  }
}
