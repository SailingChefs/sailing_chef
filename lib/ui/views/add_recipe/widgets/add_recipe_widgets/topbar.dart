import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class TopBarAddRecipeScreen extends ViewModelWidget<AddRecipeViewModel>
    implements PreferredSizeWidget {
  const TopBarAddRecipeScreen({this.isDraft = false, super.key});

  final bool isDraft;

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isDraft)
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: viewModel.back,
                child: Container(
                  alignment: Alignment.center,
                  height: 26.h,
                  width: 24.w,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kcBlackColor,
                    size: 18.sp,
                  ),
                ),
              ),
            )
          else
            const SizedBox(width: 32),
          Text(
            'Create Recipe',
            style: globalTextStyle(
              fontSize: 16.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => viewModel.showDraftDialog(isDraft),
              child: Icon(
                Icons.save,
                color: kcPrimaryColor,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
