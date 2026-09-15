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

    // Every field used to be a hard `as String`/`as Timestamp` cast, so a
    // legacy message doc missing any one of them (e.g. written before
    // fileName existed) threw here -- caught by the per-document try/catch
    // in ConversationService.getMessages, which just logs and drops the
    // message with no indication to either participant that anything is
    // missing from the conversation. Defaulting missing fields keeps those
    // messages visible instead of silently disappearing.
    return MessageModel(
      content: data['content'] as String? ?? '',
      receiverId: data['receiverId'] as String? ?? '',
      senderId: data['senderId'] as String? ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      type: data['type'] as String? ?? 'String',
      fileName: data['fileName'] as String? ?? '',
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      content: map['content'] as String,
      receiverId: map['receiverId'] as String,
      senderId: map['senderId'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      type: map['type'] as String,
      fileName: map['fileName'] as String,
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
