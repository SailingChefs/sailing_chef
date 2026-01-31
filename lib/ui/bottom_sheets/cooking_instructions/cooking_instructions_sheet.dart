import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/widgets/bottom_cookinginstructions.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/widgets/cooking_topbar.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/widgets/listview_cookinginstructions.dart';

class CookingInstructionsSheet
    extends StackedView<CookingInstructionsSheetModel> {
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

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: const BoxDecoration(
            color: kcwhitecolor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CookingTopBar(listIndex, method != null),
              Center(
                child: Text(
                  '${method == null ? 'Add' : 'Edit'} Instructions',
                  style: globalTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor),
                ),
              ),
              verticalSpaceMedium,
              ListViewCookingInstructions(
                listIndex: listIndex ?? 0,
              ),
              BottomCookingInstructions(method, listIndex),
            ],
          ),
        ),
      ),
    );
  }

  @override
  CookingInstructionsSheetModel viewModelBuilder(BuildContext context) =>
      CookingInstructionsSheetModel(completer: completer);
}

class CookingInstructionsSheetResponse {
  final List<String> instructionsListResponse;
  final String? method;

  const CookingInstructionsSheetResponse(
      {required this.instructionsListResponse, this.method});
}
