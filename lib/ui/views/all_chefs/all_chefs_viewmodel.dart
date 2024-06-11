import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../../../model/user_model.dart';

class AllChefsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  TextEditingController searchController = TextEditingController();
  void back() {
   _navigationService.back();
  }

  Iterable<UserModel> searchUsers(List<UserModel> chefs) sync* {
    for (var user in chefs) {
      if (user.displayName!
          .toLowerCase()
          .contains(searchController.text.toLowerCase())) {
        log("Searched Cheff --------->  ${user.displayName!.toLowerCase()}");
        yield user;
      }
    }
  }

  void toChefProfile(UserModel chef) async {
    _navigationService.navigateToChefProfileView(user: chef);
  }

  toHomeView() {
    _navigationService.back();
  }
}
