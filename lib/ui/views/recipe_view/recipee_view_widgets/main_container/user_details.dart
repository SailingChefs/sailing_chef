import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class ChefDetail extends ViewModelWidget<RecipeViewViewModel> {
  const ChefDetail({super.key});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Row(
      children: [
        Container(
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
            color: kcVeryLightGrey,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: userDetails!.displayPicture!.isEmpty
                  ? const AssetImage('assets/images/misc/blank_image.png')
                  : NetworkImage(userDetails!.displayPicture!) as ImageProvider,
              fit: BoxFit.cover,
            ),
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
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: kcBlackColor,
              ),
            ),
            viewModel.isBusy
                ? Text(' recipes',
                    style: globalTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.6),
                    ))
                : Text('${userDetails!.recipes!.length} recipes',
                    style: globalTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.6),
                    ))
          ],
        ),
      ],
    );
  }
}
