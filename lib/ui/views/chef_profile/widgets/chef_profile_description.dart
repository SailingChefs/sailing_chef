import 'package:cached_network_image/cached_network_image.dart';
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
          GestureDetector(
            onTap: () {
              viewModel.profileShare(
                  context,
                  user.displayPicture!.isEmpty
                      ? 'assets/images/misc/blank_image.png'
                      : user.displayPicture!,
                  user.displayPicture!.isEmpty ? 'asset' : 'network');
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
                child: user.displayPicture == null ||
                        user.displayPicture!.isEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage(
                                'assets/images/misc/blank_image.png')),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: user.displayPicture!,
                          height:
                              MediaQuery.sizeOf(context).height * 0.25.h - 56.h,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Container(
                            decoration: const BoxDecoration(
                              color: kcsgreycolor,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          horizontalSpaceSmall,
          if (user.userRole == 'culinarySchool')
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.recipes != null ? user.recipes!.length.toString() : '',
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
            onTap: viewModel.goToFollowerList,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  viewModel.dummyFollowers.toString(),
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
              children: [
                Text(
                  // user.following!.length.toString(),
                  viewModel.dummyFollowing.toString(),
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
