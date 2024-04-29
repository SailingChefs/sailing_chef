// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class FollowerList extends ViewModelWidget<FollowingListViewModel> {
  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return viewModel.followers.isEmpty
        ? Text('No Followers')
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
                  'All Followers',
                  style: globalTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: kcBlackColor,
            )
          ),
        ),
              Container(
                height: 500,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: viewModel.followersUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                  viewModel.toUserDetails(viewModel.followersUsers[index]);
                },
                leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          viewModel.followersUsers[index].displayPicture!,
                        ),
                      ),
                      title: Text(viewModel.followersUsers[index].displayName!),
                      trailing: SizedBox(
                        width: 80.w,
                        height: 34.h,
                        child: TextButton(
                          style: ButtonStyle(
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                kcPrimaryColor),
                          ),
                          onPressed: () {
                      print('Tapped');
                      viewModel.deleteFollower(viewModel.followersUsers[index]);
                    },
                          child: Text(
                            'Remove',
                            style: TextStyle(
                                color: kcwhitecolor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
