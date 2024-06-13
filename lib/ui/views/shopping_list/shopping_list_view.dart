import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/shopping_list.dart';
import 'package:sailing_chefs/ui/views/shopping_list/widgets/topBar.dart';
import 'shopping_list_viewmodel.dart';

class ShoppingListView extends StackedView<ShoppingListViewModel> {
  List<Widget> createShoppingListWidgets(
      ShoppingListViewModel viewModel, context) {
    Map<String, List<ShoppingList>> groupedIngredients = {};

    // Group ingredients by recipe name
    for (var ingredient in viewModel.shoppingList) {
      if (!groupedIngredients.containsKey(ingredient.recipeName)) {
        groupedIngredients[ingredient.recipeName] = [];
      }
      groupedIngredients[ingredient.recipeName]!.add(ingredient);
    }

    List<Widget> widgets = [];

    // Create widgets for each recipe and its ingredients
    groupedIngredients.forEach((recipeName, ingredients) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  capitalizeEachWord(recipeName),
                  style: globalTextStyle(
                    fontSize: 18,
                    color: kcBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  // onTap: () => viewModel.addAllItemsToCart(ingredients),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: kcPrimaryColorDark.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Deselect All',
                          style: globalTextStyle(
                            fontSize: 12,
                            color: kcBlackColor,
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        horizontalSpaceSmall,
                        Container(
                          width: 12.0,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
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
              ],
            ),
            verticalSpaceSmall,
            ...ingredients.map((ingredient) {
              return GestureDetector(
                onTap: () => viewModel.addOneItemToCart(ingredient),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (ingredient.isRemoved)
                        Text(
                          '${ingredient.quantity} ${ingredient.unit}',
                          overflow: TextOverflow.ellipsis,
                          style: globalTextStyle(
                            fontSize: 15,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w500,
                            color: kcBlackColor.withOpacity(0.87),
                          ),
                        )
                      else
                        Text(
                          '${ingredient.quantity} ${ingredient.unit}',
                          overflow: TextOverflow.ellipsis,
                          style: globalTextStyle(
                            fontSize: 15,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w500,
                            color: kcBlackColor.withOpacity(0.87),
                          ),
                        ),
                      Text(
                        capitalizeEachWord(ingredient.ingredientName),
                        overflow: TextOverflow.ellipsis,
                        style: globalTextStyle(
                          fontSize: 13,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w400,
                          color: kcBlackColor.withOpacity(0.87),
                        ),
                      ),
                      Container(
                        width: 15.0,
                        height: 15.0,
                        decoration: BoxDecoration(
                          color: ingredient.isRemoved
                              ? Colors.transparent
                              : viewModel.checkShoppingList(ingredient)
                                  ? kcPrimaryColorDark
                                  : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kcPrimaryColorDark,
                          ),
                        ),
                        child: ingredient.isRemoved
                            ? null
                            : viewModel.checkShoppingList(ingredient)
                                ? const Icon(
                                    Icons.check,
                                    color: kcWhiteColor,
                                    size: 12.0,
                                  )
                                : null,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            verticalSpaceSmall,
          ],
        ),
      );
    });

    return widgets;
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
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: viewModel.localShoppingList.isEmpty
                    ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Shopping List Empty!',
                              textAlign: TextAlign.center,
                              style: globalTextStyle(
                                color: kcPrimaryColor.withOpacity(0.9),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          verticalSpaceSmall,
                          ...createShoppingListWidgets(viewModel, context),
                        ],
                      ),
              ),
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
