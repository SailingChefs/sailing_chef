import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/back_arrow.dart';
import '../saved_recipe_details_viewmodel.dart';

class TopBarDetailsScreen extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  const TopBarDetailsScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background/burger.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BackArrowWidget(
              onTap: () {
                viewModel.moveBack();
              },
            ),
          ),
        ],
      ),
    );
  }
}
