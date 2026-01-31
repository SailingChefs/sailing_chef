import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/edit_comment/edit_comment_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class EditCommentSheet extends StackedView<EditCommentSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const EditCommentSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    EditCommentSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: kcwhitecolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Review',
                        style: globalTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: kcBlackColor,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: viewModel.cancel,
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Rating',
                    style: globalTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: kcBlackColor,
                    ),
                  ),
                  verticalSpaceSmall,
                  RatingBar.builder(
                    initialRating: viewModel.rating,
                    minRating: 1,
                    allowHalfRating: true,
                    itemSize: 30.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: viewModel.updateRating,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Comment',
                    style: globalTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: kcBlackColor,
                    ),
                  ),
                  verticalSpaceSmall,
                  RoundedTransparentTextField(
                    borderColor: Colors.black.withOpacity(0.2),
                    fillColor: Colors.transparent,
                    labelText: 'Your review',
                    textColor: Colors.black.withOpacity(0.8),
                    controller: viewModel.commentController,
                    maxLines: 4,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Images',
                    style: globalTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: kcBlackColor,
                    ),
                  ),
                  verticalSpaceSmall,
                  if (viewModel.existingImages.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Existing images',
                          style: globalTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: kcBlackColor.withOpacity(0.7),
                          ),
                        ),
                        verticalSpaceSmall,
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                              viewModel.existingImages.length, (index) {
                            final isMarkedForDeletion = viewModel
                                .isExistingImageMarkedForDeletion(index);

                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          viewModel.existingImages[index]),
                                      fit: BoxFit.cover,
                                      colorFilter: isMarkedForDeletion
                                          ? ColorFilter.mode(
                                              Colors.red.withOpacity(0.3),
                                              BlendMode.srcOver)
                                          : null,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                      isMarkedForDeletion
                                          ? Icons.refresh
                                          : Icons.cancel,
                                      color: isMarkedForDeletion
                                          ? Colors.green
                                          : kcLightGrey),
                                  onPressed: () =>
                                      viewModel.removeExistingImage(index),
                                  iconSize: 20,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                )
                              ],
                            );
                          }),
                        ),
                        verticalSpaceSmall,
                      ],
                    ),
                  if (viewModel.images.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New images',
                          style: globalTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: kcBlackColor.withOpacity(0.7),
                          ),
                        ),
                        verticalSpaceSmall,
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children:
                              List.generate(viewModel.images.length, (index) {
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(viewModel.images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel, color: kcLightGrey),
                                  onPressed: () => viewModel.removeImage(index),
                                  iconSize: 20,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                )
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: viewModel.pickImage,
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Add Images'),
                        style: TextButton.styleFrom(
                          foregroundColor: kcPrimaryColor,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: viewModel.updateComment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kcPrimaryColor,
                          foregroundColor: kcwhitecolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Update Review'),
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
    );
  }

  @override
  void onViewModelReady(EditCommentSheetModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  EditCommentSheetModel viewModelBuilder(BuildContext context) =>
      EditCommentSheetModel(
        comment: request.data['comment'] as CommentModel,
        completer: completer,
        rating: request.data['rating'] as double? ?? 0.0,
      );
}
