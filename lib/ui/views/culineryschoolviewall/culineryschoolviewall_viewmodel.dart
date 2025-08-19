import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';

class CulineryschoolviewallViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _cullinaryService = locator<CullinaryschoolService>();
  List<UserModel> get cullinary => _cullinaryService.cullinaryscools;
  void toHomeView() {
    _navigationService.back();
  }

  Future<void> onViewModelReady() async {
    setBusy(true);
    await Future.wait([
      _cullinaryService.culinaryInit(),
      // getUserLocation(),
    ]);

    setBusy(false);
  }

  void toUserDetails(UserModel user) {
    _navigationService.navigateToChefProfileView(
        user: user, preventDuplicates: false);
  }

  List<Placemark> placemarks = [];
}
