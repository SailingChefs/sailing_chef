import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet_model.dart';

class ListViewQuantityName extends ViewModelWidget<AddIngredientsSheetModel> {
  const ListViewQuantityName({super.key});

  @override
  Widget build(BuildContext context, AddIngredientsSheetModel viewModel) {
    return Flexible(
      child: SizedBox(
        width: 390.w,
        child: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: viewModel.ingredientsList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final ingredient = viewModel.ingredientsList[index];
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: kcVeryLightGrey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              capitalizeEachWord(ingredient.name),
                              overflow: TextOverflow.ellipsis,
                              style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kcBlackColor.withOpacity(0.5)),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Text(
                              '${ingredient.quantity} - ${ingredient.unit}',
                              overflow: TextOverflow.ellipsis,
                              style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kcBlackColor.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      viewModel.ingredientsList.removeAt(index);
                      viewModel.notifyListeners();
                    },
                    icon: const Icon(
                      Icons.delete_outline_sharp,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
