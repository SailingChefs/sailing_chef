import 'package:google_fonts/google_fonts.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class Methods extends StatelessWidget {
  final RecipeModel recipe;
  const Methods({super.key, required this.recipe});
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
                backgroundColor: const Color(0xFF2E3E5C),
                child: Text(
                  '${recipe.methods.indexOf(ingredient) + 1}',
                  style: const TextStyle(color: kcwhitecolor, fontSize: 12),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(15.dg),
                child: Text(capitalizeEachWord(ingredient),
                    style: GoogleFonts.inter(
                      textStyle: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kcBlackColor.withOpacity(0.5)),
                    )),
              ),
            ),
          ],
        ),
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
        verticalSpaceSmall,
        Text("Chef Notes",
            style: globalTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: kcBlackColor)),
        verticalSpaceSmall,
        Container(
          height: 48,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: kcMediumGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  backgroundColor: kcPrimaryColor,
                ),
                onPressed: () {},
                child: const Icon(
                  Icons.play_arrow,
                  color: kcwhitecolor,
                ),
              ),
              horizontalSpaceTiny,
              const Icon(Icons.multitrack_audio, opticalSize: 25),
              const Spacer(),
              Text("0:05",
                  style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.5))),
              horizontalSpaceTiny,
              Icon(Icons.volume_up,
                  size: 24, color: Colors.black.withOpacity(0.7)),
              horizontalSpaceSmall,
            ],
          ),
        ),
      ],
    );
  }
}
