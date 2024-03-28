import 'package:sailing_chefs/core/imports/core_imports.dart';

class FollowingListViewModel extends BaseViewModel {
  final _navigationloactor = locator<NavigationService>();
  bool isFollowing = false;
  bool isFollower = true;
  void popBack() {
    _navigationloactor.back();
  }

  void updateFollowing() {
    isFollowing = !isFollowing;
    notifyListeners();
    rebuildUi();
  }

  void updateFollower() {
    isFollower = !isFollower;
    notifyListeners();
    rebuildUi();
  }
}
