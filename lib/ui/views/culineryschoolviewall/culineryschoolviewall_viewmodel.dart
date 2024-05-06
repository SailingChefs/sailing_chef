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
    await  getUserLocation();
    setBusy(false);
  }

  List<Placemark> ? placemarks;

  getUserLocation() async {
    if (cullinary.first.location?['latitude'] == null) {
      return '';
    }

    placemarks = await placemarkFromCoordinates(
        cullinary.first.location!['latitude'],
        cullinary.first.location!['longitude']);
  }
}
