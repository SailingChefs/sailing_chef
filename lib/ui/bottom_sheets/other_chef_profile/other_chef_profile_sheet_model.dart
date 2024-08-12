import 'dart:developer';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';

class OtherChefProfileSheetModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final Function(SheetResponse response)? completer;
  OtherChefProfileSheetModel({this.completer});
  void blockAccount(UserModel user) async {
    log("In Block Account");
    await _dialogService.showCustomDialog(
      variant: DialogType.blockAccount,
      data: user,
    );
  }
}
