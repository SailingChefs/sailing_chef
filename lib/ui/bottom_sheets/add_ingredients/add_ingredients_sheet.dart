import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredientssheet_topbar.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/two_textfields_inarow.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';
import 'package:sailing_chefs/ui/widgets/common_textfield.dart';

import 'add_ingredients_sheet_model.dart';
import 'widgets/listview_quantity_name.dart';

class AddIngredientsSheet extends StackedView<AddIngredientsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const AddIngredientsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            verticalSpaceTiny,
            const ListViewQuantityName(),
            verticalSpaceMedium,
            SizedBox(
              width: double.infinity,
              child: CommonTextField(
                hintText: 'Add one or multiple steps',
                prefix: Icons.drag_indicator,
              ),
            ),
            verticalSpaceTiny,
            const TwoTextFields(),
            verticalSpaceTiny,
            SaveRecipeButton(
              onPressed: viewModel.addIngredientToList,
              buttonText: 'Add Ingredient',
              prefix: Icons.add,
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
