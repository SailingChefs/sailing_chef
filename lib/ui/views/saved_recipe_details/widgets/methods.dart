import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

import '../saved_recipe_details_viewmodel.dart';

class Methods extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipe;

  const Methods({super.key, required this.recipe});
  List<Widget> createIngredientWidgets() {
    return [
      for (int i = 0; i < recipe.methods.length; i++)
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 25,
                  width: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E3E5C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: globalTextStyle(color: kcwhitecolor, fontSize: 12),
                    ),
                  ),
                ),
                horizontalSpaceSmall,
                Flexible(
                  child: Text(capitalizeEachWord(recipe.methods[i]),
                      style: GoogleFonts.inter(
                        textStyle: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),
                      )),
                ),
              ],
            ),
            verticalSpaceMedium,
            verticalSpaceSmall,
          ],
        ),
    ];
  }

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Method",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        verticalSpaceMedium,
        ...createIngredientWidgets(),
        verticalSpaceSmall,
      ],
    );
  }
}
