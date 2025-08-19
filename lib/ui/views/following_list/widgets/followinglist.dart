// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';
import 'package:sailing_chefs/ui/views/following_list/widgets/search_list.dart';
import 'package:sailing_chefs/ui/views/following_list/widgets/searchbar_following.dart';

class FollowingList extends ViewModelWidget<FollowingListViewModel> {
  final UserModel user;

  const FollowingList({required this.user, super.key, super.reactive});
  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return viewModel.followingUsers.isEmpty
        ? Column(
            children: [
              verticalSpaceMassive,
              verticalSpaceMassive,
              Center(child: Text('No Following')),
            ],
          )
        : Column(
            children: [
              const SearchBarFollwoing(),
              if (viewModel.searchController.text.isNotEmpty) SearchList(
                      users: viewModel.followingUsers,
                      isFromFollowingList: true,
                    ) else Container(
                      height: 500,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: viewModel.followingUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              viewModel.toUserDetails(
                                  viewModel.followingUsers[index]);
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  ImageUtils.safeNetworkImageForAvatar(
                                viewModel.followingUsers[index].displayPicture,
                              ),
                            ),
                            title: Text(
                                viewModel.followingUsers[index].displayName!),
                            trailing: user.uid == userDetails!.uid
                                ? SizedBox(
                                    width: 112,
                                    height: 35,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        )),
                                        backgroundColor: MaterialStateProperty
                                            .all<Color>(viewModel.followingUsers
                                                    .contains(viewModel
                                                        .followingUsers[index])
                                                ? kcPrimaryColor
                                                    .withOpacity(0.5)
                                                : kcPrimaryColor),
                                      ),
                                      onPressed: () {
                                        viewModel.removeFollowing(
                                            viewModel.followingUsers[index]);
                                      },
                                      child: Text(
                                        viewModel.followingUsers.contains(
                                                viewModel.followingUsers[index])
                                            ? 'Following'
                                            : 'Follow',
                                        style: TextStyle(
                                            color: kcwhitecolor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          );
                        },
                      ),
                    ),
            ],
          );
  }
}
