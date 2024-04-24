import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String content;
  final String receiverId;
  final String senderId;
  final DateTime timestamp;
  String type;

  MessageModel({
    required this.content,
    required this.receiverId,
    required this.senderId,
    required this.timestamp,
    required this.type,
  });

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      content: data['content'],
      receiverId: data['receiverId'],
      senderId: data['senderId'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      type: data['type'],
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      content: map['content'],
      receiverId: map['receiverId'],
      senderId: map['senderId'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'receiverId': receiverId,
      'senderId': senderId,
      'timestamp': Timestamp.fromDate(timestamp),
      'type': type,
    };
  }
}
