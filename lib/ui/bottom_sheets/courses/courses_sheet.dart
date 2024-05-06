import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/widgets/buttons.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/widgets/link_field.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'courses_sheet_model.dart';

class CoursesSheet extends StackedView<CoursesSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CoursesSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CoursesSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: const BoxDecoration(
        color: kcwhitecolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              TextField(
                controller: viewModel.name,
                style: globalTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kcBlackColor.withOpacity(0.6),
                ),
                decoration: InputDecoration(
                  hintText: 'Course Name',
                  border: InputBorder.none,
                  hintStyle: globalTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
              Divider(
                color: kcBlackColor.withOpacity(0.08),
              ),
              TextFieldLink(
                hinttext: 'Add link',
                suffixIcon: FlutterRemix.link_m,
                color: kclightgreencolor.withOpacity(0.8),
                controller: viewModel.link,
              ),
              Divider(
                color: kcBlackColor.withOpacity(0.08),
              ),
              TextField(
                controller: viewModel.desc,
                decoration: InputDecoration(
                  hintText: 'Basic description',
                  counterText: '',
                  border: InputBorder.none,
                  hintStyle: globalTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: kcBlackColor.withOpacity(0.4),
                  ),
                ),
              ),
              verticalSpaceMedium,
              Divider(
                color: kcBlackColor.withOpacity(0.08),
              ),
              TextField(
                controller: viewModel.numOfDays,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Number of Days',
                    hintStyle: globalTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.4),
                    ),
                    border: InputBorder.none),
              ),
              Divider(
                color: kcBlackColor.withOpacity(0.08),
              ),
              verticalSpaceLarge,
              const CoursesButtons(),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }

  @override
  CoursesSheetModel viewModelBuilder(BuildContext context) =>
      CoursesSheetModel();
}
