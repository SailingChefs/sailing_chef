import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class CookingInstructionsSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogboxnavigation = locator<DialogService>();
  void popBack() {
    _navigationService.back();
  }

  void saveData() {
    _dialogboxnavigation.showCustomDialog(
      variant: DialogType.saveDraftAlertbox,
    );
  }
}
