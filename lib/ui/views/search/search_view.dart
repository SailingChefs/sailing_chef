import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/search/widgets/chef_screen.dart';
import 'package:sailing_chefs/ui/views/search/widgets/recipe_search.dart';
import 'package:sailing_chefs/ui/views/search/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/views/search/widgets/tab_bar.dart';
import 'package:sailing_chefs/ui/views/search/widgets/top_bar.dart';

import 'search_viewmodel.dart';

class SearchView extends StackedView<SearchViewModel> {
  final List<RecipeModel> recipeModel;
  final List<UserModel> chefList;
  const SearchView(
      {Key? key, required this.recipeModel, required this.chefList})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SearchViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: kcBackgroundColor,
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Column(
                      children: [
                        const TopBarSearchScreen(),
                        verticalSpaceMedium,
                        SearchBarSearchScreen(
                          recipes: recipeModel,
                        ),
                        verticalSpaceMedium,
                        const TabBarSeacrhScreen(),
                        verticalSpaceTiny,
                        viewModel.isRecipeSelected
                            ? RecipeScreen(
                                recipes: recipeModel,
                              )
                            : ChefScreen(
                                chef: chefList,
                              ),
                      ],
                    ),
                  )),
            ),
    );
  }

  @override
  SearchViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SearchViewModel();
}
