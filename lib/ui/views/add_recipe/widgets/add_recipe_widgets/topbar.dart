import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class TopBarAddRecipeScreen extends ViewModelWidget<AddRecipeViewModel>
    implements PreferredSizeWidget {
  const TopBarAddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 20,
          ),
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
              onTap: viewModel.showDraftDialog,
              child: Icon(
                Icons.file_copy,
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
