import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String id;
  String userId;
  String userName;
  String userImageUrl; // Storing only user ID
  String recipeId;
  String? content;
  Timestamp timestamp;
  List<String>? imageUrl;
  double? rating;

  CommentModel({
    required this.userId,
    required this.userName,
    required this.userImageUrl,
    required this.recipeId,
    required this.content,
    required this.timestamp,
    this.id = '',
    this.imageUrl,
    this.rating,
  });

  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return CommentModel(
      id: snapshot.id,
      userId: (data['userId'] as String?) ?? '',
      recipeId: (data['recipeId'] as String?) ?? '',
      content: data['content'] as String?,
      userName: (data['userName'] as String?) ?? '',
      userImageUrl: (data['userImageUrl'] as String?) ?? '',
      timestamp: (data['timestamp'] as Timestamp?) ?? Timestamp.now(),
      imageUrl: List<String>.from((data['imageUrl'] as List<dynamic>?) ?? const []),
      rating: data['rating'] != null ? (double.tryParse(data['rating'].toString()) ?? 0.0) : 0.0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'recipeId': recipeId,
      'content': content,
      'userName': userName,
      'userImageUrl': userImageUrl,
      'timestamp': timestamp,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }
}

// class CommentModel {
//   String id;
//   UserModel user;
//   String recipeId;
//   String content;
//   DateTime timestamp;
//   List<String>? imageUrl; // Optional image URL
//   double? rating; // Rating associated with the comment

//   CommentModel({
//     this.id = '',
//     required this.user,
//     required this.recipeId,
//     required this.content,
//     required this.timestamp,
//     this.imageUrl,
//     required this.rating,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'user': user.toJson(),
//       'recipeId': recipeId,
//       'content': content,
//       'timestamp': timestamp.toIso8601String(),
//       'imageUrl': imageUrl,
//       'rating': rating,
//     };
//   }

//   factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return CommentModel(
//       id: snapshot.id,  // Typically, the document ID is not inside the document data
//       user: UserModel.fromSnapshot(snapshot['user']),
//       recipeId: data['recipeId'] ?? '',
//       content: data['content'] ?? '',
//       timestamp: data['timestamp']?.toDate() ?? DateTime.now(),  // Handling Timestamp conversion
//       imageUrl: data['imageUrl'],
//       rating: (data['rating'] != null) ? double.tryParse(data['rating'].toString()) : 0.0,
//     );
//   }
// }
