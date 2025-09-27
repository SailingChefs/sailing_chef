import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/edit_ingredient/edit_ingredient_sheet_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/edit_ingredient/widgets/edit_ingredient_textfield.dart';
import 'package:sailing_chefs/ui/bottom_sheets/edit_ingredient/widgets/ingredient_quantity_unit.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';

class EditIngredientSheet extends StackedView<EditIngredientSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const EditIngredientSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    EditIngredientSheetModel viewModel,
    Widget? child,
  ) {
    final ingredient = request.data as Ingredient;

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
              'Edit Ingredient',
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
            margin: const EdgeInsets.only(right: 16, left: 40),
            child: EditIngredientTextField(
              hintText: viewModel.ingredientNameController.text,
            ),
          ),
          verticalSpaceTiny,
          IngredientQuantityUnit(ingredient),
          verticalSpaceTiny,
          Center(
            child: SaveRecipeButton(
              onPressed: () {
                viewModel.onSaved();
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
      EditIngredientSheetModel(request.data as Ingredient, completer);

  @override
  void onViewModelReady(EditIngredientSheetModel viewModel) {
    viewModel.onViewModelReady();
  }
}
