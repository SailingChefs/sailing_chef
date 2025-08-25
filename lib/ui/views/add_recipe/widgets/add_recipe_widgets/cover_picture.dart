import 'dart:io';

// import 'package:croppy/croppy.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

import 'package:sailing_chefs/ui/widgets/custom_video_player.dart';

class CoverPictureSelector extends ViewModelWidget<AddRecipeViewModel> {
  const CoverPictureSelector(this.drafts, {super.key});
  final RecipeModel? drafts;
  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return viewModel.alreadySelectedImages.isNotEmpty
        ? SingleChildScrollView(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.98.w,
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...viewModel.alreadySelectedImages.map((String url) {
                        final media = viewModel.alreadySelectedImages.elementAt(
                            viewModel.alreadySelectedImages.indexOf(url));

                        if (media.isFirebaseVideoUrl) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                height: 148.0,
                                width: 138.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: CustomVideoPlayer.network(
                                    url: media,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () => viewModel.fireBaseImage(
                                      drafts!.docId!, media.indexOf(url)),
                                  child: Icon(
                                    Icons.close,
                                    size: 24,
                                    color: kcwhitecolor.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Text(
                                  'video',
                                  style: globalTextStyle(
                                      fontSize: 8.sp,
                                      letterSpacing: -0.5,
                                      fontWeight: FontWeight.w600,
                                      color: kcwhitecolor.withOpacity(0.5)),
                                ),
                              ),
                            ],
                          );
                        } else if (media.isFirebaseImageUrl) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                height: 148.0,
                                width: 138.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(media),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () => viewModel.fireBaseImage(
                                      drafts!.docId!, media.indexOf(url)),
                                  child: Icon(
                                    Icons.close,
                                    size: 24,
                                    color: kcwhitecolor.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      }),
                      Row(
                        children: [
                          ...viewModel.selectedImages.map((XFile image) {
                            viewModel.updateVideoSource(
                              File(viewModel
                                  .selectedImages[
                                      viewModel.selectedImages.indexOf(image)]
                                  .path),
                            );

                            final media = File(image.path);

                            if (media.path.toLowerCase().endsWith('.mp4')) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    height: 148.0,
                                    width: 138.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: CustomVideoPlayer.file(
                                        pathh: media.path,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () =>
                                          viewModel.deleteCurrentImage(image),
                                      child: Icon(
                                        Icons.close,
                                        size: 24,
                                        color: kcwhitecolor.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Text(
                                        'video',
                                        style: globalTextStyle(fontSize: 7.sp),
                                      )),
                                ],
                              );
                            } else if (media.path
                                    .toLowerCase()
                                    .endsWith('.jpg') ||
                                media.path.toLowerCase().endsWith('.jpeg') ||
                                media.path.toLowerCase().endsWith('.png')) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    height: 148.0,
                                    width: 138.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(media),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () =>
                                          viewModel.deleteCurrentImage(image),
                                      child: Icon(
                                        Icons.close,
                                        size: 24,
                                        color: kcwhitecolor.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: GestureDetector(
                                      onTap: () => viewModel.showCroppper(
                                        media,
                                        context,
                                        viewModel.selectedImages.indexOf(image),
                                      ),
                                      child: Icon(
                                        Icons.crop,
                                        size: 24,
                                        color: kcwhitecolor.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          }),
                          GestureDetector(
                              onTap: viewModel.pickImages,
                              child: DottedBorder(
                                // borderType: BorderType.RRect,
                                // radius: Radius.circular(20.0.r),
                                // strokeWidth: 2.0,
                                // dashPattern: const [8, 4],
                                // color: kcBlackColor.withOpacity(0.3),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.08),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/icons/photo.svg',
                                        height: 40,
                                      ),
                                      Text(
                                        'Add Recipee image',
                                        textAlign: TextAlign.center,
                                        style: globalTextStyle(
                                          fontSize: 14.0.sp,
                                          letterSpacing: -0.7,
                                          fontWeight: FontWeight.w600,
                                          color: kcBlackColor.withOpacity(0.3),
                                        ),
                                      ),
                                      verticalSpaceSmall,
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Images',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: kcBlackColor),
                  ),
                  horizontalSpaceTiny,
                  Text(
                    '*',
                    style: globalTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: kcErrorColor),
                  ),
                ],
              ),
              horizontalSpaceTiny,
              GestureDetector(
                onTap: () {
                  viewModel.thumbnails.isEmpty ? viewModel.pickImages() : null;
                },
                child: viewModel.thumbnails.isEmpty
                    ? DottedBorder(
                        // borderType: BorderType.RRect,
                        // radius: Radius.circular(20.0.r),
                        // strokeWidth: 2.0,
                        // dashPattern: const [8, 4],
                        // color: kcBlackColor.withOpacity(0.3),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * 0.08),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/icons/photo.svg',
                                height: 40,
                              ),
                              Text(
                                'Add Recipee image',
                                textAlign: TextAlign.center,
                                style: globalTextStyle(
                                  fontSize: 14.0.sp,
                                  letterSpacing: -0.7,
                                  fontWeight: FontWeight.w600,
                                  color: kcBlackColor.withOpacity(0.3),
                                ),
                              ),
                              verticalSpaceSmall,
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.18.h,
                          //   child: Stack(
                          //     children: [
                          //       PageView.builder(
                          //         itemCount: viewModel.selectedImages.length,
                          //         controller: viewModel.pageController,
                          //         onPageChanged: (index) {
                          //           viewModel.updateVideoSource(
                          //             File(viewModel.selectedImages[index].path),
                          //           );
                          //         },
                          //         itemBuilder: (context, index) {
                          //           var media = viewModel.selectedImages[index];
                          //           if (media.isVideo) {
                          //             return CustomVideoPlayer.file(
                          //               pathh: media.path,
                          //             );
                          //           } else if (media.isImage) {
                          //             return Image.file(
                          //               File(media.path),
                          //               fit: BoxFit.fitWidth,
                          //               width: double.infinity,
                          //             );
                          //           }
                          //           return null;
                          //         },
                          //       ),
                          //       Positioned(
                          //         top: 8.0,
                          //         right: 8.0,
                          //         child: IconButton(
                          //           icon: const Icon(
                          //             Icons.delete_outline,
                          //             color: kcPrimaryColor,
                          //             size: 35,
                          //           ),
                          //           onPressed: viewModel.deleteCurrentImage,
                          //         ),
                          //       ),
                          //       Align(
                          //         alignment: Alignment.bottomCenter,
                          //         child: SmoothPageIndicator(
                          //           controller: viewModel.pageController,
                          //           count: viewModel.selectedImages.length,
                          //           axisDirection: Axis.horizontal,
                          //           effect: const ExpandingDotsEffect(
                          //             spacing: 8.0,
                          //             radius: 4.0,
                          //             dotWidth: 8.0,
                          //             dotHeight: 8.0,
                          //             strokeWidth: 1.5,
                          //             dotColor: Colors.grey,
                          //             activeDotColor: kcPrimaryColorDark,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Add Images',
                          //       style: globalTextStyle(
                          //         fontSize: 14.sp,
                          //         letterSpacing: -0.5,
                          //         fontWeight: FontWeight.w600,
                          //         color: kcBlackColor,
                          //       ),
                          //     ),
                          //     horizontalSpaceTiny,
                          //     Text(
                          //       '*',
                          //       style: globalTextStyle(
                          //           fontSize: 16.sp,
                          //           fontWeight: FontWeight.w600,
                          //           color: kcErrorColor),
                          //     ),
                          //   ],
                          // ),
                          SingleChildScrollView(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.98.w,
                                padding: const EdgeInsets.all(10.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ...viewModel.selectedImages
                                          .map((XFile image) {
                                        viewModel.updateVideoSource(
                                          File(viewModel
                                              .selectedImages[viewModel
                                                  .selectedImages
                                                  .indexOf(image)]
                                              .path),
                                        );

                                        final media = File(image.path);

                                        if (media.isVideo) {
                                          return Stack(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8.0),
                                                height: 148.0,
                                                width: 138.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: CustomVideoPlayer.file(
                                                    pathh: media.path,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: GestureDetector(
                                                  onTap: () => viewModel
                                                      .deleteCurrentImage(
                                                          image),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 24,
                                                    color: kcwhitecolor
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 10,
                                                  left: 10,
                                                  child: Text(
                                                    'video',
                                                    style: globalTextStyle(
                                                        fontSize: 7.sp),
                                                  )),
                                            ],
                                          );
                                        } else if (media.isImage) {
                                          return Stack(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8.0),
                                                height: 148.0,
                                                width: 138.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(media),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: GestureDetector(
                                                  onTap: () => viewModel
                                                      .deleteCurrentImage(
                                                          image),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 24,
                                                    color: kcwhitecolor
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                left: 10,
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      viewModel.showCroppper(
                                                    media,
                                                    context,
                                                    viewModel.selectedImages
                                                        .indexOf(image),
                                                  ),
                                                  child: Icon(
                                                    Icons.crop,
                                                    size: 24,
                                                    color: kcwhitecolor
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return Container(); // Placeholder for unsupported media types
                                      }),
                                      GestureDetector(
                                          onTap: viewModel.pickImages,
                                          child: DottedBorder(
                                            // borderType: BorderType.RRect,
                                            // radius: Radius.circular(20.0.r),
                                            // strokeWidth: 2.0,
                                            // dashPattern: const [8, 4],
                                            // color:
                                            //     kcBlackColor.withOpacity(0.3),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.08),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/icons/photo.svg',
                                                    height: 40,
                                                  ),
                                                  Text(
                                                    'Add Recipee image',
                                                    textAlign: TextAlign.center,
                                                    style: globalTextStyle(
                                                      fontSize: 14.0.sp,
                                                      letterSpacing: -0.7,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kcBlackColor
                                                          .withOpacity(0.3),
                                                    ),
                                                  ),
                                                  verticalSpaceSmall,
                                                ],
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          );
  }
}
