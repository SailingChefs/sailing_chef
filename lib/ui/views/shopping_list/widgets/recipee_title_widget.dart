import '../../../../core/imports/core_imports.dart';
import '../../../../model/recipe_model.dart';
import '../shopping_list_viewmodel.dart';
import 'package:collection/collection.dart';

Widget recipeeTitleWidget(
    {required Size size,
    required RecipeModel recipee,
    required ShoppingListViewModel viewModel}) {
  const equality = DeepCollectionEquality();
  return SizedBox(
    width: size.width,
    height: size.height * 0.08,
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.none,
              alignment: Alignment.centerLeft,
              child: Text(
                recipee.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 32.h,
            width: size.width * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                color: Colors.grey.shade300),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (equality.equals(
                            viewModel.shoppingListService
                                        .showShoppingListview[recipee.title]
                                    ?['selected_ingredients'] ??
                                [],
                            recipee.ingredients))
                        ? 'deselect all'
                        : "select all",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  8.w.horizontalSpace,
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 7.r,
                      backgroundColor: (equality.equals(
                              viewModel.shoppingListService
                                          .showShoppingListview[recipee.title]
                                      ?['selected_ingredients'] ??
                                  [],
                              recipee.ingredients))
                          ? kcPrimaryColorDark
                          : Colors.black,
                      child: Center(
                        child: CircleAvatar(
                          radius: 6.r,
                          backgroundColor: (equality.equals(
                                  viewModel.shoppingListService
                                                  .showShoppingListview[
                                              recipee.title]
                                          ?['selected_ingredients'] ??
                                      [],
                                  recipee.ingredients))
                              ? kcPrimaryColorDark
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
