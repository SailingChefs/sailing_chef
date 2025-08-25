import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/custom_comments_list.dart';

class CommentsDetailsScreen
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;

  final bool isFromPrivateProfile;
  const CommentsDetailsScreen(
      {required this.isFromPrivateProfile,
      required this.recipeModel,
      super.key});

  List<Widget> createCommentWidgets(SavedRecipeDetailsViewModel viewModel) {
    viewModel.commentsList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    var commentTiles = <Widget>[];
    if (viewModel.commentsList.isNotEmpty) {
      final comments = viewModel.commentsList;
      commentTiles = comments.map((comment) {
        // Check if this comment belongs to the current user
        final isUserComment =
            comment.userId == FirebaseAuth.instance.currentUser!.uid;

        return Column(
          children: [
            CustomListTileComments(
              name: comment.userName,
              date: comment.timestamp,
              description: comment.content ?? '',
              image: comment.userImageUrl,
              ratingImages: comment.imageUrl ?? [],
              rating: comment.rating ?? 0,
              isUserComment: isUserComment,
              onEdit: isUserComment
                  ? () => viewModel.onCommentLongPress(comment)
                  : null,
              onDelete:
                  isUserComment ? () => viewModel.deleteComment(comment) : null,
            ),
          ],
        );
      }).toList();
    }
    return commentTiles;
  }

  Widget _buildImagePreview(SavedRecipeDetailsViewModel viewModel) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(viewModel.images.length, (index) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 100,
              height: 100,
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
            )
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return !isFromPrivateProfile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style: globalTextStyle(
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.w700,
                      color: kcBlackColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        viewModel
                            .calculateAverageRating(viewModel.commentsList),
                        style: globalTextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.w700,
                          color: kcBlackColor,
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
              if (viewModel.images.isNotEmpty)
                _buildImagePreview(viewModel)
              else
                Container(),
              verticalSpaceSmall,
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.0.dg, vertical: 2.0.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0.dg),
                  ),
                  border: Border.all(
                    color: kcBlackColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: viewModel.pickImage,
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 25,
                        )),
                    Expanded(
                      child: TextField(
                        controller: viewModel.commentController,
                        onSubmitted: (value) =>
                            viewModel.addComment(recipeModel.docId!),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add your Review',
                          hintStyle: globalTextStyle(
                              fontSize: 14.0.sp,
                              letterSpacing: -0.3,
                              color: kcBlackColor.withOpacity(0.4),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: viewModel.rating,
                      minRating: 1,
                      allowHalfRating: true,
                      itemSize: 15.0.dg,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) => viewModel.addRating(rating),
                    ),
                    if (viewModel.isEditingComment)
                      IconButton(
                        onPressed: viewModel.updateComment,
                        icon: const Icon(Icons.check, color: kcPrimaryColor),
                      )
                    else
                      IconButton(
                        onPressed: () =>
                            viewModel.addComment(recipeModel.docId!),
                        icon: const Icon(
                          Icons.send,
                          color: kcPrimaryColor,
                          size: 24,
                        ),
                      ),
                  ],
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: viewModel.seeCommentsAll,
                    child: !viewModel.seeComments
                        ? Text(
                            'See All Reviews',
                            style: globalTextStyle(
                                color: kcPrimaryColor,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500),
                          )
                        : Text(
                            'Hide Reviews',
                            style: globalTextStyle(
                                color: kcPrimaryColor,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500),
                          )),
              ),
              if (viewModel.seeComments)
                Column(
                  children: [
                    ...createCommentWidgets(viewModel),
                    if (viewModel.commentsList.isEmpty)
                      const Center(
                        child: Text(
                          'No comments yet',
                        ),
                      ),
                  ],
                )
              else
                const SizedBox(),
              const Divider(),
            ],
          )
        : Container();
  }
}
