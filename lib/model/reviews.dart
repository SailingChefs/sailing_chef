import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewsModel {
  String id;
  String userId;
  String userName;
  String userImageUrl;
  String pindropId;
  String? feedback;
  Timestamp timestamp;
  double? rating;

  ReviewsModel({
    required this.userId,
    required this.userName,
    required this.userImageUrl,
    required this.pindropId,
    required this.feedback,
    required this.timestamp,
    this.id = '',
    this.rating,
  });

  factory ReviewsModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return ReviewsModel(
      id: snapshot.id,
      userId: (data['userId'] as String?) ?? '',
      pindropId: (data['pinId'] as String?) ?? '',
      feedback: data['feedback'] as String?,
      userName: (data['userName'] as String?) ?? '',
      userImageUrl: (data['userImageUrl'] as String?) ?? '',
      timestamp: data['created_time'] is Timestamp
          ? data['created_time'] as Timestamp
          : Timestamp.now(),
      rating: (data['rating'] != null)
          ? double.tryParse(data['rating'].toString()) ?? 0.0
          : 0.0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'pinId': pindropId,
      'feedback': feedback,
      'userName': userName,
      'userImageUrl': userImageUrl,
      'timestamp': timestamp,
      'rating': rating,
    };
  }
}
