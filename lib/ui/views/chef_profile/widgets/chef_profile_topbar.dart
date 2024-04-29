import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';

class ChefProfileTopBar extends ViewModelWidget<ChefProfileViewModel> {
  final bool? isCurrentUser;
  final String uid;

  const ChefProfileTopBar({super.key, this.isCurrentUser, required this.uid});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: 
            viewModel.moveBack,
          
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8.0.dg),
            height: 36.h,
            width: 36.w,
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
        GestureDetector(
          onTap: () {
            viewModel.showBottomSheet();
            // viewModel.toSettings(
            //   isCurrentUser!,
            //   uid,
            // );
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
            child: Icon(
              FlutterRemix.more_fill,
              color: kcBlackColor,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
