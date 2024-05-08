import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String content;
  final String receiverId;
  final String sendBy;
  final DateTime createdAt;
  String messageType;
  final String id;

  MessageModel({
    required this.id,
    required this.content,
    required this.receiverId,
    required this.sendBy,
    required this.createdAt,
    required this.messageType,
  });

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      content: data['content'],
      id: snapshot.id,
      receiverId: data['receiverId'],
      sendBy: data['senderId'],
      createdAt: (data['timestamp'] as Timestamp).toDate(),
      messageType: data['type'],
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      content: map['content'],
      receiverId: map['receiverId'],
      sendBy: map['senderId'],
      createdAt: (map['timestamp'] as Timestamp).toDate(),
      messageType: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'receiverId': receiverId,
      'senderId': sendBy,
      'timestamp': Timestamp.fromDate(createdAt),
      'type': messageType,
    };
  }
}
