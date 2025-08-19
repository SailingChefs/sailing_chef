import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String content;
  final String receiverId;
  final String senderId;
  final DateTime timestamp;
  String type;
  String fileName;
  MessageModel({
    required this.content,
    required this.receiverId,
    required this.senderId,
    required this.timestamp,
    required this.type,
    required this.fileName,
  });

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;

    return MessageModel(
      content: data['content'],
      receiverId: data['receiverId'],
      senderId: data['senderId'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      type: data['type'],
      fileName: data['fileName'],
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      content: map['content'],
      receiverId: map['receiverId'],
      senderId: map['senderId'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      type: map['type'],
      fileName: map['fileName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'receiverId': receiverId,
      'senderId': senderId,
      'timestamp': Timestamp.fromDate(timestamp),
      'type': type,
      'fileName': fileName,
    };
  }
}
