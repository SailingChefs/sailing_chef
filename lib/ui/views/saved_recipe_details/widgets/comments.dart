
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/custom_comments_list.dart';

class CommentsDetailsScreen
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  const CommentsDetailsScreen({super.key, required this.recipeModel});
 List<Widget> createCommentWidgets(SavedRecipeDetailsViewModel viewModel) {
    // recipeModel.comment = viewModel.commentService.comments;
    viewModel.commentsList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    List<CustomListTileComments> commentTiles = [];
    if (viewModel.commentsList.isNotEmpty) {
        List<CommentModel> comments = viewModel.commentsList!;
        commentTiles = comments.map((comment) => CustomListTileComments(
          name: comment.userName,
          date: comment.timestamp,
          description: comment.content,
          image: comment.userImageUrl,
          ratingImages: comment.imageUrl ?? [], // use an empty list if imageUrl is null
          rating: comment.rating ?? 0, // use 0 if rating is null
        )).toList();
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
    return Column(
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
                  viewModel.calculateAverageRating(viewModel.commentsList),
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
        if (viewModel.images.isNotEmpty) _buildImagePreview(viewModel),
        verticalSpaceSmall,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0.dg, vertical: 2.0.dg),
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
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 15.0.dg,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) => viewModel.addRating(rating),
              ),
            ],
          ),
        ),
        Center(
          child: TextButton(
              onPressed: viewModel.seeCommentsAll,
              child: Text(
                'See All Reviews',
                style: globalTextStyle(
                    color: kcPrimaryColor,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w500),
              )),
        ),

        viewModel.seeComments
            ? Column(
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
            : const SizedBox(),
        const Divider(),
      ],
    );
  }
}
