import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/add_ingredient_textfield.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredientssheet_topbar.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/listview_quantity_name.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/two_textfields_inarow.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';

class AddIngredientsSheet extends StackedView<AddIngredientsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const AddIngredientsSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    AddIngredientsSheetModel viewModel,
    Widget? child,
  ) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardInset = mediaQuery.viewInsets.bottom;
    final baseHeight = mediaQuery.size.height * 0.95;
    final sheetHeight = (baseHeight - keyboardInset).clamp(0.0, baseHeight);

    return SizedBox(
      height: sheetHeight,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kcwhitecolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed top bar that never scrolls
            const IngredientsSheetTopBar(),
            // Scrollable content in the middle
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: const ListViewQuantityName(),
              ),
            ),
            // Fixed bottom section that never scrolls
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AddIngredientTextField(
                      hintText: 'Add ingredients',
                      prefix: Icons.drag_indicator,
                    ),
                  ),
                  const AddIngredientsTwoTextFields(),
                  Center(
                    child: SaveRecipeButton(
                      onPressed: viewModel.addIngredientToList,
                      buttonText: 'Add Ingredient',
                      prefix: Icons.add,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddIngredientsSheetModel viewModelBuilder(BuildContext context) =>
      AddIngredientsSheetModel(completer);
}

class AddIngredientsSheetResponse {
  final List<Ingredient> ingredientsList;

  const AddIngredientsSheetResponse({required this.ingredientsList});
}
