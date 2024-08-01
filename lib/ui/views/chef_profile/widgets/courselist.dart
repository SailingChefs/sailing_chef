import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ListViewChefSavedCources extends ViewModelWidget<ChefProfileViewModel> {
  const ListViewChefSavedCources(this.user, {super.key});
  final UserModel user;
  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    screenHeight(context);
    return Column(
      children: [
        verticalSpaceMedium,
        SizedBox(
          height: 290,
          child: viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
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
                                    viewModel.enquireNow(user, index);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: kcchatboxecolor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Enquire now',
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
      ],
    );
  }
}
