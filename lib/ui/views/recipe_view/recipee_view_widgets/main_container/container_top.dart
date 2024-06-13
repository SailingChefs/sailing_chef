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
                if (media.isFirebaseVideoUrl) {
                  return CustomVideoPlayer.network(
                    url: media,
                  );
                } else if (media.isFirebaseImageUrl) {
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
          bottom: 20,
          child: SizedBox(
            height: 32.h,
            width: MediaQuery.of(context).size.width,
            child: Center(
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
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: GestureDetector(
            onTap: () => viewModel.moveBack(),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 8.0.dg),
              height: 36.h,
              width: 36.w,
              decoration: const BoxDecoration(
                color: kcVeryLightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: kcBlackColor,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
