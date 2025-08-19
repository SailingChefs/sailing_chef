import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class PrepTime extends ViewModelWidget<AddRecipeViewModel> {
  const PrepTime(this.drafts, {super.key});
  final RecipeModel? drafts;
  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Cooking Time',
                  style: globalTextStyle(
                    fontSize: 14.sp,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor,
                  ),
                ),
                horizontalSpaceTiny,
                Text('*',
                    style: globalTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: kcErrorColor)),
              ],
            ),
            GestureDetector(
              onTap: () => viewModel.showCustomTimePickerDialog(context),
              child: Container(
                // height: 45.h,
                // width: 115.w,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0.r),
                  color: kcVeryLightGrey.withOpacity(0.2),
                ),
                child: viewModel.selectedTime != null &&
                        viewModel.formattedDuration != '0h'
                    ? Center(
                        child: Text(
                          viewModel.formatDuration(),
                          style: globalTextStyle(
                            fontSize: 12.sp,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w600,
                            color: kcPrimaryColorDark,
                          ),
                        ),
                      )
                    : FittedBox(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/misc/clock.svg',
                              height: 13.0.dg,
                              width: 13.0.dg,
                            ),
                            horizontalSpaceSmall,
                            Text(
                              viewModel.prepreationTime != null
                                  ? viewModel.prepreationTime!
                                  : 'Set Time',
                              style: globalTextStyle(
                                fontSize: 12.sp,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w600,
                                color: kcPrimaryColorDark,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),

        // Text(
        //   'How long does it take to cook this recipe?',
        //   style: globalTextStyle(
        //       fontSize: 14.sp,
        //       fontWeight: FontWeight.w500,
        //       color: kcBlackColor.withOpacity(0.5)),
        // ),
        // verticalSpaceSmall,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     SizedBox(
        //       width: MediaQuery.sizeOf(context).width * 0.5,
        //       child: RoundedTransparentTextField(
        //         keyboardType: TextInputType.number,
        //         controller: viewModel.prepTimeController,
        //         labelText: 'Prep Time',
        //         validator: viewModel.validatePrepTime,
        //         textColor: kcBlackColor.withOpacity(0.5),
        //       ),
        //     ),
        //     // Container(
        //     //   height: 45.h,
        //     //   width: MediaQuery.sizeOf(context).width * 0.35,
        //     //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        //     //   decoration: BoxDecoration(
        //     //     borderRadius: BorderRadius.circular(30.0),
        //     //     color: kcVeryLightGrey.withOpacity(0.2),
        //     //   ),
        //     //   child: Row(
        //     //     children: [
        //     //       Icon(Icons.timelapse_outlined,
        //     //           color: kcBlackColor.withOpacity(0.5), size: 20.0),
        //     //       horizontalSpaceMedium,
        //     //       Expanded(
        //     //         flex: 2,
        //     //         child: DropdownButton<String>(
        //     //           isExpanded: true,
        //     //           dropdownColor: kcWhiteColor,
        //     //           underline: const SizedBox(),
        //     //           icon: Icon(FlutterRemix.arrow_down_s_line,
        //     //               color: kcBlackColor.withOpacity(0.5), size: 30.0),
        //     //           value: viewModel.selectedTimeMethod,
        //     //           onChanged: (String? newValue) {
        //     //             viewModel.onTimeMethodSelection(newValue!);
        //     //           },
        //     //           items: viewModel.timeMethod.map((index) {
        //     //             return DropdownMenuItem<String>(
        //     //               value: index.toString(),
        //     //               child: Text(
        //     //                 index,
        //     //                 style: const TextStyle(fontSize: 14),
        //     //               ),
        //     //             );
        //     //           }).toList(),
        //     //         ),
        //     //       ),
        //     //     ],
        //     //   ),
        //     // ),
        //   ],
        // )
      ],
    );
  }
}
