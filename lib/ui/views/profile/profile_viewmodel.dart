import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/follow_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends ReactiveViewModel {
  bool isEdit = false;
  final _navigationService = locator<NavigationService>();
  final usrService = locator<UserServices>();
  final RecipeService _recipeService = locator<RecipeService>();
  final bottomsheetService = locator<BottomSheetService>();
  final SavedRecipeService _savedRecipeService = locator<SavedRecipeService>();
  final CullinaryschoolService _cullinarySchoolService = locator<CullinaryschoolService>();
  final FollowService _followService = locator<FollowService>();

  String selectedTab = 'Myrecipes';
  bool isMySelected = true;
  bool isSavedSelected = false;

  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;

  List<String> get followingList => _followService.following;
  List<String> get followersList => _followService.followers;

  List<RecipeModel>? myRecipes;

  void navigateToBlockScreen() {
    _navigationService.navigateToBlockedAccountsView();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_savedRecipeService, _followService];

  // List<SavedRecipeModel> get fetchSavedRecipesList {
  //   return _savedRecipeService.savedRecipes;
  // }

  List<Placemark>? placemarks;

  // A function to handle the selection of my recipe, updating the relevant flags and triggering UI updates.
  void myRecipeSelected() {
    isMySelected = true;
    isSavedSelected = false;
    notifyListeners();
    rebuildUi();
  }

  Future<void> onClickUrl(String url) async {
    Uri uri = Uri.parse("https://$url");
    // if (await canLaunchUrlString(url)) {
    //   launchUrlString(url, );
    // }
    await launchUrl(uri);
  }

  // A function to set the isSavedSelected flag to true, isMySelected flag to false, notify listeners, and rebuild the UI.
  void savedSelected() async {
    await _savedRecipeService.init();
    isSavedSelected = true;

    isMySelected = false;
    notifyListeners();
    rebuildUi();
  }

  getUserLocation() async {
    if (userDetails?.location?['latitude'] == null) {
      return '';
    }

    placemarks = await placemarkFromCoordinates(
        userDetails!.location!['latitude'],
        userDetails!.location!['longitude']);
  }

  void goTogoToProfileEditView() {
    _navigationService.navigateTo(Routes.followingListView,
        arguments: FollowingListViewArguments(user: userDetails!));
  }

  // A function that navigates to the settings view.
  void toSettings() {
    _navigationService.navigateToSettingsView();
  }

  // A function that handles the tab based on the given index.
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
  List<Course> courses = [];
  void onViewModelReady() async {
    setBusy(true);
    await getUserLocation();
    await _savedRecipeService.init();
    await _followService.init(userDetails!.uid!, false);
    myRecipes = await _recipeService.fetchRecipesByUID(userDetails!.uid!);

    courses = await _cullinarySchoolService.getCoursesFromDatabase(userId: userDetails!.uid!);
    setBusy(false);
  }

  void toDishesScreen() {
    // _navigationService.navigateToRecipeListPageView(
    //   isFromProfileView: true,
    // );
    _navigationService.navigateToAddRecipeView(isFromProfileView: true);
  }

  void toDishDetailsScreen(index) {
    _navigationService.navigateToSavedRecipeDetailsView(
      recipeModel: myRecipes![index],
    );
  }

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
