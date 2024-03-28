import 'package:sailing_chefs/core/imports/core_imports.dart';

class RecipeListPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  void popBack() {
    _navigationService.back();
  }
}
