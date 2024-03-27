import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:stacked/stacked.dart';

class SaveDraftAlertboxDialogModel extends BaseViewModel {
  final _navigatorlocator = locator<NavigationService>();

  void yesButton() {
    _navigatorlocator.back();
  }
}
