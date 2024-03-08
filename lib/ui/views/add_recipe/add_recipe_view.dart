import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_recipe_viewmodel.dart';

class AddRecipeView extends StackedView<AddRecipeViewModel> {
  const AddRecipeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddRecipeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  AddRecipeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddRecipeViewModel();
}
