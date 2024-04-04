import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_form.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/top_bar.dart';

import 'add_recipe_viewmodel.dart';

class AddRecipeView extends StackedView<AddRecipeViewModel> {
  final List<Ingredient> ? ingredientsList;
  const AddRecipeView(this.ingredientsList, {Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddRecipeViewModel viewModel,
    Widget? child,
  ) {
    return SizedBox(
        child: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    body: Container(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: Column(
                        children: [
                          const TopBarAddRecipe(),
                          verticalSpaceMedium,
                         Expanded(child: AddRecipeFormAddRecipeScreen(ingredientsList)),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }

  @override
  void onViewModelReady(AddRecipeViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  AddRecipeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddRecipeViewModel();
}
