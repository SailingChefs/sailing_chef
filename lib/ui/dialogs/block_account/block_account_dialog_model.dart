import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/block_user_service.dart';
import '../../common/show_toast.dart';

class BlockAccountDialogModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _blockedAccountService = locator<BlockUserService>();

  void blockAccount(String uid) async {
    bool check = await _blockedAccountService.updateBlockedAccounts([uid]);
    check
        ? showToast(message: "Account Blocked")
        : showToast(message: "Problem blocking Account");

    _navigationService.replaceWithBlockedAccountsView();
  }
}
