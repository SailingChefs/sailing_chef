import 'dart:developer';

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/shopping_list/widgets/topBar.dart';
import '../../../core/global_uservariable.dart';
import 'shopping_list_viewmodel.dart';
import 'widgets/recipee_title_widget.dart';

class ShoppingListView extends StackedView<ShoppingListViewModel> {
  // List<Widget> createShoppingListWidgets(
  //     ShoppingListViewModel viewModel, context) {
  //   Map<String, List<ShoppingItem>> groupedIngredients = {};

  //   // Group ingredients by recipe name
  //   for (var ingredient in viewModel.shoppingList) {
  //     if (!groupedIngredients.containsKey(ingredient.recipeName)) {
  //       groupedIngredients[ingredient.recipeName] = [];
  //     }
  //     groupedIngredients[ingredient.recipeName]!.add(ingredient);
  //   }

  //   List<Widget> widgets = [];

  //   // Create widgets for each recipe and its ingredients
  //   groupedIngredients.forEach((recipeName, ingredients) {
  //     widgets.add(
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           verticalSpaceMedium,
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 capitalizeEachWord(recipeName),
  //                 style: globalTextStyle(
  //                   fontSize: 18.sp,
  //                   color: kcBlackColor,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               GestureDetector(
  //                 // onTap: () => viewModel.addAllItemsToCart(ingredients),
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 16.0,
  //                     vertical: 8.0,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: kcPrimaryColorDark.withOpacity(0.2),
  //                     borderRadius: BorderRadius.circular(32.0),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         'Deselect All',
  //                         style: globalTextStyle(
  //                           fontSize: 12,
  //                           color: kcBlackColor,
  //                           letterSpacing: -0.2,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                       horizontalSpaceSmall,
  //                       Container(
  //                         width: 12.0,
  //                         height: 12.0,
  //                         decoration: BoxDecoration(
  //                           color: Colors.transparent,
  //                           shape: BoxShape.circle,
  //                           border: Border.all(
  //                             color: kcBlackColor.withOpacity(0.8),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           verticalSpaceSmall,
  //           ...ingredients.map((ingredient) {
  //             return GestureDetector(
  //               onTap: () => viewModel.addOneItemToCart(ingredient),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(right: 12.0, top: 10),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     // if (ingredient.isRemoved)
  //                     //   Expanded(
  //                     //     flex: 2,
  //                     //     child: Text(
  //                     //       '${ingredient.quantity} ${ingredient.unit}',
  //                     //       overflow: TextOverflow.ellipsis,
  //                     //       style: globalTextStyle(
  //                     //         fontSize: 15,
  //                     //         letterSpacing: -0.5,
  //                     //         fontWeight: FontWeight.w500,
  //                     //         color: kcBlackColor.withOpacity(0.87),
  //                     //       ),
  //                     //     ),
  //                     //   )
  //                     // else
  //                     Expanded(
  //                       flex: 2,
  //                       child: Text(
  //                         '${ingredient.quantity} ${ingredient.unit}',
  //                         overflow: TextOverflow.ellipsis,
  //                         style: globalTextStyle(
  //                           decoration: !ingredient.isRemoved
  //                               ? TextDecoration.lineThrough
  //                               : TextDecoration.none,
  //                           fontSize: 15,
  //                           letterSpacing: -0.5,
  //                           fontWeight: FontWeight.w500,
  //                           color: kcBlackColor.withOpacity(0.87),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 4,
  //                       child: Text(
  //                         capitalizeEachWord(ingredient.ingredientName),
  //                         overflow: TextOverflow.ellipsis,
  //                         style: globalTextStyle(
  //                           decoration: !ingredient.isRemoved
  //                               ? TextDecoration.lineThrough
  //                               : TextDecoration.none,
  //                           fontSize: 13,
  //                           letterSpacing: -0.5,
  //                           fontWeight: FontWeight.w400,
  //                           color: kcBlackColor.withOpacity(0.87),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 0,
  //                       child: Container(
  //                         width: 15.0,
  //                         height: 15.0,
  //                         decoration: BoxDecoration(
  //                           color: ingredient.isRemoved
  //                               ? Colors.transparent
  //                               : viewModel.checkShoppingList(ingredient)
  //                                   ? kcPrimaryColorDark
  //                                   : Colors.transparent,
  //                           shape: BoxShape.circle,
  //                           border: Border.all(
  //                             color: kcPrimaryColorDark,
  //                           ),
  //                         ),
  //                         child: ingredient.isRemoved
  //                             ? null
  //                             : viewModel.checkShoppingList(ingredient)
  //                                 ? const Icon(
  //                                     Icons.check,
  //                                     color: kcWhiteColor,
  //                                     size: 12.0,
  //                                   )
  //                                 : null,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           verticalSpaceSmall,
  //         ],
  //       ),
  //     );
  //   });

