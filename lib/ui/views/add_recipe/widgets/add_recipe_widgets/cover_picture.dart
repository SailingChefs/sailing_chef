import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CoverPictureSelector extends ViewModelWidget<AddRecipeViewModel> {
  const CoverPictureSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.selectedImages.isEmpty ? viewModel.pickImages() : null;
      },
      child: viewModel.selectedImages.isEmpty
          ? DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(20.0.r),
              strokeWidth: 2.0,
              dashPattern: const [8, 4],
              color: kcBlackColor.withOpacity(0.3),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/misc/Image.png',
                      height: 100.0.h,
                      width: 100.0.w,
                    ),
                    Text(
                      'Add Cover Photo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpaceTiny,
                    Text(
                      '(upto 12 Mb)',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                    verticalSpaceSmall,
                  ],
                ),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18.h,
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemCount: viewModel.selectedImages.length,
                        controller: viewModel.pageController,
                        onPageChanged: (index) {
                          viewModel.updateVideoSource(
                            File(viewModel.selectedImages[index].path),
                          );
                        },
                        itemBuilder: (context, index) {
                          var media = viewModel.selectedImages[index];
                          if (media.isVideo) {
                            return CustomVideoPlayer.file(
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
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: kcPrimaryColor,
                            size: 35,
                          ),
                          onPressed: viewModel.deleteCurrentImage,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SmoothPageIndicator(
                          controller: viewModel.pageController,
                          count: viewModel.selectedImages.length,
                          axisDirection: Axis.horizontal,
                          effect: const ExpandingDotsEffect(
                            spacing: 8.0,
                            radius: 4.0,
                            dotWidth: 8.0,
                            dotHeight: 8.0,
                            strokeWidth: 1.5,
                            dotColor: Colors.grey,
                            activeDotColor: kcPrimaryColorDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.98.w,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...viewModel.thumbnails.map((XFile image) {
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(image.path)),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 40,
                                  bottom: 38,
                                  child: GestureDetector(
                                    onTap: () {
                                      viewModel.deleteCurrentImage();
                                    },
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kcsgreycolor,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 10,
                                        color: kcBlackColor.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                          if (viewModel.selectedImages.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                viewModel.pickImages();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  color: kcsgreycolor,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Center(
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
