import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CoverPictureSelector extends ViewModelWidget<AddRecipeViewModel> {
  const CoverPictureSelector({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.pickImages,
      child: viewModel.selectedImages.isEmpty
          ? DottedBorder(
              borderType: BorderType.RRect,
              radius:Radius.circular(20.0.r),
              strokeWidth: 2.0,
              dashPattern: const [8, 4],
              color: kcBlackColor.withOpacity(0.3),
              child: SizedBox(
                width: double.infinity,
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Image.asset('assets/images/misc/Image.png',
                        height: 100.0.h, width: 100.0.w),
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
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity! > 0) {
                                viewModel.showPreviousImage();
                              } else if (details.primaryVelocity! < 0) {
                                viewModel.showNextImage();
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.file(
                                File(viewModel.selectedImages[index]!.path),
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: kcPrimaryColor, size: 35),
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
                FittedBox(
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9.w,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              viewModel.selectedImages.map((XFile? image) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              height: 35.0, // Adjust the height as needed
                              width: 35.0, // Adjust the width as needed
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(image!.path)),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
