
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/shopping_list/widgets/topBar.dart';

import 'shopping_list_viewmodel.dart';

class ShoppingListView extends StackedView<ShoppingListViewModel> {
  List<Widget> createShoppingListWidgets(
      ShoppingListViewModel viewModel, context) {
       
    return [
      for (var ingredient in viewModel.shoppingList)
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                ingredient.recipeName,
                style: globalTextStyle(
                  fontSize: 18,
                  color: kcBlackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () => viewModel.addAllItemsToCart(ingredient),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 8.0.w),
                  decoration: BoxDecoration(
                    color: kcPrimaryColorDark.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(32.0.dg),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'deselect all',
                        style: globalTextStyle(
                          fontSize: 12.sp,
                          color: kcBlackColor,
                          letterSpacing: -0.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      horizontalSpaceSmall,
                      Container(
                        width: 12.0.w,
                        height: 12.0.h,
                        decoration: BoxDecoration(
                          color: viewModel
                                .checkShoppingList(ingredient)
                            ? kcBlackColor.withOpacity(0.8)
                            : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kcBlackColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130.w,
                  child: Text('${ingredient.quantity} ${ingredient.unit}',
                      style: globalTextStyle(
                        color: kcBlackColor.withOpacity(0.87),
                        letterSpacing: -0.3,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                SizedBox(
                  width: 160.w,
                  child: Text(
                    capitalizeEachWord(ingredient.ingredientName),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: globalTextStyle(
                      letterSpacing: -0.3,
                      color: kcBlackColor.withOpacity(0.5),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: 15.0.w,
                  height: 15.0.h,
                  decoration: BoxDecoration(
                    color: viewModel.checkShoppingList(ingredient)
                        ? kcPrimaryColorDark
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kcPrimaryColorDark,
                    ),
                  ),
                  child: viewModel.checkShoppingList(ingredient)
                      ? Icon(
                          Icons.check,
                          color: kcWhiteColor,
                          size: 12.0.sp,
                        )
                      : Container(),
                ),
                horizontalSpaceTiny,
              ],
            ),
          ],),
    ];
  }

  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShoppingListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const TopBarShoppingScreen(),
      body: viewModel.isBusy
          ? const Center(
              child: CircularProgressIndicator(
                color: kcPrimaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceSmall,
                      ...createShoppingListWidgets(viewModel, context),
                    ],
                  )),
            ),
    );
  }

  @override
  void onViewModelReady(ShoppingListViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  ShoppingListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShoppingListViewModel();
}
