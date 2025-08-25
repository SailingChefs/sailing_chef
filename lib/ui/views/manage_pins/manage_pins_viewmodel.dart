import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:sailing_chefs/services/user_services.dart';

class ManagePinsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _cullinaryService = locator<CullinaryschoolService>();
  final _chefService = locator<ChefService>();
  final _userService = locator<UserServices>();
  final pinsService = locator<PinDropService>();
  final _dialogService = locator<DialogService>();

  bool showShimmer = false;

  List<ListenableServiceMixin> get listenableServices =>
      [pinsService, _cullinaryService, _chefService, _userService];

  Future<void> setPinStatus(String recipeId, PinnedLocationStatus status) async {
    setBusy(true);
    await pinsService.updatePinStatus(recipeId, {'status': status.name});
    setBusy(false);
  }

  Future<void> onViewModelReady() async {
    showShimmer = true;

    await Future.wait([
      // pinsService.initialized(),
      // _cullinaryService.culinaryInit(),
      // _chefService.chefInit(),
    ]);

    showShimmer = false;

    notifyListeners();
    rebuildUi();
  }

  Future<void> toPinDetailsScreen(PinnedLocation pin) async {
    // final allUsers = <UserModel>[
    //   userDetails!,
    //   ..._chefService.chefs,
    //   ..._cullinaryService.cullinaryscools
    // ];

    // recipe.user = allUsers.firstWhere(
    //   (user) => user.uid == recipe.uid,
    //   orElse: UserModel.new,
    // );

    // if (recipe.user?.uid == null) {
    //   final userDoc = await _userService.fetchUserByUID(recipe.uid);
    //   if (userDoc.uid != null) {
    //     recipe.user = userDoc;
    //   }
    // }

    // await _navigationService.navigateWithTransition(
    //   popGesture: true,
    //   SavedRecipeDetailsView(
    //     isFromPrivateProfile: false,
    //     recipeModel: recipe,
    //     randomRecipeList: const [],
    //   ),
    //   curve: Curves.elasticInOut,
    //   duration: const Duration(),
    //   transitionStyle: Transition.rightToLeft,
    // );

    // notifyListeners();

    try {
      final place = await getCityCountry(
        pin.location.latitude,
        pin.location.longitude,
      );

      await _dialogService.showCustomDialog(
        variant: DialogType.pindetails,
        data: pin,
        title: place,
        barrierDismissible: true,
      );
    } catch (e) {
      log('Error showing pin details: $e');
      // showErrorDialog('Could not show location details');
    }
  }

  Future<String> getCityCountry(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      // ignore: unnecessary_null_comparison
      if (placemarks != null && placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.subLocality}, ${placemark.locality}, ${placemark.country}';
      }
      return 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  void getBack() {
    _navigationService.back();
  }
}
