import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';

class ListViewSavedCources extends ViewModelWidget<ProfileViewModel> {
  final List<Course> courses;
  const ListViewSavedCources({super.key, required this.courses});
  List<Widget> createCourseWidgets(ProfileViewModel viewModel) {
    return [
      for (var course in viewModel.courses)
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: kcbackgroundCourses,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        course.name,
                        overflow: TextOverflow.ellipsis,
                        style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor),
                      ),
                    ),
                    verticalSpaceSmall,
                    Text(
                      '${course.numOfDays} days',
                      style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: kcBlackColor),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.callCourseNameBottomSheett(course);
                  },
                  child: Container(
                    height: 40,
                    width: 74,
                    decoration: BoxDecoration(
                      color: kcchatboxecolor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      'Edit',
                      style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kcwhitecolor),
                    )),
                  ),
                )
              ],
            ),
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      children: [
        ...createCourseWidgets(viewModel),
        // : SizedBox(
        //     height: screenHeight(context) * 0.319,
        //     width: screenWidth(context) * 0.98,
        //     child: ListView.builder(
        //       itemCount: viewModel.courses.length,
        //       itemBuilder: (context, index) {
        //         Course course = viewModel.courses[index];
    
        //       },
        //     ),
        //   ),
        viewModel.courses.isNotEmpty
            ? Column(
                children: [
                  verticalSpaceMedium,
                  GestureDetector(
                    onTap: () {
                      viewModel.callCourseNameBottomSheet();
                    },
                    child: Container(
                      width: 165,
                      height: 55,
                      decoration: BoxDecoration(
                        color: kcPrimaryColor,
                        borderRadius: BorderRadius.circular(38),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_circle,
                            color: kcwhitecolor,
                            size: 26,
                          ),
                          horizontalSpaceTiny,
                          Text(
                            'Add courses',
                            style: globalTextStyle(
                                fontSize: 14, color: kcwhitecolor),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: screenHeight(context) * 0.31,
                width: screenWidth(context) * 0.98,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Allow chefs to book your courses',
                      style: globalTextStyle(
                          fontSize: 14.0.dg,
                          color: filterIconColor,
                          fontWeight: FontWeight.w600),
                    ),
                    verticalSpaceMedium,
                    GestureDetector(
                      onTap: viewModel.callCourseNameBottomSheet,
                      child: Container(
                        width: 165,
                        height: 55,
                        decoration: BoxDecoration(
                          color: kcPrimaryColor,
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_circle,
                              color: kcwhitecolor,
                              size: 26,
                            ),
                            horizontalSpaceTiny,
                            Text(
                              'Add courses',
                              style: globalTextStyle(
                                  fontSize: 14, color: kcwhitecolor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
