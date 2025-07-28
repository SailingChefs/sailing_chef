import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class SearchList extends ViewModelWidget<FollowingListViewModel> {
  final List<UserModel> users;
  final bool isFromFollowingList;

  const SearchList(
      {super.key, required this.users, required this.isFromFollowingList});

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return SizedBox(
      height: 500.h,
      child: ListView.builder(
        itemCount: viewModel
            .searchUsers(viewModel.searchController.text, users)
            .length,
        itemBuilder: (context, index) {
          final UserModel user = viewModel
              .searchUsers(viewModel.searchController.text, users)
              .elementAt(index);
          return ListTile(
            onTap: () {
              viewModel.toUserDetails(user);
            },
            leading: CircleAvatar(
              backgroundImage: ImageUtils.safeNetworkImageForAvatar(
                user.displayPicture,
              ),
            ),
            title: Text(
              user.displayName!,
              style: globalTextStyle(
                fontSize: 14.sp,
                letterSpacing: -0.5,
                fontWeight: FontWeight.w600,
                color: kcBlackColor,
              ),
            ),
            trailing: isFromFollowingList && user.uid == userDetails!.uid
                ? SizedBox(
                    width: 112,
                    height: 35,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            viewModel.followingUsers
                                    .contains(viewModel.followingUsers[index])
                                ? kcPrimaryColor.withOpacity(0.5)
                                : kcPrimaryColor),
                      ),
                      onPressed: () {
                        viewModel
                            .removeFollowing(viewModel.followingUsers[index]);
                      },
                      child: Text(
                        viewModel.followingUsers
                                .contains(viewModel.followingUsers[index])
                            ? 'Following'
                            : 'Follow',
                        style: TextStyle(
                            color: kcwhitecolor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
