import 'dart:developer';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

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
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                print('testingse');
                if (details.primaryVelocity! > 0) {
                  viewModel.showPreviousImage(image.length);
                } else if (details.primaryVelocity! < 0) {
                  viewModel.showNextImage(image.length);
                }
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: PageView.builder(
                  itemCount: image.length,
                  controller: viewModel.pageController,
                  itemBuilder: (context, index) {
                    // return GestureDetector(
                    //   onHorizontalDragEnd: (details) {

                    //     if (details.primaryVelocity! > 0) {
                    //       viewModel.showPreviousImage();
                    //     } else if (details.primaryVelocity! < 0) {
                    //       viewModel.showNextImage(image.length);
                    //     }
                    //   },
                    return Center(
                      child: Image.network(
                        image[index],
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: BackArrowWidget(onTap: () {
              log('back arrow pressed');
              viewModel.moveBack();
            }),
          ),
        ],
      ),
    );
  }
}
