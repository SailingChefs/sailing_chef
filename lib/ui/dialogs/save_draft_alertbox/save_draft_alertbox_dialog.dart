// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/dialogs/save_draft_alertbox/save_draft_alertbox_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SaveDraftAlertboxDialog extends StackedView<SaveDraftAlertboxDialogModel> {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const SaveDraftAlertboxDialog({
    super.key,
    this.request,
    this.completer,
  });

  @override
  Widget builder(
    BuildContext context,
    SaveDraftAlertboxDialogModel viewModel,
    Widget? child,
  ) {
    final recipe = request!.data['model'] as RecipeModel;
    final images = request!.data['images'] as List<XFile?>;
    final path = request!.data['path'] as String;
    final isDraft = request!.data['isDraft'] as bool;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: kcWhiteColor,
      child: SizedBox(
        width: 338,
        height: 125,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                completer!(DialogResponse(confirmed: true));
                                viewModel.yesButton(recipe, images, path);
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
                                completer!(DialogResponse(confirmed: true));
                                viewModel.noButton(recipe, images, path, isDraft);
                              },
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SaveDraftAlertboxDialogModel viewModelBuilder(BuildContext context) =>
      SaveDraftAlertboxDialogModel();
}
