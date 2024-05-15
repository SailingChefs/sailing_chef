import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';

class ExploreAllButton extends ViewModelWidget<SavedRecipesViewModel> {
 
  const ExploreAllButton({super.key, });

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return GestureDetector(
      onTap:() => viewModel.toAllDishesScreen(),
      child: Container(
        width: 203,
        height: 48,
        decoration: BoxDecoration(
          color: kcPrimaryColorDark,
          borderRadius: BorderRadius.circular(38),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            'Discover more  recipes',
            style: globalTextStyle(fontSize: 14, color: kcwhitecolor),
          ),
        ),
      ),
    );
  }
}
