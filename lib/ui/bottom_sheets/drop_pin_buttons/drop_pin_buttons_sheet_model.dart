import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class DropPinButtonsSheetModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  // final _navigationLoactor = locator<NavigationService>();
  void dropPin() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.dropPinSheet,
    );
  }
}
