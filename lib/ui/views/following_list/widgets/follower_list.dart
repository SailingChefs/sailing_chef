// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class FollowerList extends ViewModelWidget<FollowingListViewModel> {
  

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {

    return viewModel.followers.isEmpty ? Text('No Followers') :
    Column(
      children: [
        Text(
          'All Followers',
        ),
        Container(
          height: 500,
          width: double.infinity,
          child: ListView.builder(
            itemCount: viewModel.followersUsers.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    viewModel.followersUsers[index].displayPicture!,
                  ),
                ),
                title: Text(viewModel.followersUsers[index].displayName!),
                trailing: SizedBox(
                  width: 71,
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
                      'remove',
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
