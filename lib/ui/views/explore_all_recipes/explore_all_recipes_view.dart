import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/widgets/all_recipes.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/widgets/search_view.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/widgets/shimmer.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

import 'explore_all_recipes_viewmodel.dart';

class ExploreAllRecipesView extends StackedView<ExploreAllRecipesViewModel> {
  const ExploreAllRecipesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExploreAllRecipesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
          backgroundColor: kcBackgroundColor,
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
              ))),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [
            verticalSpace(41),
            const SearchBarAllRecipesScreen(),
            viewModel.isBusy
                ? const ShimmerLoaderAllRecipes()
                : viewModel.searchController.text.isEmpty
                    ? const AllRecipesScreen()
                    : const SearchViewAllRecipes(),
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
