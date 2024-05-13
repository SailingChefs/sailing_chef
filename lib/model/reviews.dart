import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews {
  String id;
  String userId;
  String userName;
  String userImageUrl;
  String pindropId;
  String? feedback;
  Timestamp timestamp;
  double? rating;

  Reviews({
    required this.userId,
    required this.userName,
    required this.userImageUrl,
    this.id = '',
    required this.pindropId,
    required this.feedback,
    required this.timestamp,
    this.rating,
  });

  factory Reviews.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Reviews(
      id: snapshot.id,
      userId: data['userId'],
      pindropId: data['pinId'] ?? '',
      feedback: data['feedback'] ?? '',
      userName: data['userName'] ?? '',
      userImageUrl: data['userImageUrl'] ?? '',
      timestamp: data['created_time'] ?? Timestamp.now(),
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
