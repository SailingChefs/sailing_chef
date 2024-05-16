import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/shimmer_container.dart';

class ShimmerLoaderChefView extends StatelessWidget {
  const ShimmerLoaderChefView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // const TopBarProfileScreen(),
          // verticalSpaceMedium,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       height: 90.h,
          //       width: 90.w,
          //       decoration: const BoxDecoration(
          //         color: kcVeryLightGrey,
          //         shape: BoxShape.circle,
          //       ),
          //       child: ClipRRect(
          //           borderRadius: const BorderRadius.all(Radius.circular(50)),
          //           child: Image.asset(
          //             'assets/images/misc/blank_image.png',
          //             fit: BoxFit.cover,
          //           )),
          //     ),
          //     horizontalSpaceSmall,
          //     verticalSpaceTiny,
          //     Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           '0',
          //           style: globalTextStyle(
          //               fontSize: 18.sp,
          //               fontWeight: FontWeight.w600,
          //               color: kcBlackColor.withOpacity(0.6)),
          //         ),
          //         verticalSpaceTiny,
          //         Text(
          //           'Dishes',
          //           style: globalTextStyle(
          //               fontSize: 14.sp,
          //               fontWeight: FontWeight.w400,
          //               color: kcBlackColor.withOpacity(0.6)),
          //         ),
          //       ],
          //     ),
          //     horizontalSpaceSmall,
          //     Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           '0',
          //           style: globalTextStyle(
          //               fontSize: 18.sp,
          //               fontWeight: FontWeight.w600,
          //               color: kcBlackColor.withOpacity(0.6)),
          //         ),
          //         verticalSpaceTiny,
          //         Text(
          //           'Followers',
          //           style: globalTextStyle(
          //               fontSize: 14.sp,
          //               fontWeight: FontWeight.w400,
          //               color: kcBlackColor.withOpacity(0.6)),
          //         ),
          //       ],
          //     ),
          //     horizontalSpaceSmall,
          //     Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           '0',
          //           style: globalTextStyle(
          //               fontSize: 18.sp,
          //               fontWeight: FontWeight.w600,
          //               color: kcBlackColor.withOpacity(0.6)),
          //         ),
          //         verticalSpaceTiny,
          //         Text(
          //           'Following',
          //           style: globalTextStyle(
          //               fontSize: 14.sp,
          //               fontWeight: FontWeight.w400,
          //               color: kcBlackColor.withOpacity(0.6)),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // verticalSpaceTiny,
          // ShimmerContainer(
          //   height: 15.h,
          //   width: 100.w,
          // ),
          // ShimmerContainer(
          //   height: 20.h,
          //   width: 150.w,
          // ),
          // ShimmerContainer(
          //   height: 20.h,
          //   width: 180.w,
          // ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) =>
                ShimmerContainer(height: 20.h, width: 20.w),
            itemCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          )
        ]),
      ),
    );
  }
}
