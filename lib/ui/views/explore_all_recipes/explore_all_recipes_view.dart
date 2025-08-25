import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/explore_all_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/widgets/all_recipes.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/widgets/search_view.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/widgets/shimmer.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class ExploreAllRecipesView extends StackedView<ExploreAllRecipesViewModel> {
  final List<RecipeModel> recipes;
  const ExploreAllRecipesView({required this.recipes, super.key});

  @override
  Widget builder(
    BuildContext context,
    ExploreAllRecipesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kcWhiteColor,
      appBar: AppBar(
        backgroundColor: kcWhiteColor,
        elevation: 0,
        title: Text('Explore All Recipes',
            style: globalTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: kcBlackColor)),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackArrowWidget(
            onTap: viewModel.toHomeView,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          children: [
            verticalSpace(24),
            SearchBarAllRecipesScreen(
              recipes: recipes,
            ),
            verticalSpace(16),
            if (viewModel.isBusy)
              const ShimmerLoaderAllRecipes()
            else
              viewModel.searchController.text.isEmpty
                  ? AllRecipesScreen(
                      recipes: recipes,
                    )
                  : SearchViewAllRecipes(
                      recipes: recipes,
                    ),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(ExploreAllRecipesViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  ExploreAllRecipesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExploreAllRecipesViewModel();
}
