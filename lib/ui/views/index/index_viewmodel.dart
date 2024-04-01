import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';

class IndexViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  TextEditingController searchController = TextEditingController();
  final _chefService = locator<ChefService>();
  List<UserModel>? chefList;

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  void onViewModelReady() async {
    setBusy(true);
    chefList = await _chefService.fetchChefDocuments();
    setBusy(false);
  }

  void goToSearchView() {
    // _navigationService.navigateTo;
  }
}
