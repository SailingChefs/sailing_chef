import 'package:google_fonts/google_fonts.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class Methods extends StatelessWidget {
  final RecipeModel recipe;
  const Methods({super.key,required this.recipe});
   List<Widget> createIngredientWidgets() {
    return [
      for (var ingredient in recipe.methods)
        Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CircleAvatar(
                      minRadius: double.minPositive + 13,
                      backgroundColor: Colors.blueGrey,
                      child: Text(
                      '${recipe.methods.indexOf(ingredient) + 1}',
                        style: const TextStyle(
                            color: kcwhitecolor, fontSize: 12),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(15.dg),
                      child: Text(
                        capitalizeEachWord(ingredient),
                        style: GoogleFonts.inter(
                            textStyle: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),)
                      ),
                    ),
                  ),
                ],
              )
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Instructions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        verticalSpaceSmall,
        ...createIngredientWidgets(),
       
      ],
    );
  }
}
