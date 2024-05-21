import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
class ChefProfileDetailsDesc extends ViewModelWidget<ChefProfileViewModel> {
  const ChefProfileDetailsDesc({required this.user, super.key});
  final UserModel user;
  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: kcVeryLightGrey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: user.displayPicture!.isEmpty
                        ? const AssetImage('assets/images/misc/blank_image.png')
                        : NetworkImage(user.displayPicture!) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizontalSpaceSmall,
              GestureDetector(
                onTap: viewModel.toDishesScreen,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.recipes!.length.toString(),
                      style: globalTextStyle(
                        fontSize: 18.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w600,
                        color: kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Dishes',
                      style: globalTextStyle(
                        fontSize: 14.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w400,
                        color: kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpaceSmall,
              GestureDetector(
                onTap: viewModel.goToFollowingList,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      viewModel.followers.length.toString(),
                      style: globalTextStyle(
                        fontSize: 18.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w600,
                        color: kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Followers',
                      style: globalTextStyle(
                        fontSize: 14.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w400,
                        color: kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpaceSmall,
              GestureDetector(
                onTap: viewModel.goToFollowingList,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.following!.length.toString(),
                      style: globalTextStyle(
                        fontSize: 18.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w600,
                        color: kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Following',
                      style: globalTextStyle(
                        fontSize: 14.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w400,
                        color: kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
            ),
          
            ],
          )
        ],
      ),
    );
  }
}