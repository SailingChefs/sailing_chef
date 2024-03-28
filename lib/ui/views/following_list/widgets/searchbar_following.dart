import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class SearchBarFollwoing extends ViewModelWidget<FollowingListViewModel> {
  const SearchBarFollwoing({super.key});

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
            color: kcWhiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.search_rounded,
                  color: kcBlackColor.withOpacity(0.5),
                  size: 22.dg,
                ),
                horizontalSpaceSmall,
                Text(
                  'Search',
                  style: globalTextStyle(
                    fontSize: 16.sp,
                    color: kcBlackColor.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
