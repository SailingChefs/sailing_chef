import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';

class PindropDialogueboxDialogModel extends BaseViewModel {
  PinnedLocation pinnedLocation;
  String placeMark;
  final _dialogService = locator<DialogService>();
  PindropDialogueboxDialogModel(
      {required this.pinnedLocation, required this.placeMark});

  getAddress(double latitude, double longitude) {}

  void callDeatilsDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.pindetails,
      data: pinnedLocation,
      title: placeMark,
    );
  }
}
