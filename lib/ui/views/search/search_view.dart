import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/search/search_viewmodel.dart';
import 'package:sailing_chefs/ui/views/search/widgets/chef_screen.dart';
import 'package:sailing_chefs/ui/views/search/widgets/recipe_search.dart';
import 'package:sailing_chefs/ui/views/search/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/views/search/widgets/tab_bar.dart';

// ignore: must_be_immutable
class SearchView extends StackedView<SearchViewModel> {
  final List<RecipeModel> recipeModel;
  final List<UserModel> chefList;
  int selectedTagsCount;
  SearchView(
      {required this.recipeModel, required this.chefList, required this.selectedTagsCount, super.key});

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
                  backgroundColor: kcWhiteColor,
                  appBar: AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => viewModel.goBack(),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 8.0.dg),
                          height: 30.h,
                          width: 30.w,
                          decoration: const BoxDecoration(
                            color: kcVeryLightGrey,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: kcBlackColor.withOpacity(0.87),
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    //,
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Column(
                      children: [
                        // const TopBarSearchScreen(),
                        verticalSpaceMedium,
                        SearchBarSearchScreen(
                          selectedTagsCount,
                          recipes: recipeModel,
                        ),
                        verticalSpaceMedium,
                        const TabBarSeacrhScreen(),
                        verticalSpaceTiny,
                        if (viewModel.isRecipeSelected) RecipeScreen(
                                recipes: recipeModel,
                              ) else ChefScreen(
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
