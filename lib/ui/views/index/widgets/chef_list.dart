import 'package:cached_network_image/cached_network_image.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_textbtn.dart';

class ChefListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const ChefListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return viewModel.chefList.isEmpty
        ? Text(
            'No Chef Found',
            style: Theme.of(context).textTheme.titleMedium,
          )
        : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Meet your Chef',
                    style: globalTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor,
                    ),
                  ),
                  CustomTextButton(
                    onPressed: viewModel.toAllChefsView,
                    buttonText: 'View all',
                    textColor: kclightgreencolor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              verticalSpaceSmall,
              SizedBox(
                height: screenHeight <= 690.0

                    ? MediaQuery.sizeOf(context).height * 0.3.h
                    : MediaQuery.sizeOf(context).height * 0.27.h,

                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: viewModel.chefList.length >= 5
                      ? 5
                      : viewModel.chefList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final chef = viewModel.chefList[index];
                    return GestureDetector(
                      onTap: () {
                        viewModel.toChefProfile(chef);
                      },
                      child: Container(
                        width: 160.w,
                        // height: 230.h,
                        decoration: BoxDecoration(
                          color: kcwhitecolor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                              child: chef.displayPicture == ''
                                  ? Image.asset(
                                      'assets/images/misc/blank_image.png',
                                      fit: BoxFit.cover,

                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.25.h -
                                              50.h,

                                    )
                                  : CachedNetworkImage(
                                      imageUrl: chef.displayPicture!,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.25.h -
                                              50.h,
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
                              padding: EdgeInsets.all(8.0.dg),
                              child: Text(
                                capitalizeEachWord(chef.displayName!),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
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