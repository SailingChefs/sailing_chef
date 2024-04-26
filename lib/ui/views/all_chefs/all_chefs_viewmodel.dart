import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../../../model/user_model.dart';

class AllChefsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void toChefProfile(UserModel chef) {
    _navigationService.navigateToChefProfileView(user: chef);
  }

  toHomeView() {
    _navigationService.back();
  }
}
