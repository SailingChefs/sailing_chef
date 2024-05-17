import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';

import '../../../../core/helpers/capitalize_first_fucntion.dart';

class ChefProfileDetailsDesc extends ViewModelWidget<ChefProfileViewModel> {
  const ChefProfileDetailsDesc({required this.user, super.key});
  final UserModel user;
  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: user.displayPicture!.isEmpty
                        ? Image.asset(
                            'assets/images/misc/blank_image.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            user.displayPicture!,
                            fit: BoxFit.cover,
                          )),
              ),
              horizontalSpaceSmall,
              verticalSpaceTiny,
              GestureDetector(
                onTap: viewModel.showRecipeList,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.recipes!.length.toString(),
                      style: globalTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: kcBlackColor.withOpacity(0.6)),
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Dishes',
                      style: globalTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: kcBlackColor.withOpacity(0.6)),
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
                          fontWeight: FontWeight.w600,
                          color: kcBlackColor.withOpacity(0.6)),
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Followers',
                      style: globalTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: kcBlackColor.withOpacity(0.6)),
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
                          fontWeight: FontWeight.w600,
                          color: kcBlackColor.withOpacity(0.6)),
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Following',
                      style: globalTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: kcBlackColor.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
              // ChefProfileDetails(
              //   user: user,
              // ),
            ],
          ),
          user.displayName!.isEmpty
              ? const SizedBox()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  verticalSpaceSmall,
                  Text(
                    capitalizeEachWord(user.displayName!),
                    style: globalTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: kcBlackColor),
                  ),
                ]),
          user.namedLocation == null && user.boatName == null
              ? Container()
              : Text(
                  user.namedLocation == null
                      ? capitalizeEachWord(userDetails!.boatName!)
                      : user.boatName!.isEmpty
                          ? capitalizeEachWord(user.namedLocation!)
                          : capitalizeEachWord(
                              '${user.boatName!}, ${user.namedLocation}'),
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor,
                  ),
                ),
          user.bio!.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    verticalSpaceSmall,
                    Text(
                      user.bio!,
                      style: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kcBlackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
          verticalSpaceTiny,
          user.link!.isEmpty
              ? const SizedBox()
              : Row(
                  children: [
                    const Icon(
                      Icons.link_outlined,
                      color: kcPrimaryColor,
                      size: 20,
                    ),
                    horizontalSpaceSmall,
                    GestureDetector(
                      onTap: () {
                        viewModel.onClickUrl(user.link!);
                      },
                      child: Text(
                        user.link!.isEmpty ? ' ' : user.link!,
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kcPrimaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
