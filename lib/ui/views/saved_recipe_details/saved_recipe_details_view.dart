import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/maincontainer.dart';
import 'package:stacked/stacked.dart';
import 'widgets/top_image.dart';

class SavedRecipeDetailsView extends StackedView<SavedRecipeDetailsViewModel> {
  const SavedRecipeDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SavedRecipeDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(children: [
        const TopBarDetailsScreen(),
        const MainRecipeViewContainer(),
        verticalSpaceMedium,
      ]),
    );
  }

  @override
  SavedRecipeDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SavedRecipeDetailsViewModel();
}
