import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'addpindropshow_dialog_model.dart';

const double _graphicSize = 60;

class AddpindropshowDialog extends StackedView<AddpindropshowDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AddpindropshowDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddpindropshowDialogModel viewModel,
    Widget? child,
  ) {
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      insetPadding: const EdgeInsets.only(
        left: 100,
        right: 90,
        bottom: 250,
      ),
      
      backgroundColor: Colors.white,
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      child: Padding(
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: 40,
          height: 35,
          child: Center(
            child: Text(
              'Add your pin drop here',
              style: globalTextStyle(
                color: kcBlackColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  

  @override
  AddpindropshowDialogModel viewModelBuilder(BuildContext context) =>
      AddpindropshowDialogModel();
      
}
