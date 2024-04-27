import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../saved_recipe_details_viewmodel.dart';

class TopBarDetailsScreen extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final List<String> image;
  const TopBarDetailsScreen({
    required this.image,
    super.key,
  });
  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: PageView.builder(
          itemCount: image.length,
          controller: viewModel.pageController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Center(
              child: Image.network(
                image[index],
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            );
          },
        ),
      ),
    );
  }
}
