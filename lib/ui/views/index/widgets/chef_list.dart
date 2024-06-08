import 'package:cached_network_image/cached_network_image.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class ChefListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const ChefListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return viewModel.chefList.isEmpty
        ? Center(
            child: Text(
              'No Chef Found',
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
                width: double.infinity,
                child: ListView.builder(
                  itemCount: viewModel.chefList.length > 5
                      ? 5
                      : viewModel.chefList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        viewModel.toChefProfile(viewModel.chefList[index]);
                      },
                      child: Container(
                        width: screenWidth * 0.43,
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
                        margin: EdgeInsets.only(right: 12.w, bottom: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                              child: viewModel.chefList[index].displayPicture ==
                                      ''
                                  ? Image.asset(
                                      'assets/images/misc/blank_image.png',
                                      fit: BoxFit.cover,
                                      height: screenHeight * 0.2,
                                      width: double.infinity,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: viewModel
                                          .chefList[index].displayPicture!,
                                      height: screenHeight * 0.2,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
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
                                overflow: TextOverflow.ellipsis,
                                capitalizeEachWord(
                                    viewModel.chefList[index].displayName!),
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
              verticalSpaceTiny,
            ],
          );
  }
}
