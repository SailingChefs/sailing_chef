import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/profile_share/profile_share_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileShareView extends StackedView<ProfileShareViewModel> {
  final String image;
  final String type;
  const ProfileShareView({required this.image, required this.type, super.key});

  @override
  Widget builder(
    BuildContext context,
    ProfileShareViewModel viewModel,
    Widget? child,
  ) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Get.back<void>(),
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'profileShareOption',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: size.width * 0.7,
                    width: size.width * 0.7,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: type.startsWith('a')
                          ? Image.asset(
                              image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Image(
                              image: ImageUtils.safeNetworkImageForAvatar(image),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                    ),
                  ),
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
          ),
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
