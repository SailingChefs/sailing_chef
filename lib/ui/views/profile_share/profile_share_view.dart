import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'profile_share_viewmodel.dart';

class ProfileShareView extends StackedView<ProfileShareViewModel> {
  final String image;
  final String type;
  const ProfileShareView({Key? key, required this.image, required this.type})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileShareViewModel viewModel,
    Widget? child,
  ) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Get.back();
        },
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Hero(
              tag: "profileShareOption",
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // (size.height * 0.15).verticalSpace,
                  type.startsWith('a')
                      ? CircleAvatar(
                          radius: size.width * 0.35,
                          backgroundImage: AssetImage(image),
                        )
                      : CircleAvatar(
                          radius: size.width * 0.35,
                          backgroundImage: ImageUtils.safeNetworkImageForAvatar(
                            image,
                          ),
                        ),
                  verticalSpaceMedium,
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(24.r),
                  //   ),
                  //   width: size.width * 0.7,
                  //   padding: EdgeInsets.only(
                  //       top: 16.h, bottom: 16.h, left: 16.w, right: 16.w),
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Share Link",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               color: kcBlackColor,
                  //               fontSize: 16.sp)),
                  //       Divider(
                  //         thickness: 0.1,
                  //         height: 24.h,
                  //         color: kcBlackColor,
                  //       ),
                  //       Text("Copy Link",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               color: kcBlackColor,
                  //               fontSize: 16.sp)),
                  //       Divider(
                  //         thickness: 0.1,
                  //         height: 24.h,
                  //         color: kcBlackColor,
                  //       ),
                  //       Text("QR Code",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               color: kcBlackColor,
                  //               fontSize: 16.sp)),
                  //     ],
                  //   ),
                  // )
                ],
              )),
        ),
      ),
    );
  }

  @override
  ProfileShareViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileShareViewModel();
}
