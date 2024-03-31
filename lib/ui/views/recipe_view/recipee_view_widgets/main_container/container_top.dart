import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../../recipe_view_viewmodel.dart';

class TopBarRecipeView extends ViewModelWidget<RecipeViewViewModel> {
  const TopBarRecipeView({super.key});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/burger.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
