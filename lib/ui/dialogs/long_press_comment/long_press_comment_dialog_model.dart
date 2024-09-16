import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:stacked/stacked.dart';

class LongPressCommentDialogModel extends BaseViewModel {
  final Function(DialogResponse<bool>) completer;

  LongPressCommentDialogModel({required this.completer});

  void editOrDelete(bool param) {
    completer(DialogResponse(
      data: param,
      confirmed: true,
    ));
  }
}
