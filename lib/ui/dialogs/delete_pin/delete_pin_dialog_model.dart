import 'dart:developer';

import 'package:stacked/stacked.dart';

class DeletePinDialogModel extends BaseViewModel {
  void yesButton(String pinnedLocation) {
    log(pinnedLocation);
  }
}
