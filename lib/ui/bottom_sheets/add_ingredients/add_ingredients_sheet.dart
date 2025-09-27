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
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        decoration: const BoxDecoration(
          color: kcwhitecolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const IngredientsSheetTopBar(),
            Center(
              child: Text(
                request.title ?? 'Add your ingredients',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            verticalSpaceTiny,
            const ListViewQuantityName(),
            verticalSpaceMedium,
            SizedBox(
              width: double.infinity,
              child: AddIngredientTextField(
                hintText: 'Add ingredients',
                prefix: Icons.drag_indicator,
              ),
            ),
            verticalSpaceTiny,
            const AddIngredientsTwoTextFields(),
            verticalSpaceTiny,
            Center(
              child: SaveRecipeButton(
                onPressed: viewModel.addIngredientToList,
                buttonText: 'Add Ingredient',
                prefix: Icons.add,
              ),
            ),
            verticalSpaceSmall,
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
