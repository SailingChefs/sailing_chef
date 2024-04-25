import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/chef_profile_details.dart';

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
              ChefProfileDetails(
                user: user,
              ),
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
          user.boatName!.isEmpty && viewModel.placemarks == null
              ? const SizedBox()
              : Column(
                  children: [
                    verticalSpaceSmall,
                    Text(
                      "${capitalizeEachWord(user.boatName!)}, ${viewModel.placemarks!.first.country!}",
                      style: globalTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kcBlackColor,
                      ),
                    ),
                  ],
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
                    Text(
                      user.link!,
                      style: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kcPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
