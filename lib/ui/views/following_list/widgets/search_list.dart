
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class SearchList extends ViewModelWidget<FollowingListViewModel> {
  final List<UserModel> users;
  const SearchList({super.key, required this.users});

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return SizedBox(
      height: 500.h,
      child: ListView.builder(
        itemCount: viewModel.searchUsers(viewModel.searchController.text, users).length,
        itemBuilder: (context, index) {
           final UserModel user = viewModel.searchUsers(viewModel.searchController.text, users).elementAt(index);
    return Text(user.displayName!);

        
      })
    );
    
  }
}