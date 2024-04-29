import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:stacked/stacked.dart';

import '../../common/show_toast.dart';

class BlockAccountDialogModel extends BaseViewModel {
  final _userService = locator<UserServices>();
  final _navigationService = locator<NavigationService>();

  void blockAccount(String uid) async {
    _navigationService.replaceWithBottomNavBarView();
    bool check = await _userService.updateBlockedAccounts([uid]);
    check
        ? showToast(message: "Account Blocked")
        : showToast(message: "Problem blocking Account");
  }
}
