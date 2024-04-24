import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/custom_comments_list.dart';

class CommentsDetailsScreen
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  const CommentsDetailsScreen({super.key});
  List<Widget> createCommentWidgets(SavedRecipeDetailsViewModel viewModel) {
    List<CommentModel> comment = viewModel.fetchComment;
    return [
      for (var comment in comment)
        CustomListTileComments(
          name: comment.userName,
          date: comment.timestamp,
          description: comment.content,
          image: comment.userImageUrl,
          ratingImages: comment.imageUrl!,
          rating: comment.rating!,
        ),
    ];
  }

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ratings & Comments',
              style: globalTextStyle(
                fontSize: 17.0.sp,
                color: kcBlackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'View All',
              style: globalTextStyle(
                color: kcPrimaryColor,
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        viewModel.fetchComment.isEmpty
            ? Text('No comments yet',
                style: globalTextStyle(
                    fontSize: 14.0.sp,
                    color: kcBlackColor,
                    fontWeight: FontWeight.w300))
            : Container(),
        ...createCommentWidgets(viewModel),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tap to Rate:',
              style: globalTextStyle(
                fontSize: 12.sp,
                color: kcBlackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            RatingBar.builder(
              initialRating: viewModel.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20.0.dg,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color(0xFF2E3E5C),
              ),
              onRatingUpdate: (rating) {
                viewModel.addRating(rating);
              },
            ),
          ],
        )
      ],
    );
  }
}
