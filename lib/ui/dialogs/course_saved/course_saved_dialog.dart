import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'course_saved_dialog_model.dart';

class CourseSavedDialog extends StackedView<CourseSavedDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const CourseSavedDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CourseSavedDialogModel viewModel,
    Widget? child,
  ) {
    Future.delayed(const Duration(seconds: 2), () {
      completer(DialogResponse(confirmed: true));
      log(viewModel.navigationService.courses.length.toString());
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 110),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Congratulations on your course!',
              style: globalTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: kcBlackColor,
              ),
            ),
            verticalSpaceSmall,
            Text(
              textAlign: TextAlign.center,
              'Your course is successfully submitted for review',
              style: globalTextStyle(
                fontSize: 17,
                color: kcPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CourseSavedDialogModel viewModelBuilder(BuildContext context) =>
      CourseSavedDialogModel();
}
