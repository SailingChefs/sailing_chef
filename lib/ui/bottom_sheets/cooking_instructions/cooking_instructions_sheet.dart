import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/widgets/bottom_cookinginstructions.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/widgets/cooking_topbar.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/widgets/listview_cookinginstructions.dart';

class CookingInstructionsSheet extends StackedView<CookingInstructionsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CookingInstructionsSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CookingInstructionsSheetModel viewModel,
    Widget? child,
  ) {
    final data = request.data as Map<String, dynamic>?;

    final listIndex = data?['listIndex'] as int?;
    final method = data?['method'] as String?;

    final mediaQuery = MediaQuery.of(context);
    final keyboardInset = mediaQuery.viewInsets.bottom;
    final baseHeight = mediaQuery.size.height * 0.95;
    final sheetHeight = (baseHeight - keyboardInset).clamp(0.0, baseHeight);

    final isEdit = method != null && listIndex != null;

    return SizedBox(
        height: isEdit ? sheetHeight / 2 : sheetHeight,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: kcwhitecolor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(children: [
            // Fixed top section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CookingTopBar(listIndex, method != null),
                  verticalSpaceMedium,
                ],
              ),
            ),
            if (!isEdit)
              // Scrollable middle section for instructions
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ListViewCookingInstructions(
                      listIndex: listIndex ?? 0,
                    ),
                  ),
                ),
              ),
            // Fixed bottom section that stays above keyboard
            Container(
              padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
              child: BottomCookingInstructions(method, listIndex),
            ),
          ]),
        ));
  }

  @override
  CookingInstructionsSheetModel viewModelBuilder(BuildContext context) =>
      CookingInstructionsSheetModel(completer: completer);
}

class CookingInstructionsSheetResponse {
  final List<String> instructionsListResponse;
  final String? method;

  const CookingInstructionsSheetResponse({required this.instructionsListResponse, this.method});
}
