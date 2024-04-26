// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class FollowingList extends ViewModelWidget<FollowingListViewModel> {
  

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {

    return viewModel.following.isEmpty ? Text('No Following') :
    Container(
      height: 500,
      width: double.infinity,
      child: ListView.builder(
        itemCount: viewModel.followingUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                viewModel.followingUsers[index].displayPicture!,
              ),
            ),
            title: Text(viewModel.followingUsers[index].displayName!),
            trailing: SizedBox(
              width: 109,
              height: 34,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kcPrimaryColor),
                ),
                onPressed: () {},
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
        },
      ),
    );
  }
}
