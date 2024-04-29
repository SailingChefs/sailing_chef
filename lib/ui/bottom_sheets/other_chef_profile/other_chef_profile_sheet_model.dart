import 'dart:developer';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';


class OtherChefProfileSheetModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  void blockAccount(String uid) {
    log("In Block Account");
    _dialogService.showCustomDialog(
      variant: DialogType.blockAccount,
      data: uid,
    );
  }
}
