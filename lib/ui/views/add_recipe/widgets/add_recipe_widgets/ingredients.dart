import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class Ingredients extends ViewModelWidget<AddRecipeViewModel> {
  const Ingredients({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Ingredients',
              style: globalTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor),
            ),
            horizontalSpaceTiny,
            Text(
              '*',
              style: globalTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: kcErrorColor),
            ),
          ],
        ),
        verticalSpaceTiny,
        viewModel.ingredientsList.isNotEmpty
            ? SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.ingredientsList.length,
                  itemBuilder: (context, index) {
                    final ingredient = viewModel.ingredientsList[index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              decoration: BoxDecoration(
                                color: kcVeryLightGrey.withOpacity(0.2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        ingredient.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                            color: kcBlackColor),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Text(
                                        '${ingredient.quantity} ${ingredient.unit}',
                                        overflow: TextOverflow.ellipsis,
                                        style: globalTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                kcBlackColor.withOpacity(0.5)),
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
                        verticalSpaceSmall,
                      ],
                    );
                  },
                ),
              )
            : GestureDetector(
                onTap: viewModel.callIngredientsBottomSheet,
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: kcVeryLightGrey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: kcBlackColor.withOpacity(0.5),
                          )),
                      horizontalSpaceSmall,
                      Text(
                        'Add Ingredient',
                        style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
