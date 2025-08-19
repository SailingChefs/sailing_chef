import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/edit_ingredient/edit_ingredient_sheet_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/edit_ingredient/widgets/two_fields.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/text_field_comment.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';

class EditIngredientSheet extends StackedView<EditIngredientSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const EditIngredientSheet({
    required this.completer, required this.request, super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    EditIngredientSheetModel viewModel,
    Widget? child,
  ) {
    final quantityController =
        TextEditingController(text: request.data['ingredient'].quantity);
    // final TextEditingController quantityController;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // const IngredientsSheetTopBar(),
          Center(
            child: Text(
              'Save Ingredient',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
          ),
          verticalSpaceMedium,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              // color: kcLightGrey.withOpacity(0.7),
              border: Border.all(color: kcVeryLightGrey),
            ),
            width: double.infinity,
            child: CommonTextField(
              hintText: request.data['ingredient'].name ?? '',
              prefix: Icons.drag_indicator,
            ),
          ),
          verticalSpaceTiny,
          TwoFields(quantityController, request.data['ingredient']),
          verticalSpaceTiny,
          Center(
            child: SaveRecipeButton(
              onPressed: () {
                viewModel.showUpdatedIngredient();
              },
              buttonText: 'Save Ingredient',
              prefix: Icons.add,
            ),
          ),
          verticalSpaceSmall,
        ],
      ),
    );
  }

  @override
  EditIngredientSheetModel viewModelBuilder(BuildContext context) =>
      EditIngredientSheetModel(
          request.data['ingredient'], request.data['listIndex']);

  @override
  void onViewModelReady(EditIngredientSheetModel viewModel) {
    viewModel.onViewModelReady();
  }
}
