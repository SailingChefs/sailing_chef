import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:stacked/stacked.dart';

class RecipeListPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  void popBack() {
    _navigationService.back();
  }
}
