import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/views/manage_recipes/manage_recipes_viewmodel.dart';

class ManageRecipes extends StatelessWidget {
  const ManageRecipes(this.viewModel, this.recipes, {super.key, this.onTap});

  final ManageRecipesViewModel viewModel;
  final List<RecipeModel> recipes;
  final VoidCallback? onTap;

  DismissDirection get _dismissDirection => switch (recipes.first.status) {
        'pending' => DismissDirection.horizontal,
        'review' => DismissDirection.startToEnd,
        'published' => DismissDirection.endToStart,
        _ => DismissDirection.none,
      };

  Future<bool> _handleDismiss(
      BuildContext context, RecipeModel recipe, DismissDirection direction) async {
    try {
      switch (direction) {
        case DismissDirection.startToEnd:
          await viewModel.setRecipeAsPublished(recipe.docId!);
          showToast(message: '${recipe.title} set to Published');
        case DismissDirection.endToStart:
          await viewModel.setRecipeAsReview(recipe.docId!);
          showToast(message: '${recipe.title} set to Review');
        default:
          return false;
      }
      return true;
    } catch (e) {
      showToast(message: 'Action failed');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Dismissible(
          key: Key(recipe.docId!),
          direction: _dismissDirection,
          confirmDismiss: (direction) => _handleDismiss(context, recipe, direction),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text('Publish',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                ),
                Icon(Icons.check, color: Colors.white),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.amber,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text('Review',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
                ),
                Icon(Icons.rate_review, color: Colors.black),
              ],
            ),
          ),
          onDismissed: (direction) {
            switch (direction) {
              case DismissDirection.startToEnd:
                viewModel.setRecipeAsPublished(recipe.docId!);
                showToast(message: '${recipe.title} set to Published');
              case DismissDirection.endToStart:
                viewModel.setRecipeAsReview(recipe.docId!);
                showToast(message: '${recipe.title} set to Review');
              default:
                break;
            }
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            // color: Colors.yellow.withAlpha(200),
            // surfaceTintColor: Colors.red,

            child: ListTile(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                } else {
                  viewModel.toDishDetailsScreen(recipe);
                }
              },
              title: Text(recipe.title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              subtitle: Text(recipe.user?.displayName ?? 'Unknown Chef'),
            ),
          ),
        );
      },
    );
  }
}
