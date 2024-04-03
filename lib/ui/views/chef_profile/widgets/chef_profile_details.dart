import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../../../../core/helpers/capitalize_first_fucntion.dart';
import '../chef_profile_viewmodel.dart';

class ChefProfileDetails extends ViewModelWidget<ChefProfileViewModel> {
  const ChefProfileDetails({super.key});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return FittedBox(
      child: Row(
        children: [
          Column(
            children: [
              verticalSpaceLarge,
              Container(
                height: 94.h,
                width: 94.w,
                decoration: const BoxDecoration(
                  color: kcVeryLightGrey,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      'assets/images/icons/chef.jpg',
                      fit: BoxFit.cover,
                      height: 87,
                      width: 87,
                    )),
              ),
              verticalSpaceSmall,
              Text(
                capitalizeEachWord('Danica Nel'),
                style: globalTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: kcBlackColor),
              ),
            ],
          ),
          horizontalSpaceMedium,
          horizontalSpaceSmall,
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '12',
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
            onTap: () {
              viewModel.goTogoToProfileEditView('Hafsa Mehmood');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '05',
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
            onTap: () {
              viewModel.goTogoToProfileEditView('Hafsa Mehmood');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '12',
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
