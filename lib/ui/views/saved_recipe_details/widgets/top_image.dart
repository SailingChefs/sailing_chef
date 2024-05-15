import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/custom_video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../saved_recipe_details_viewmodel.dart';

class TopBarDetailsScreen extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final List<String> image;
  const TopBarDetailsScreen({
    required this.image,
    super.key,
  });
  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: PageView.builder(
                itemCount: image.length,
                controller: viewModel.pageController,
                itemBuilder: (context, index) {
                  return Center(
                    child: image[index].contains('mp4')
                        ? CustomVideoPlayer.network(
                            url: image[index],
                          )
                        : Image.network(
                            image[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
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
        ],
      ),
    );
  }
}
