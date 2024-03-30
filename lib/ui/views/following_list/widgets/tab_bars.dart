import 'dart:developer';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class TabBarsFollowing extends ViewModelWidget<FollowingListViewModel> {
  const TabBarsFollowing({super.key});

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
              viewModel.updateFollowing();
              viewModel.updateFollower();
              log('following');
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 35.0),
                child: Text(
                  '98 Followers',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.updateFollowing();
              viewModel.updateFollower();
              log('Followers');
            },
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: viewModel.isFollowing == false
                        ? Colors.black
                        : Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                child: Text(
                  '108 Following',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
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
