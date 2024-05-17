import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_form.dart';

import 'add_recipe_viewmodel.dart';

class AddRecipeView extends StackedView<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const AddRecipeView({
    this.drafts,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddRecipeViewModel viewModel,
    Widget? child,
  ) {
    List<Ingredient>? ingredientsList;
    return SizedBox(
      child: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Create Recipe',
                  style: globalTextStyle(
                      fontSize: 18.0.dg,
                      color: kcBlackColor,
                      fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onTap: viewModel.showDraftDialog,
                    child: Icon(
                      Icons.file_copy,
                      color: kcPrimaryColor,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              body: Container(
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
