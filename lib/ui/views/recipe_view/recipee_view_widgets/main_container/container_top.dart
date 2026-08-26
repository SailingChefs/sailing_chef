import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TopBarRecipeView extends ViewModelWidget<RecipeViewViewModel> {
  final List<XFile?> selectedImages;
  final List<String?> newUrls;
  const TopBarRecipeView(
    this.selectedImages,
    this.newUrls, {
    super.key,
  });

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.44,
          child: PageView.builder(
            itemCount: viewModel.selectedImages.length,
            controller: viewModel.pageController,
            onPageChanged: (index) {
              viewModel.updateVideoSource(
                File(selectedImages[index]!.path),
              );
            },
            itemBuilder: (context, index) {
              var media = viewModel.selectedImages[index];
              if (media is String) {
                if (media.contains('.mp4')) {
                  return CustomVideoPlayer.network(
                    url: media,
                  );
                } else if (media.contains('.jpg')) {
                  return Image.network(
                    media,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                }
              }
              if (media is XFile) {
                if (media.isVideo) {
                  return CustomVideoPlayer.file(
                    pathh: media.path,
                  );
                } else if (media.isImage) {
                  return Image.file(
                    File(media.path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                }
              }
              return null;
            },
          ),
        ),
        Positioned(
          bottom: 50,
          left: MediaQuery.of(context).size.width * 0.42,
          child: SmoothPageIndicator(
            controller: viewModel.pageController,
            count: viewModel.selectedImages.length,
            axisDirection: Axis.horizontal,
            effect: SlideEffect(
              spacing: 8.0,
              radius: 4.0,
              dotWidth: 9.0,
              dotHeight: 9.0,
              strokeWidth: 1.5,
              dotColor: kcWhiteColor.withOpacity(0.5),
              activeDotColor: kcWhiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
