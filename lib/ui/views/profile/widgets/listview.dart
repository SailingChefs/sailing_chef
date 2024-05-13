import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ListViewSavedCources extends ViewModelWidget<ProfileViewModel> {
  const ListViewSavedCources({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    screenHeight(context);
    return Column(
      children: [
        SizedBox(
          height: screenHeight(context) * 0.319,
          child: ListView.builder(
            itemCount: viewModel.courses.length,
            itemBuilder: (context, index) {
              Course course = viewModel.courses[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: kcsgreycolor,
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 390,
                    height: 85,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.name,
                                style: globalTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kcBlackColor),
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
                              viewModel.isEdit = true;
                              if (viewModel.isEdit == true) {
                                viewModel.callCourseNameBottomSheett(
                                    viewModel.courses[index]);
                              }
                              viewModel.isEdit = false;
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
                  ),
                ),
              );
            },
          ),
        ),
        verticalSpaceSmall,
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
                  style: globalTextStyle(fontSize: 14, color: kcwhitecolor),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
