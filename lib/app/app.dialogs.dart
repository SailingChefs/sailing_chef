// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/ui/dialogs/addpindropshow/addpindropshow_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/block_account/block_account_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/course_saved/course_saved_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/delete_account/delete_account_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/delete_pin/delete_pin_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/deleteconfirmation/deleteconfirmation_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/enter_pass/enter_pass_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/long_press_comment/long_press_comment_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/pindetails/pindetails_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/pindrop_dialoguebox/pindrop_dialoguebox_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/rate_experience/rate_experience_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/reviews_all/reviews_all_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/role_dialog/role_dialog_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/save_draft_alertbox/save_draft_alertbox_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/success/success_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType {
  infoAlert,
  saveDraftAlertbox,
  pindropDialoguebox,
  deleteAccount,
  blockAccount,
  courseSaved,
  deleteconfirmation,
  pindetails,
  rateExperience,
  reviewsAll,
  success,
  addpindropshow,
  enterPass,
  deletePin,
  roleDialog,
  longPressComment,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = <DialogType, DialogBuilder>{
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.saveDraftAlertbox: (context, request, completer) =>
        SaveDraftAlertboxDialog(request: request, completer: completer),
    DialogType.pindropDialoguebox: (context, request, completer) =>
        PindropDialogueboxDialog(request: request, completer: completer),
    DialogType.deleteAccount: (context, request, completer) =>
        DeleteAccountDialog(request: request, completer: completer),
    DialogType.blockAccount: (context, request, completer) =>
        BlockAccountDialog(request: request, completer: completer),
    DialogType.courseSaved: (context, request, completer) =>
        CourseSavedDialog(request: request, completer: completer),
    DialogType.deleteconfirmation: (context, request, completer) =>
        DeleteconfirmationDialog(request: request, completer: completer),
    DialogType.pindetails: (context, request, completer) =>
        PindetailsDialog(request: request, completer: completer),
    DialogType.rateExperience: (context, request, completer) =>
        RateExperienceDialog(request: request, completer: completer),
    DialogType.reviewsAll: (context, request, completer) =>
        ReviewsAllDialog(request: request, completer: completer),
    DialogType.success: (context, request, completer) =>
        SuccessDialog(request: request, completer: completer),
    DialogType.addpindropshow: (context, request, completer) =>
        AddpindropshowDialog(request: request, completer: completer),
    DialogType.enterPass: (context, request, completer) =>
        EnterPassDialog(request: request, completer: completer),
    DialogType.deletePin: (context, request, completer) =>
        DeletePinDialog(request: request, completer: completer),
    DialogType.roleDialog: (context, request, completer) =>
        RoleDialogDialog(request: request, completer: completer),
    DialogType.longPressComment: (context, request, completer) =>
        LongPressCommentDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
