import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class TabBarsFollowing extends ViewModelWidget<FollowingListViewModel> {
 
  const TabBarsFollowing({super.key });

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return Container(
      height: 50.h,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              viewModel.updateFollower();
            },
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: viewModel.isFollower == true
                        ? Colors.black
                        : Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 35.0),
                child: Text(
                  '${viewModel.followersUsers.length} Followers',
                  style: globalTextStyle(
                    fontSize: 14.0.sp,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.bold,
                    color: kcBlackColor,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.updateFollowing();
            },
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: viewModel.isFollowing == true
                        ? Colors.black
                        : Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                child: Text(
                  '${viewModel.followingUsers.length} Following',
                   style: globalTextStyle(
                    fontSize: 14.0.sp,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.bold,
                    color: kcBlackColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
