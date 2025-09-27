import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_form.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/topbar.dart';

class AddRecipeView extends StackedView<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const AddRecipeView({
    this.drafts,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    AddRecipeViewModel viewModel,
    Widget? child,
  ) {
    List<Ingredient>? ingredientsList;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: TopBarAddRecipeScreen(isDraft: drafts != null),
        body: viewModel.isBusy && drafts != null
            ? const Center(
                child: CircularProgressIndicator(
                  color: kcPrimaryColor,
                ),
              )
            : GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                  ),
                  child: Column(
                    children: [
                      verticalSpaceMedium,
                      Expanded(
                        child: AddRecipeFormAddRecipeScreen(
                          drafts,
                          ingredientsList,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
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
      AddRecipeViewModel(recipeModel: drafts);
}
