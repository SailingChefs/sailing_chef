
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/follow_service.dart';

class FollowingListViewModel extends BaseViewModel {
  final _navigationloactor = locator<NavigationService>();
  final FollowService _followService = locator<FollowService>();
  final TextEditingController searchController = TextEditingController();
  bool isFollowing = false;
  bool isFollower = true;
  List<String> get following => _followService.following;
  List<String> get followers => _followService.followers;
  List<UserModel> get followingUsers => _followService.usersFollowing;
  List<UserModel> get followersUsers => _followService.usersFollowers;
  void popBack() {
    _navigationloactor.back();
  }

  void onViewModelReady(String userId) async {
    setBusy(true);
    await _followService.init(userId, true);
    setBusy(false);
  }

  Iterable<UserModel> searchUsers(String query, List<UserModel> users) sync* {


    for (var user in users) {
      if (user.displayName!.toLowerCase().contains(query.toLowerCase())) {
        yield user;
      }
    }

  }
  
 
  void onFollowTap(UserModel user) async {
   await _followService.removeFollowing(user);
   rebuildUi();
  }
  void deleteFollower(UserModel user) async {
    await _followService.deleteFollower(user);
    rebuildUi();
  }
  void toUserDetails(UserModel user) {
    _navigationloactor.navigateToChefProfileView(user: user);
  }

  void updateFollowing() {
    isFollowing = true;
    isFollower = false;
    notifyListeners();
    rebuildUi();
  }

  void updateFollower() {
    isFollower = true;
    isFollowing = false;
    notifyListeners();
    rebuildUi();
  }
}

