import 'dart:developer';

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

import '../../../core/imports/core_imports.dart';
import '../../../model/user_model.dart';

class BlockedAccountsViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserServices _userService = locator<UserServices>();
  final userService = locator<UserServices>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  void back() {
    _navigationService.back();
  }

  Future<UserModel> findUserDetails({required String uid}) async {
    return await userService.fetchUserByUID(uid);
  }

  void unblockUser({required String uid}) async {
    userService.currentUserDetails!.blockedAccounts!.remove(uid);

    userService.updateCurrentUserModel(
        localModel: userService.currentUserDetails!);
    notifyListeners();
    rebuildUi();

    log(uid);
  }

  void selectMenuItem({required String option, required String uid}) {
    if (option == 'unblock') {
      unblockUser(uid: uid);
    }
    showToast(message: "User has been unblocked");
  }

  void onViewModelReady() async {
    setBusy(true);
    userDetails = await _userService.getUserDetails();
    setBusy(false);
  }
}