  //   return widgets;
  // }

  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShoppingListViewModel viewModel,
    Widget? child,
  ) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        try {
          await viewModel.updateShoppingList();
        } catch (e, stackTrace) {
          log("Failed to update shopping list on pop: $e");
          log("StackTrace: $stackTrace");
        }
        // Ensure that the pop operation is not blocked
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const TopBarShoppingScreen(),
        body: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(
                  color: kcPrimaryColor,
                ),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                      child: Container(
                    margin: EdgeInsets.only(top: 16.h),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: selectedRecipees.isEmpty
                        ? Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.5,
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.45,
                            ),
                            child: Text(
                              'Shopping List Empty!',
                              textAlign: TextAlign.center,
                              style: globalTextStyle(
                                color: kcPrimaryColor.withOpacity(0.9),
                                fontSize: 15,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: size.height,
                            child: Column(
                              children: [
                                // verticalSpaceSmall,
                                // ...createShoppingListWidgets(viewModel, context),
                                for (var recipee in selectedRecipees)
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            viewModel
                                                .addRemoveAllIngredientsToShoppingList(
                                                    recipee);
                                          },
                                          child: recipeeTitleWidget(
                                              viewModel: viewModel,
                                              recipee: recipee,
                                              size: size),
                                        ),
                                        for (var selectIngredient
                                            in showShoppingListview[
                                                        recipee.title]
                                                    ?['selected_ingredients'] ??
                                                [])
                                          GestureDetector(
                                            onTap: () {
                                              final selectedRecipe =
                                                  selectedRecipees.indexWhere(
                                                      (element) =>
                                                          element.docId ==
                                                          recipee.docId);

                                              //  ((element) => element.docId == recipee.docId);
                                              viewModel.addOneItemToCart(
                                                  ingredient: selectIngredient,
                                                  recipee: selectedRecipees[
                                                      selectedRecipe]);
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.w),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${selectIngredient.quantity} ${selectIngredient.unit}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: globalTextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 15,
                                                        letterSpacing: -0.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: kcBlackColor
                                                            .withOpacity(0.87),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      capitalizeEachWord(
                                                          selectIngredient
                                                              .name),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: globalTextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 13,
                                                        letterSpacing: -0.5,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kcBlackColor
                                                            .withOpacity(0.87),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 0,
                                                    child: Container(
                                                      width: 15.0,
                                                      height: 15.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            kcPrimaryColorDark,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              kcPrimaryColorDark,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        //  ^ For unselected ingredient

                                        for (var unSelectIngredient
                                            in showShoppingListview[
                                                        recipee.title]?[
                                                    'unselected_ingredients'] ??
                                                [])
                                          GestureDetector(
                                            onTap: () {
                                              final selectedRecipe =
                                                  selectedRecipees.indexWhere(
                                                      (element) =>
                                                          element.docId ==
                                                          recipee.docId);

                                              //  ((element) => element.docId == recipee.docId);
                                              viewModel.addOneItemToCart(
                                                  ingredient:
                                                      unSelectIngredient,
                                                  recipee: selectedRecipees[
                                                      selectedRecipe]);
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.w),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${unSelectIngredient.quantity} ${unSelectIngredient.unit}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: globalTextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize: 15,
                                                        letterSpacing: -0.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: kcBlackColor
                                                            .withOpacity(0.87),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      capitalizeEachWord(
                                                          unSelectIngredient
                                                              .name),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: globalTextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize: 13,
                                                        letterSpacing: -0.5,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kcBlackColor
                                                            .withOpacity(0.87),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 0,
                                                    child: Container(
                                                      width: 15.0,
                                                      height: 15.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              kcPrimaryColorDark,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ]),
                              ],
                            ),
                          ),
                  )),
                  Positioned(
                    bottom: 50.h,
                    right: 0,
                    left: 0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        viewModel.clearShoppingLis();
                      },
                      child: Visibility(
                        visible: selectedRecipees.isNotEmpty ? true : false,
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.r),
                                  color:
                                      const Color(0xff6C908D).withOpacity(0.5)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/icons/close.svg",
                                    color: Colors.white,
                                    height: 20.h,
                                  ),
                                  8.w.horizontalSpace,
                                  Text(
                                    "Clear All",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                  )
                ],
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
