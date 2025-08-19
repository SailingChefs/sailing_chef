import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class PublishTextButton extends ViewModelWidget<RecipeViewViewModel> {
  final RecipeModel recipe;
  final List<XFile?> selectedImages;
  const PublishTextButton(
      {required this.recipe, required this.selectedImages, super.key});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.saveRecipeToPrivate(recipe, selectedImages);
      },
      child: Column(
        children: [
          Text(
            'Publish Recipe Privately',
            style: globalTextStyle(
              fontSize: 13.sp,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF46617A),
            ),
          ),
          const Divider(
            color: kclightgreencolor,
            indent: 120,
            endIndent: 120,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
