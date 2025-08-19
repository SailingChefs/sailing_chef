import 'package:cached_network_image/cached_network_image.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/culineryschoolviewall_viewmodel.dart';

class ListViewCulinaryChool
    extends ViewModelWidget<CulineryschoolviewallViewModel> {
  const ListViewCulinaryChool({super.key});

  @override
  Widget build(BuildContext context, CulineryschoolviewallViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceMedium,
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: viewModel.cullinary.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () =>
                    viewModel.toUserDetails(viewModel.cullinary[index]),
                child: Container(
                  height: 123.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  // padding: EdgeInsets.(10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kcPrimaryColor.withOpacity(0.07),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.04),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    // boxShadow: [
                    //   BoxShadow(
                    //     // color: kcBlackColor.withOpacity(0.09),
                    //     spreadRadius: 1,
                    //     blurRadius: 1,
                    //     offset: const Offset(0, 4),
                    //   ),
                    // ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 123.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: viewModel
                                  .cullinary[index].displayPicture!.isEmpty
                              ? const Icon(Icons.school)
                              : CachedNetworkImage(
                                  imageUrl: viewModel
                                      .cullinary[index].displayPicture!,
                                  height: MediaQuery.sizeOf(context).height *
                                          0.25.h -
                                      56.h,
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Container(
                                    decoration: const BoxDecoration(
                                      color: kcsgreycolor,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.cullinary[index].displayName!,
                                style: globalTextStyle(
                                  fontSize: 16.sp,
                                  letterSpacing: -0.3,
                                  fontWeight: FontWeight.w700,
                                  color: kcBlackColor,
                                ),
                              ),
                              if (viewModel.cullinary[index].namedLocation != null) Column(
                                      children: [
                                        verticalSpace(5),
                                        SizedBox(
                                          width: 170.w,
                                          child: Text(
                                            viewModel.cullinary[index]
                                                .namedLocation!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: globalTextStyle(
                                              letterSpacing: -0.3,
                                              fontSize: viewModel
                                                          .cullinary[index]
                                                          .namedLocation!
                                                          .length >
                                                      20
                                                  ? 12.sp
                                                  : 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: kcBlackColor,
                                            ),
                                          ),
                                        ),
                                        verticalSpace(5),
                                      ],
                                    ) else const SizedBox(),
                              Text(
                                '${viewModel.cullinary[index].schoolCourses!.length} Courses',
                                style: globalTextStyle(
                                  fontSize: 14.sp,
                                  letterSpacing: -0.3,
                                  fontWeight: FontWeight.w300,
                                  color: kcBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
