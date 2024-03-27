// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';
import '../ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';

enum BottomSheetType {
  notice,
  addIngredients,
  cookingInstructions,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.addIngredients: (context, request, completer) =>
        AddIngredientsSheet(request: request, completer: completer),
    BottomSheetType.cookingInstructions: (context, request, completer) =>
        CookingInstructionsSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
