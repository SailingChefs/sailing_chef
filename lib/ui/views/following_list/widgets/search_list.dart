import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class SearchList extends ViewModelWidget<FollowingListViewModel> {
  final List<UserModel> users;
  final bool isFromFollowingList;
  const SearchList({super.key, required this.users,required this.isFromFollowingList});

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
                  backgroundImage: NetworkImage(
                    user.displayPicture!,
                  ),
                ),
                title: Text(user.displayName!),
                trailing: SizedBox(
                  width: 80.w,
                  height: 34.h,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kcPrimaryColor),
                    ),
                    onPressed: () {
                      viewModel.deleteFollower(user);
                    },
                    child: Text(
                      'Following',
                      style: TextStyle(
                          color: kcwhitecolor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            }));
  }
}
