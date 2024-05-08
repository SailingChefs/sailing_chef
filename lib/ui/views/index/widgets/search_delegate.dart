import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/search_service.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class RecipeSearchDelegate extends SearchDelegate<List<RecipeModel>> {
  final NavigationService _navigationService = NavigationService();
  final SearchService _searchService = SearchService();
  @override
  String get searchFieldLabel => 'Search Recipes';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Type something to search'),
      );
    }

    return FutureBuilder<List<RecipeModel>>(
      future: _searchService.filterRecipes(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final recipes = snapshot.data;

        if (recipes == null || recipes.isEmpty) {
          return const Center(
            child: Text('No recipes found'),
          );
        }
        //  final List<RecipeModel> filteredRecipes =  _searchService.filterRecipes(query);

        return ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return ListTile(
              leading: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(recipe.coverImage.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(capitalizeEachWord(recipe.title)),
              trailing: const Icon(Icons.chevron_right),
              subtitle: Text(recipe.prepTime),
              onTap: () {
                _navigationService.navigateToSavedRecipeDetailsView(
                    recipeModel: recipe,
                    recipeList: IndexViewModel.getRandomDishes(recipe, recipes));
              },
            );
          },
        );
      },
    );
  }
}
