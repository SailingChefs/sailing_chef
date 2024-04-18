
import 'package:google_fonts/google_fonts.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class IngredientsClass extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  const IngredientsClass({super.key, required this.recipeModel});

  List<Widget> createIngredientWidgets() {
    return [
      for (var ingredient in recipeModel.ingredients)
        Container(
          height: 50.0,
      
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(capitalizeEachWord(ingredient.name),
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  )),
              Text('${ingredient.quantity} ${ingredient.unit}',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins'),
                  )),
            ],
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    var allIngredients = createIngredientWidgets();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ingredients',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
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
        ...allIngredients
      ],
    );
  }
}
