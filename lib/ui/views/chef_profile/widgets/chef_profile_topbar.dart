import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';

class ChefProfileTopBar extends ViewModelWidget<ChefProfileViewModel>
    implements PreferredSizeWidget {
  final bool? isCurrentUser;
  final UserModel user;

  const ChefProfileTopBar({required this.user, super.key, this.isCurrentUser});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceSmall,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: viewModel.moveBack,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 8.0.dg),
                  height: 36.h,
                  width: 36.w,
                  decoration: const BoxDecoration(
                    color: kcVeryLightGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: kcBlackColor,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.showBottomSheet(user);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 2.0.dg),
                  height: 36.h,
                  width: 36.w,
                  decoration: const BoxDecoration(
                    color: kcVeryLightGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      FlutterRemix.more_fill,
                      color: kcBlackColor,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
