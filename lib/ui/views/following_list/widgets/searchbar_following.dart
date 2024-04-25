import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class SearchBarFollwoing extends ViewModelWidget<FollowingListViewModel> {
  const SearchBarFollwoing({super.key});

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.89,
            height: 40.dg,
            child: TextField(
              controller: viewModel.searchController,
              onChanged: (value) => viewModel.searchUsers(value , viewModel.followingUsers),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: kcBlackColor.withOpacity(0.6),
                  fontSize: 12.sp,
                ),
                fillColor: kcPrimaryColor.withOpacity(0.2),
                labelStyle: TextStyle(
                    fontSize: 17.sp, color: kcBlackColor.withOpacity(0.6)),
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(color: kcBlackColor.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(color: kcBlackColor.withOpacity(0.2)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: const BorderSide(
                    color: kcErrorColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: const BorderSide(
                    color: kcErrorColor,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                prefixIcon: Icon(
                  FlutterRemix.search_line,
                  color: kcBlackColor.withOpacity(0.6),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
