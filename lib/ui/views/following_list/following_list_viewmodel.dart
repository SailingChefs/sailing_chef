import 'dart:developer';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/follow_service.dart';
import 'package:sailing_chefs/services/user_services.dart';

class FollowingListViewModel extends BaseViewModel {
  final bool isFromFollowing;
  FollowingListViewModel({required this.isFromFollowing});
  final _navigationloactor = locator<NavigationService>();
  final FollowService _followService = locator<FollowService>();
  final UserServices _userService = locator<UserServices>();
  final TextEditingController searchController = TextEditingController();
  bool isFollowing = false;
  bool isFollower = true;
  List<UserModel> get followersUsers => _followService.usersFollowers;
  List<UserModel> get followingUsers => _followService.usersFollowing;
  void popBack() {
    _navigationloactor.back();
  }

  void onViewModelReady(String userId) async {
    setBusy(true);
    await _followService.init(userId, true);
    isFollowing = isFromFollowing;
    isFollower = !isFromFollowing;
    notifyListeners();
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
    notifyListeners();
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

// Inside FollowingListViewModel
  Future<void> removeFollowing(UserModel user) async {
    try {
      await _followService.removeFollowing(user);
      followingUsers.removeWhere((follower) => follower.uid == user.uid);
      notifyListeners();
    } catch (e) {
      // Handle errors if necessary
      log(e.toString());
    }
  }

  void updateFollower() {
    isFollower = true;
    isFollowing = false;
    notifyListeners();
    rebuildUi();
  }

  Future<UserModel> getUserById(String followerId) async {
    return await _userService.fetchUserByUID(followerId);
  }
}
