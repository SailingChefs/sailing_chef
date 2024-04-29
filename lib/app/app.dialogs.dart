// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/block_account/block_account_dialog.dart';
import '../ui/dialogs/delete_account/delete_account_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/dialogs/pindrop_dialoguebox/pindrop_dialoguebox_dialog.dart';
import '../ui/dialogs/save_draft_alertbox/save_draft_alertbox_dialog.dart';

enum DialogType {
  infoAlert,
  saveDraftAlertbox,
  pindropDialoguebox,
  deleteAccount,
  blockAccount,
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
  };

  dialogService.registerCustomDialogBuilders(builders);
}
