import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_viewmodel.dart';

class RecipeListPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RecipeService _recipeService = locator<RecipeService>();
  List<RecipeModel>? recipes;
  void onViewModelReady() async {
    setBusy(true);
    recipes =
        await _recipeService.fetchRecipesByUID(firebaseAuth.currentUser!.uid);
    
    setBusy(false);
  }

  void toHomeView() {
    // locator.removeRegistrationIfExists<BottomNavBarViewModel>();
            // locator.registerLazySingleton<BottomNavBarViewModel>(
            //     () => BottomNavBarViewModel());
                _navigationService.popRepeated(2);
    // _navigationService.replaceWithTransition(
    //   const BottomNavBarView(),
    //   transitionStyle: Transition.fade,
    //   duration: const Duration(milliseconds: 300),
    //   );
  }
}
