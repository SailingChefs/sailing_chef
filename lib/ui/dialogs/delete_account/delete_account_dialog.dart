import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'delete_account_dialog_model.dart';

const double _graphicSize = 60;

class DeleteAccountDialog extends StackedView<DeleteAccountDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeleteAccountDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DeleteAccountDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      alignment: Alignment.bottomRight,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Are you Sure you want to delete your account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kcMediumGrey,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('!',
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C908D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            verticalSpaceSmall,
            GestureDetector(
              onTap: viewModel.deleteAccount,
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E5D6D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  DeleteAccountDialogModel viewModelBuilder(BuildContext context) =>
      DeleteAccountDialogModel();
}
