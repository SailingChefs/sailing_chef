
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

import 'shopping_list_viewmodel.dart';

class ShoppingListView extends StackedView<ShoppingListViewModel> {
  List<Widget> createShoppingListWidgets(ShoppingListViewModel viewModel ,context) {
    return [
      for (var ingredient in viewModel.shoppingList)
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // height: 50,
                  width: MediaQuery.sizeOf(context).width * 0.75.w,
                  padding: EdgeInsets.all(10.dg),
                  decoration: BoxDecoration(
                    color: kcPrimaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.all(Radius.circular(30.dg)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            '${ingredient.quantity} ${ingredient.unit}',
                            overflow: TextOverflow.ellipsis,
                            style: globalTextStyle(
                              fontSize: 14.sp,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w500,
                              color: kcBlackColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            textAlign: TextAlign.right,
                            capitalizeEachWord(ingredient.ingredientName),
                            overflow: TextOverflow.ellipsis,
                            style: globalTextStyle(
                                fontSize: 13.sp,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w400,
                                color: kcBlackColor.withOpacity(0.87)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.removeRecipe(ingredient);
                    // viewModel.notifyListeners();
                  },
                  child: SvgPicture.asset(
                    'assets/images/misc/bin.svg',
                    height: 16.h,
                    width: 14.w,
                  ),
                ),
              ],
            ),
            verticalSpaceSmall,
          ],
        ),
    ];
  }

  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShoppingListViewModel viewModel,
    Widget? child,
  ) {
    return 
         Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 0,
              title: Text(
                'Shopping List',
                style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor),
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BackArrowWidget(
                  onTap: viewModel.back,
                ),
              ),
            ),
            body: viewModel.isBusy
        ? const Center(
            child: CircularProgressIndicator(
              color: kcPrimaryColor,
            ),
          ):SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(
                    children: [
                      ...createShoppingListWidgets(viewModel,context),
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
