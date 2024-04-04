
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class TopBarRecipeView extends ViewModelWidget<RecipeViewViewModel> {
  const TopBarRecipeView({super.key});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
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
              onTap: 
                viewModel.moveBack,
            ),
          ),
        ],
      ),
    );
  }
}
