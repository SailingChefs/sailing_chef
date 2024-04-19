import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet_model.dart';
import '../../../widgets/back_arrow.dart';

class IngredientsSheetTopBar extends ViewModelWidget<AddIngredientsSheetModel> {
  const IngredientsSheetTopBar({super.key});

  @override
  Widget build(BuildContext context, AddIngredientsSheetModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(13.0.dg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackArrowWidget(
            onTap: viewModel.popBack,
          ),
          GestureDetector(
            onTap: viewModel.onSaved,
            child: Text(
              'Save',
              style: globalTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kcPrimaryColor.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}
