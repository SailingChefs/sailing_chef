import 'dart:developer';

import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

import '../../../core/imports/core_imports.dart';
import '../../../model/user_model.dart';

class BlockedAccountsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final userService = locator<UserServices>();

  void back() {
    _navigationService.back();
  }

  Future<UserModel> findUserDetails({required String uid}) async {
    return await userService.fetchUserByUID(uid);
  }

  void unblockUser({required String uid}) async {
    userService.currentUserDetails!.blockedAccounts!.remove(uid);
    rebuildUi();
    userService.updateCurrentUserModel(
        localModel: userService.currentUserDetails!);

    log(uid);
  }

  void selectMenuItem({required String option, required String uid}) {
    if (option == 'unblock') {
      unblockUser(uid: uid);
    }
    showToast(message: "User has been unblocked");
  }
}
