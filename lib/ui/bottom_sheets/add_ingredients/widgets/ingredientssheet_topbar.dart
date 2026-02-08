import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class IngredientsSheetTopBar extends ViewModelWidget<AddIngredientsSheetModel> {
  const IngredientsSheetTopBar({super.key});

  @override
  Widget build(BuildContext context, AddIngredientsSheetModel viewModel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(13.0.dg, 20.0.dg, 13.0.dg, 13.0.dg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: BackArrowWidget(
              onTap: viewModel.popBack,
            ),
          ),
          const Center(
            child: Text(
              'Add your ingredients',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: viewModel.ingredientsList.isEmpty ? null : viewModel.onSaved,
              child: Text(
                'Save',
                style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: viewModel.ingredientsList.isEmpty
                        ? Colors.grey.shade300
                        : const Color(0xFF6C908D)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
