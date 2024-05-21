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
          decoration: BoxDecoration(
            color: kcVeryLightGrey,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: userDetails!.displayPicture!.isEmpty
                  ? const AssetImage('assets/images/misc/blank_image.png')
                  : NetworkImage(userDetails!.displayPicture!) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
          horizontalSpaceMedium,
          GestureDetector(
            onTap: viewModel.toDishesScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  viewModel.myRecipes.length.toString(),
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
                  userDetails!.followers!.length.toString(),
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
                  userDetails!.following!.length.toString(),
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
