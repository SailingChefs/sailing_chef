import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

class TopBarFollowingList extends ViewModelWidget<FollowingListViewModel>
    implements PreferredSizeWidget {
  const TopBarFollowingList({super.key});

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return AppBar(
      title: Text(
        capitalizeEachWord('Chef Name'),
        style: globalTextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.w700, color: kcBlackColor),
      ),
      centerTitle: true,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => viewModel.popBack(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10.0.dg),
          height: 25.h,
          width: 25.w,
          decoration: const BoxDecoration(
            color: kcVeryLightGrey,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios,
            color: kcBlackColor,
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
