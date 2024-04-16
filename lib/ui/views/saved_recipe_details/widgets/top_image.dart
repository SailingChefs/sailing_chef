import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:stacked/stacked.dart';

import '../saved_recipe_details_viewmodel.dart';

class TopBarDetailsScreen extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final String image;
  const TopBarDetailsScreen( {
    required this.image,
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
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
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
