import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class IngredientsClass extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  const IngredientsClass({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Serves ${recipeModel.servingSize}',
                style: const TextStyle(color: Colors.black, fontSize: 10),
              ),
            ],
          ),
          Text(
            '${recipeModel.ingredients.length} items',
            style: TextStyle(fontSize: 10.0.sp),
          ),
          SizedBox(
            height: recipeModel.ingredients.length * 80.0.h,
            child: ListView.builder(
              itemCount: recipeModel.ingredients.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50.0,
                  width: 330.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        recipeModel.ingredients[index].name,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${index + 1} Tsp',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // const CommentsDetailsScreen(),
          // const LeaveComment(),
        ],
      ),
    );
  }
}
