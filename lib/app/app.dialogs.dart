// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/block_account/block_account_dialog.dart';
import '../ui/dialogs/course_saved/course_saved_dialog.dart';
import '../ui/dialogs/delete_account/delete_account_dialog.dart';
import '../ui/dialogs/deleteconfirmation/deleteconfirmation_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/dialogs/pindetails/pindetails_dialog.dart';
import '../ui/dialogs/pindrop_dialoguebox/pindrop_dialoguebox_dialog.dart';
import '../ui/dialogs/rate_experience/rate_experience_dialog.dart';
import '../ui/dialogs/reviews_all/reviews_all_dialog.dart';
import '../ui/dialogs/save_draft_alertbox/save_draft_alertbox_dialog.dart';

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
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
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
  };

  dialogService.registerCustomDialogBuilders(builders);
}
