// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/courses_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/discard/discard_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_buttons/drop_pin_buttons_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/drop_pin_sheet_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/edit_ingredient/edit_ingredient_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/other_chef_profile/other_chef_profile_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/social_icons/social_icons_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

enum BottomSheetType {
  notice,
  addIngredients,
  cookingInstructions,
  dropPinSheet,
  dropPinButtons,
  otherChefProfile,
  courses,
  tags,
  discard,
  socialIcons,
  editIngredient,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final builders = <BottomSheetType, SheetBuilder>{
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.addIngredients: (context, request, completer) =>
        AddIngredientsSheet(request: request, completer: completer),
    BottomSheetType.cookingInstructions: (context, request, completer) =>
        CookingInstructionsSheet(request: request, completer: completer),
    BottomSheetType.dropPinSheet: (context, request, completer) => DropPinSheetSheet(
          request: request,
          completer: completer,
          isNew: true,
        ),
    BottomSheetType.dropPinButtons: (context, request, completer) =>
        DropPinButtonsSheet(request: request, completer: completer),
    BottomSheetType.otherChefProfile: (context, request, completer) =>
        OtherChefProfileSheet(request: request, completer: completer),
    BottomSheetType.courses: (context, request, completer) =>
        CoursesSheet(request: request, completer: completer),
    BottomSheetType.tags: (context, request, completer) =>
        TagsSheet(request: request, completer: completer),
    BottomSheetType.discard: (context, request, completer) =>
        DiscardSheet(request: request, completer: completer),
    BottomSheetType.socialIcons: (context, request, completer) =>
        SocialIconsSheet(request: request, completer: completer),
    BottomSheetType.editIngredient: (context, request, completer) =>
        EditIngredientSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
