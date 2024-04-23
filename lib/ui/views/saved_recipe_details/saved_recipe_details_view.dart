import 'package:flutter/material.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/maincontainer.dart';
import 'package:stacked/stacked.dart';
import 'widgets/top_image.dart';

class SavedRecipeDetailsView extends StackedView<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  const SavedRecipeDetailsView({Key? key, required this.recipeModel})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SavedRecipeDetailsViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Stack(children: [
              TopBarDetailsScreen(image: recipeModel.coverImage),
              MainRecipeViewContainer(
                recipeModel: recipeModel,
              ),
              verticalSpaceMedium,
            ]),
          );
  }

  @override
  void onViewModelReady(SavedRecipeDetailsViewModel viewModel) {
    viewModel.onViewModelReady(recipeModel.coverImage.length);
    super.onViewModelReady(viewModel);
  }

  @override
  SavedRecipeDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SavedRecipeDetailsViewModel();
}
