import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';

class ProfileDetailsProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const ProfileDetailsProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            height: 90.h,
            width: 90.w,
            decoration: const BoxDecoration(
              color: kcVeryLightGrey,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: userDetails!.displayPicture == ''
                    ? Image.asset(
                        'assets/images/misc/blank_image.png',
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        userDetails!.displayPicture!,
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90,
                      )),
          ),
          horizontalSpaceMedium,
          horizontalSpaceSmall,
          GestureDetector(
            onTap: viewModel.toDishesScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  viewModel.myRecipes!.length.toString(),
                  style: globalTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor.withOpacity(0.6)),
                ),
                verticalSpaceTiny,
                Text(
                  'Dishes',
                  style: globalTextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          horizontalSpaceMedium,
          horizontalSpaceSmall,
          GestureDetector(
            onTap: viewModel.goTogoToProfileEditView,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  viewModel.followersList.length.toString(),
                  style: globalTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor.withOpacity(0.6)),
                ),
                verticalSpaceTiny,
                Text(
                  'Followers',
                  style: globalTextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          horizontalSpaceMedium,
          horizontalSpaceSmall,
          GestureDetector(
            onTap: viewModel.goTogoToProfileEditView,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  viewModel.followingList.length.toString(),
                  style: globalTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor.withOpacity(0.6)),
                ),
                verticalSpaceTiny,
                Text(
                  'Following',
                  style: globalTextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
