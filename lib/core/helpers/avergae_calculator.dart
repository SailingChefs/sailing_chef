import 'package:sailing_chefs/model/comment_model.dart';

double calculateAverageRating(List<CommentModel> comments) {
  if (comments.isEmpty) {
    return 0.0; // Return 0 if there are no comments
  }

  double totalRating = 0.0;

  // Calculate the total rating
  for (var comment in comments) {
    if (comment.rating != null) {
      totalRating += comment.rating!;
    }
  }

  // Calculate the average rating
  double averageRating = totalRating / comments.length;
  return averageRating;
}
