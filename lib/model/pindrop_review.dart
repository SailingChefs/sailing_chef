import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String uid;
  final String userId;
  final double rating;
  final String reviewText;

  const Review(
      {required this.userId, required this.uid, required this.rating, required this.reviewText});

  factory Review.fromFirestore(DocumentSnapshot doc) {
    return Review(
      uid: doc.id,
      rating: (doc['rating'] as num).toDouble(),
      reviewText: doc['review_text'] as String,
      userId: doc['user_id'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'rating': rating,
      'review_text': reviewText,
      'user_id': userId,
      'created_time': Timestamp.now(),
    };
  }
}
