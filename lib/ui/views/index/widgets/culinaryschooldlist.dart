import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_textbtn.dart';

class CullinaryListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const CullinaryListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return viewModel.cullinary.isEmpty
        ? Text(
            'No Cullinary School Found',
            style: Theme.of(context).textTheme.titleMedium,
          )
        : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Culinary schools',
                    style: globalTextStyle(
                      fontSize: 16.sp,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor,
                    ),
                  ),
                  CustomTextButton(
                    onPressed: viewModel.toViewCullinarySchools,
                    buttonText: 'View all',
                    textColor: kclightgreencolor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight <= 690.0
                    ? MediaQuery.sizeOf(context).height * 0.3.h
                    : MediaQuery.sizeOf(context).height * 0.25.h,
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: viewModel.cullinary.length > 5
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
                        width: 160.w,
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
                              child: cullinaruschools.displayPicture == ''
                                  ? Image.asset(
                                      'assets/images/misc/blank_image.png',
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.25.h -
                                              56.h,
                                    )
                                  : Image.network(
                                      cullinaruschools.displayPicture!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.25.h -
                                              56.h,
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.dg),
                              child: Text(
                                capitalizeEachWord(
                                    cullinaruschools.displayName!),
                                style: globalTextStyle(
                                  fontSize: 14.sp,
                                  letterSpacing: -0.5,
                                  color: kcBlackColor,
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
