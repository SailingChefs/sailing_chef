import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/save_share.dart';
import 'package:sailing_chefs/ui/widgets/custom_video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../saved_recipe_details_viewmodel.dart';

class TopBarDetailsScreen extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final List<String> image;
  final RecipeModel reciepmodel;
  final bool isFromPrivateProfile;
  const TopBarDetailsScreen({
    required this.image,
    required this.isFromPrivateProfile,
    required this.reciepmodel,
    super.key,
  });
  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.44,
          child: PageView.builder(
              itemCount: image.length,
              controller: viewModel.pageController,
              itemBuilder: (context, index) {
                return Center(
                  child: image[index].contains('mp4')
                      ? SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.44,
                          child: CustomVideoPlayer.network(
                            url: image[index],
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.44,
                          child: Image.network(
                            image[index],
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            width: double.infinity,
                          ),
                        ),
                );
              }),
        ),
        Positioned(
          bottom: 30,
          left: MediaQuery.of(context).size.width * 0.42,
          child: SmoothPageIndicator(
            controller: viewModel.pageController,
            count: image.length,
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
        Positioned(
          top: 40,
          right: 10,
          child: SaveShare(

            isFromPrivateProfile:isFromPrivateProfile,

            recipe: reciepmodel,
          ),
        ),
      ],
    );
  }
}
