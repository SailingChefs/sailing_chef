// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'save_draft_alertbox_dialog_model.dart';

class SaveDraftAlertboxDialog
    extends StackedView<SaveDraftAlertboxDialogModel> {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const SaveDraftAlertboxDialog({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SaveDraftAlertboxDialogModel viewModel,
    Widget? child,
  ) {
    final RecipeModel recipe = request!.data['recipe'] ;
    final images = request!.data['images'] ;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        request!.title ?? 'Do You Want to save it for later?',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      verticalSpaceTiny,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              viewModel.yesButton(
                                 recipe,images
                              );
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
                            child: Text(
                              'No',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (request!.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request!.description!,
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  SaveDraftAlertboxDialogModel viewModelBuilder(BuildContext context) =>
      SaveDraftAlertboxDialogModel();
}
