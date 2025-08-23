import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class ManageRecipesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final recipeService = locator<RecipeService>();
  final _cullinaryService = locator<CullinaryschoolService>();
  final _chefService = locator<ChefService>();
  final _userService = locator<UserServices>();

  bool showShimmer = false;

  List<ListenableServiceMixin> get listenableServices =>
      [recipeService, _cullinaryService, _chefService, _userService];

  Future<void> setRecipeAsReview(String recipeId) async {
    setBusy(true);
    await recipeService.updateRecipeStatus(recipeId, {'status': 'review'});
    setBusy(false);
  }

  Future<void> setRecipeAsPublished(String recipeId) async {
    setBusy(true);
    await recipeService.updateRecipeStatus(recipeId, {'status': 'published'});
    setBusy(false);
  }

  Future<void> onViewModelReady() async {
    showShimmer = true;

    await Future.wait([
      recipeService.initialized(),
      _cullinaryService.culinaryInit(),
      _chefService.chefInit(),
    ]);

    showShimmer = false;

    notifyListeners();
    rebuildUi();
  }

  Future<void> toDishDetailsScreen(RecipeModel recipe) async {
    final allUsers = <UserModel>[
      userDetails!,
      ..._chefService.chefs,
      ..._cullinaryService.cullinaryscools
    ];

    recipe.user = allUsers.firstWhere(
      (user) => user.uid == recipe.uid,
      orElse: UserModel.new,
    );

    if (recipe.user?.uid == null) {
      final userDoc = await _userService.fetchUserByUID(recipe.uid);
      if (userDoc.uid != null) {
        recipe.user = userDoc;
      }
    }

    await _navigationService.navigateWithTransition(
      popGesture: true,
      SavedRecipeDetailsView(
        isFromPrivateProfile: false,
        recipeModel: recipe,
        randomRecipeList: const [],
      ),
      curve: Curves.elasticInOut,
      duration: const Duration(),
      transitionStyle: Transition.rightToLeft,
    );

    notifyListeners();
  }

  void getBack() {
    _navigationService.back();
  }
}
