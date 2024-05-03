import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/chef_service.dart';

import '../../../model/user_model.dart';

class AllChefsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();

  List<UserModel> chefList = [];

  Future<void> fetchChefs() async {
    try {
      chefList = await _chefService.fetchChefDocuments();
      setBusy(false);
    } catch (error) {
      setError(error.toString());
      setBusy(false);
    }
  }

  void toChefProfile(UserModel chef) async {
    _navigationService.navigateToChefProfileView(user: chef);
  }

  toHomeView() {
    _navigationService.back();
  }
}
