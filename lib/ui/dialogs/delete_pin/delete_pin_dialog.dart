import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/dialogs/delete_pin/delete_pin_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const double _graphicSize = 60;

class DeletePinDialog extends StackedView<DeletePinDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeletePinDialog({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    DeletePinDialogModel viewModel,
    Widget? child,
  ) {
    String? pin;
    if (request.data != null) {
      pin = request.data;
      log('hnhnh $pin');
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
                'Do You Want to delete this pin?',
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
                      viewModel.yesButton(pin!);
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
                    onPressed: () {
                      completer(DialogResponse(confirmed: true));
                    },
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
  DeletePinDialogModel viewModelBuilder(BuildContext context) =>
      DeletePinDialogModel();
}
