import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:sailing_chefs/ui/widgets/custom_video_player.dart';

class TopBarRecipeView extends ViewModelWidget<RecipeViewViewModel> {
  final List<XFile?> selectedImages;
  const TopBarRecipeView(
    this.selectedImages, {
    super.key,
  });

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: 250,
              child:                       PageView.builder(
                        itemCount: selectedImages.length,
                        controller: viewModel.pageController,
                        onPageChanged: (index) {
                          viewModel.updateVideoSource(
                            File(selectedImages[index]!.path),
                          );
                        },
                        itemBuilder: (context, index) {
                          var media = selectedImages[index];
                          if (media!.isVideo) {
                            return CustomVideoPlayer(
                              pathh: media.path,
                            );
                          } else if (media.isImage) {
                            
                            return Image.file(
                              File(media.path),
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                            );
                          }
                          return null;
                        },
                      ),),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BackArrowWidget(
              onTap: viewModel.moveBack,
            ),
          ),
        ],
      ),
    );
  }
}
