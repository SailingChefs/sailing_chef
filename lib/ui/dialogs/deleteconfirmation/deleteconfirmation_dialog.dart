import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/dialogs/deleteconfirmation/deleteconfirmation_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteconfirmationDialog extends StackedView<DeleteconfirmationDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeleteconfirmationDialog({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    DeleteconfirmationDialogModel viewModel,
    Widget? child,
  ) {
    String? course;
    if (request.title != null) {
      log(request.title ?? 'No title provided');
      course = request.title;
    }
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
        backgroundColor: Colors.white,
        child: Container(
          height: 105,
          width: 335,
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Do You Want to save it for later?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      viewModel.yesButton(course!);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: kcDarkColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: viewModel.noButton,
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  DeleteconfirmationDialogModel viewModelBuilder(BuildContext context) =>
      DeleteconfirmationDialogModel();
}
