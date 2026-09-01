import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/widgets/bottom_cookinginstructions.dart';

import 'cooking_instructions_sheet_model.dart';
import 'widgets/cooking_topbar.dart';
import 'widgets/listview_cookinginstructions.dart';

class CookingInstructionsSheet
    extends StackedView<CookingInstructionsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CookingInstructionsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CookingInstructionsSheetModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: const BoxDecoration(
            color: kcWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CookingTopBar(),
              Center(
                child: Text(
                  request.title ?? 'Cooking Instructions',
                  style: globalTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor),
                ),
              ),
              verticalSpaceMedium,
              const ListViewCookingInstructions(),
              const BottomCookingInstructions(),
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
  CookingInstructionsSheetResponse({required this.instructionsListResponse});
}
