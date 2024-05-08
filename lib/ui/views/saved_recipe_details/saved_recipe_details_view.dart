import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/maincontainer.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

import 'widgets/top_image.dart';

class SavedRecipeDetailsView extends StackedView<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  final List<RecipeModel> randomRecipeList;


  const SavedRecipeDetailsView({
    Key? key,
    required this.recipeModel,
    required this.randomRecipeList,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SavedRecipeDetailsViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center(
            child: CircularProgressIndicator(
            color: kcPrimaryColor,
          ))
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Stack(children: [
              TopBarDetailsScreen(image: recipeModel.coverImage),
              MainRecipeViewContainer(
                recipeModel: recipeModel,
                recipeList: randomRecipeList,
              ),
              Positioned(
                top: 40,
                left: 10,
                child: BackArrowWidget(onTap: () {
                  log('back arrow pressed');
                  viewModel.moveBack();
                }),
              ),
            ]),
          );
  }

  @override
  void onViewModelReady(SavedRecipeDetailsViewModel viewModel) {
    viewModel.onViewModelReady(
        recipeModel.coverImage.length, recipeModel.docId);
    super.onViewModelReady(viewModel);
  }

  @override
  SavedRecipeDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SavedRecipeDetailsViewModel(
        recipeModel: recipeModel,
      );
}
