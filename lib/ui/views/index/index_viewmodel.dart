
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/dish_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';

class IndexViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  TextEditingController searchController = TextEditingController();
  final _chefService = locator<ChefService>();
  List<UserModel>? chefList;
  List<DishModel> dishes=[
    DishModel(
        
         dishId: '1', dishName: 'Healthy Taco Salad', dishImagePath: 'assets/images/icons/chef.jpg', dishPreparationTime: '20', dishChefImage:'assets/images/icons/dp.jpg',),
  DishModel(
        
         dishId: '2', dishName: 'Healthy Sandwich', dishImagePath: 'assets/images/icons/chef.jpg', dishPreparationTime: '30', dishChefImage:'assets/images/icons/dp.jpg',),
  ];

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

  void toChefProfile(UserModel chef) {
    _navigationService.navigateToChefProfileView(user: chef);
  }

  void toDishDetailsScreen() {
    _navigationService.navigateTo(Routes.savedRecipeDetailsView);
  }
}