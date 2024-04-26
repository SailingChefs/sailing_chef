// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/container_top.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/maincontainer.dart';
import 'package:stacked/stacked.dart';
import 'recipe_view_viewmodel.dart';

class RecipeViewView extends StackedView<RecipeViewViewModel> {
  final RecipeModel recipeModel;

  final List<XFile>? selectedImages;
  List<double>? waveFormData;
  String? path;

  RecipeViewView(this.recipeModel, this.selectedImages,
      {Key? key, this.waveFormData, this.path})

      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RecipeViewViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(children: [
        TopBarRecipeView(selectedImages!),
        MainRecipeViewContainer(recipeModel, selectedImages!),
        verticalSpaceMedium,
      ]),
    );
  }

  @override
  RecipeViewViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeViewViewModel(waveFormData: waveFormData, path: path);

  @override
  void onViewModelReady(RecipeViewViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }
}
