import 'package:cached_network_image/cached_network_image.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class CullinaryListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const CullinaryListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return viewModel.cullinary.isEmpty
        ? Center(
            child: Text(
              'No Cullinary School Found',
              style: globalTextStyle(
                  fontSize: 14.sp, color: kcPrimaryColor, letterSpacing: -0.5),
            ),
          )
        : Column(
            children: <Widget>[
              verticalSpaceSmall,
              SizedBox(
                height: screenHeight <= 680.0
                    ? screenHeight * 0.25
                    : screenHeight * 0.27,
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: viewModel.cullinary.length > 20
                      ? 5
                      : viewModel.cullinary.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final cullinaruschools = viewModel.cullinary[index];
                    return GestureDetector(
                      onTap: () {
                        viewModel.toChefProfile(cullinaruschools);
                      },
                      child: Container(
                        width: screenWidth * 0.43,
                        // height: 230.h,
                        decoration: BoxDecoration(
                          color: kcwhitecolor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(right: 12.dg, bottom: 8.dg),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                              child: cullinaruschools.displayPicture == ''
                                  ? Image.asset(
                                      'assets/images/misc/blank_image.png',
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.25.h -
                                              48.h,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          cullinaruschools.displayPicture!,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.25.h -
                                              48.h,
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0.w, right: 8.0.w, top: 15.0.h),
                              child: Text(
                                capitalizeEachWord(
                                    cullinaruschools.displayName!),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
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
