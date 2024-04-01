// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/container_top.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/maincontainer.dart';
import 'package:stacked/stacked.dart';
import 'recipe_view_viewmodel.dart';

class RecipeViewView extends StackedView<RecipeViewViewModel> {
  const RecipeViewView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RecipeViewViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(children: [
        TopBarRecipeView(),
        MainRecipeViewContainer(),
        verticalSpaceMedium,
      ]),
    );
  }

  @override
  RecipeViewViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeViewViewModel();
}
