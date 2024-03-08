import 'package:sailing_chefs/core/imports/core_imports.dart';

class IndexViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  TextEditingController searchController = TextEditingController();

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  void goToSearchView() {
    // _navigationService.navigateTo;
  }
}
