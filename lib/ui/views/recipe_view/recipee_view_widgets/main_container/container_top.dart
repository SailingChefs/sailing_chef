
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class TopBarRecipeView extends ViewModelWidget<RecipeViewViewModel> {
 final List<XFile?> selectedImages;
  const TopBarRecipeView(this.selectedImages, {super.key,});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Image.file(
              File(selectedImages[0]!.path),
              fit: BoxFit.fill,

            )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BackArrowWidget(
              onTap: 
                viewModel.moveBack,
            ),
          ),
        ],
      ),
    );
  }
}
