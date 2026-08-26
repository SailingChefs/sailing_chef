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
          bottom: 50,
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
    );
  }
}
