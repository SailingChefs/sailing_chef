import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/app/app.locator.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteAccountDialogModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  void deleteAccount() async {
    _dialogService.showCustomDialog(variant: DialogType.enterPass);
  }
}
