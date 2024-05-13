import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class TimeAndServing extends StatelessWidget {
  final RecipeModel recipeModel;
  const TimeAndServing({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 130,
          height: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kcPrimaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FlutterRemix.time_line,
                color: kcBlackColor,
                size: 21.dg,
              ),
              horizontalSpaceSmall,
              Text(
                ' ${recipeModel.prepTime}min',
                style: globalTextStyle(
                  fontSize: 16.0.sp,
                  color: kcBlackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        horizontalSpaceMedium,
        Container(
            width: 130,
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kcPrimaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: kcPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        FlutterRemix.subtract_fill,
                        color: kcWhiteColor,
                      ),
                    ),
                  ),

                  // horizontalSpaceSmall,
                  Text(
                    ' ${recipeModel.servingSize} ',
                  ),
                  const Icon(
                    FlutterRemix.add_circle_fill,
                    color: kcPrimaryColor,
                  ),
                ])),
      ],
    );
  }
}
