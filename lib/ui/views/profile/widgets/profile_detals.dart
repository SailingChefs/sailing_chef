import 'package:cached_network_image/cached_network_image.dart';
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
          GestureDetector(
            onTap: () {
              viewModel.profileShare(
                  context,
                  userDetails!.displayPicture!.isEmpty
                      ? 'assets/images/misc/blank_image.png'
                      : userDetails!.displayPicture!,
                  userDetails!.displayPicture!.isEmpty ? 'asset' : 'network');
            },
            child: Hero(
              tag: 'profileShareOption',
              child: Container(
                height: 90.h,
                width: 90.w,
                decoration: const BoxDecoration(
                  color: kcVeryLightGrey,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: userDetails!.displayPicture!.isEmpty
                      ? const Image(
                          image: AssetImage('assets/images/misc/blank_image.png'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : CachedNetworkImage(
                          imageUrl: userDetails!.displayPicture!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          progressIndicatorBuilder: (context, url, progress) => Container(
                            decoration: const BoxDecoration(
                              color: kcsgreycolor,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          horizontalSpaceMedium,
          if (userDetails!.userRole == 'culinarySchool')
            Column(
              children: [
                Text(
                  viewModel.courses.length.toString(),
                  style: globalTextStyle(
                    fontSize: 18.sp,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor.withOpacity(0.6),
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  'Courses',
                  style: globalTextStyle(
                    fontSize: 14.sp,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w400,
                    color: kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ],
            )
          else
            GestureDetector(
              onTap: viewModel.toDishesScreen,
              child: Column(
                children: [
                  Text(
                    viewModel.myRecipes.length.toString(),
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
          horizontalSpaceMedium,
          horizontalSpaceSmall,
          GestureDetector(
            onTap: viewModel.goToFollowerList,
            child: Column(
              children: [
                Text(
                  userDetails!.followers!.length.toString(),
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
          horizontalSpaceMedium,
          horizontalSpaceSmall,
          GestureDetector(
            onTap: viewModel.goToFollowingList,
            child: Column(
              children: [
                Text(
                  userDetails!.following!.length.toString(),
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
      ),
    );
  }
}
