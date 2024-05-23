import 'dart:developer';

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/services/block_user_service.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

import '../../../core/imports/core_imports.dart';
import '../../../model/user_model.dart';

class BlockedAccountsViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserServices _userService = locator<UserServices>();
  final BlockUserService _blockUserService = locator<BlockUserService>();
    final ChefService _chefService = locator<ChefService>();
  final CullinaryschoolService _cullinarySchoolService = locator<CullinaryschoolService>();
  
  final userService = locator<UserServices>();
  List<String> get blockedUsers => _blockUserService.blockedAccounts;

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  void back() {
    _navigationService.back();
  }

  Future<UserModel> findUserDetails({required String uid}) async {
    return await userService.fetchUserByUID(uid);
  }

  void unblockUser({required UserModel user}) async {
    userDetails!.blockedAccounts!.remove(user.uid);

    if (user.userRole == 'chef') {
      if (_chefService.chefs.contains(user)) {
        notifyListeners();
      }
      _chefService.chefs.add(user);
      notifyListeners();
    }
    else if(user.userRole == 'culinarySchool'){
      _cullinarySchoolService.cullinaryscools.add(user);
    }

    _blockUserService.updateCurrentUserModel(
        localModel: userDetails!, userId: user.uid!);



    notifyListeners();
    rebuildUi();

    log(user.uid!);
  }

  void selectMenuItem({required String option, required UserModel user}) {
    if (option == 'unblock') {
      unblockUser(user: user);
    }
    showToast(message: "User has been unblocked");
  }

  void onViewModelReady() async {
    setBusy(true);
    userDetails = await _userService.getUserDetails();
    _blockUserService.onInit();
    setBusy(false);
  }
}
