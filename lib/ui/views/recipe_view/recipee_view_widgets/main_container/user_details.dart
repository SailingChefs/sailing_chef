import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class ChefDetail extends ViewModelWidget<RecipeViewViewModel> {
  const ChefDetail({super.key});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: kcBackgroundColor,
          radius: 19.62.dg,
          backgroundImage: NetworkImage(
            userDetails!.displayPicture!,
          ),
        ),
        horizontalSpaceMedium,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              userDetails!.displayName!,
              style: globalTextStyle(
                letterSpacing: -0.5,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: kcBlackColor,
              ),
            ),
            Text(
                    '${userDetails!.recipes!.length} recipes',
                    style: globalTextStyle(
                      fontSize: 14.sp,
                      letterSpacing: -0.3,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.5),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
