import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../../../model/user_model.dart';

class AllChefsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  TextEditingController searchController = TextEditingController();

  Iterable<UserModel> searchUsers(List<UserModel> chefs) sync* {
    log("came to search func");
    log("Searched query --------->  ${searchController.text}");
    log("total cheffs --------->  ${chefs.length}");

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
