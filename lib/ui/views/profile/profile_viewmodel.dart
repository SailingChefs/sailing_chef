import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends ReactiveViewModel {
  bool isEdit = false;
  final _navigationService = locator<NavigationService>();
  final ScrollController scrollController = ScrollController();
  final usrService = locator<UserServices>();
  final _recipeService = locator<RecipeService>();

  final bottomsheetService = locator<BottomSheetService>();
  final SavedRecipeService _savedRecipeService = locator<SavedRecipeService>();
  final _chefService = locator<ChefService>();
  final CullinaryschoolService _cullinarySchoolService =
      locator<CullinaryschoolService>();

  String selectedTab = 'Myrecipes';
  bool isMySelected = true;
  bool isSavedSelected = false;

  List<RecipeModel> savedRecipes = [];
  List<Course> get courses => _cullinarySchoolService.courses;
  List<UserModel> get cullinary => _cullinarySchoolService.cullinaryscools;
  List<UserModel> get chefs => _chefService.chefs;
  // List<RecipeModel> savedRecipes =[];
  List<RecipeModel> myRecipes = [];

  void navigateToBlockScreen() {
    _navigationService.navigateToBlockedAccountsView();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_savedRecipeService, _cullinarySchoolService];

  void myRecipeSelected() {
    isMySelected = true;
    isSavedSelected = false;
    notifyListeners();
    rebuildUi();
  }

  Future<void> onClickUrl(String url) async {
    Uri uri = Uri.parse("https://$url");

    await launchUrl(uri);
  }

  void savedSelected() async {
    isSavedSelected = true;

    isMySelected = false;
    notifyListeners();
    rebuildUi();
  }

  void goToFollowerList() {
    _navigationService.navigateTo(Routes.followingListView,
        arguments: FollowingListViewArguments(
            user: userDetails!, isfromFollowing: false));
  }

  void goToFollowingList() {
    _navigationService.navigateTo(Routes.followingListView,
        arguments: FollowingListViewArguments(
            user: userDetails!, isfromFollowing: true));
  }

  void toSettings() {
    _navigationService.navigateToSettingsView();
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Myrecipes';
        break;
      case 1:
        selectedTab = 'Saved';
        break;
      default:
        break;
    }

    rebuildUi();
  }

  Future<void> myRecipesList() async {
    if (RecipeService.recipes.isEmpty) {
      myRecipes = await _recipeService.fetchRecipesByUID(userDetails!.uid!);
      return;
    } else if (RecipeService.recipes.isNotEmpty) {
      for (var recipes in RecipeService.recipes) {
        if (recipes.uid == userDetails!.uid) {
          myRecipes.add(recipes);
        }
      }
    }
  }

  Future<void> matchAndAssignUsersToDishes() async {
    // Combine both user lists into one for easier searching
    List<UserModel> allUsers = [...chefs, ...cullinary];

    for (int i = 0; i < savedRecipes.length; i++) {
      if (savedRecipes[i].user == null) {
        // Find the matching user in the allUsers list
        UserModel? matchingUser = allUsers.firstWhere(
          (user) => user.uid == savedRecipes[i].uid,
          orElse: () => UserModel(uid: ''),
        );
        if (matchingUser.uid != null) {
          // Assign the matching user to the corresponding dish
          savedRecipes[i].user = matchingUser;
          if (userDetails!.uid == savedRecipes[i].uid) {
            savedRecipes[i].user = userDetails!;
          }
        }
      }
    }
  }

  void toFilterView() {
    _navigationService.navigateToFilterView();
  }

  Future<void> mySavedRecipes() async {
    if (RecipeService.recipes.isEmpty) {
      await _recipeService.initialized();
      return;
    } else {
      for (var recipe in RecipeService.recipes) {
        if (userDetails!.savedRecipes!
            .any((element) => element == recipe.docId)) {
          savedRecipes.add(recipe);
        }
      }
    }
  }

  void onViewModelReady() async {
    setBusy(true);
    await myRecipesList();
    await mySavedRecipes();
    await matchAndAssignUsersToDishes();

    await Future.wait([
      // _savedRecipeService.init(),
      _cullinarySchoolService.cullinaryCoursesInit(userDetails!.uid!)
    ]);
    notifyListeners();
    userDetails = await usrService.getUserDetails();
    notifyListeners();
    setBusy(false);
  }

  Future<void> ini() async {}

  void toDishesScreen() {
    scrollController.animateTo(
      scrollController.position.devicePixelRatio * 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void toDishDetailsScreen(int index, RecipeModel recipeModel) {
    _navigationService.navigateWithTransition(
      SavedRecipeDetailsView(
          recipeModel: recipeModel,
          randomRecipeList: IndexViewModel.getRandomDishes(
              recipeModel, RecipeService.recipes)),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      transitionStyle: Transition.downToUp,
    );
  }

  // void toDishDetailsScreen(index) {
  //   log('index is $index');
  //   log('myRecipes is ${myRecipes![index]}');
  //   _navigationService.navigateToSavedRecipeDetailsView(
  //     recipeModel: myRecipes![index],
  //     recipeList: IndexViewModel.getRandomDishes(myRecipes![index], myRecipes!),
  //   );
  // }

  void callCourseNameBottomSheet() {
    bottomsheetService.showCustomSheet(
      variant: BottomSheetType.courses,
    );
  }

  void callCourseNameBottomSheett(Course course) {
    bottomsheetService.showCustomSheet(
      variant: BottomSheetType.courses,
      data: course,
    );
  }
}
