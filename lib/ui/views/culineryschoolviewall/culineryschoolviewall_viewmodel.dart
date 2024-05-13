import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';

class CulineryschoolviewallViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _cullinaryService = locator<CullinaryschoolService>();
  List<UserModel> get cullinary => _cullinaryService.cullinaryscools;
  toHomeView() {
    _navigationService.back();
  }

  void onViewModelReady() async {
    setBusy(true);
    await _cullinaryService.culinaryInit();
    await getUserLocation();
    setBusy(false);
  }

  toUserDetails(UserModel user) {
    _navigationService.navigateToChefProfileView(
        user: user, preventDuplicates: false);
  }

  List<Placemark> placemarks = [];

  Future<void> getUserLocation() async {
    for (var cullinary in cullinary) {
      if (cullinary.location?['latitude'] == null ||
          cullinary.location?['longitude'] == null) {
        placemarks.add(const Placemark()); // Add an empty Placemark to the list
      } else {
        List<Placemark> currentPlacemarks = await placemarkFromCoordinates(
          cullinary.location!['latitude'],
          cullinary.location!['longitude'],
        );
        placemarks.addAll(currentPlacemarks);
        // Log each Placemark added to the list
      }
    }
  }
}
