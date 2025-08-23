import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/views/manage_recipes/manage_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/manage_recipes/views/manage_recipes.dart';
import 'package:sailing_chefs/ui/views/manage_recipes/widgets/top_bar_admin_view.dart';
import 'package:stacked/stacked.dart';

class ManageRecipesView extends StackedView<ManageRecipesViewModel> {
  const ManageRecipesView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ManageRecipesViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: const TopBarAdminView('Manage Recipes'),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Pending'),
                  Tab(text: 'Review'),
                  Tab(text: 'Published'),
                ],
                labelColor: Colors.black,
                indicatorColor: Colors.green,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: viewModel.recipeService.fetchPublicRecipesAsStream(),
                    builder: (context, asyncSnapshot) {
                      final recipes = asyncSnapshot.data;

                      final pendingRecipes =
                          recipes?.where((recipe) => recipe.status == 'pending').toList() ?? [];
                      final reviewRecipes =
                          recipes?.where((recipe) => recipe.status == 'review').toList() ?? [];
                      final publishedRecipes =
                          recipes?.where((recipe) => recipe.status == 'published').toList() ?? [];

                      return TabBarView(
                        children: [
                          ManageRecipes(
                            viewModel,
                            pendingRecipes,
                          ),
                          ManageRecipes(
                            viewModel,
                            reviewRecipes,
                          ),
                          ManageRecipes(
                            viewModel,
                            publishedRecipes,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(ManageRecipesViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  ManageRecipesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ManageRecipesViewModel();
}
