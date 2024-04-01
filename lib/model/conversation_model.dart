import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String latestMessage;
  final DateTime latestMessageTime;
  final String latestMessageType;
  final List<String> users;

  ConversationModel({
    required this.latestMessage,
    required this.latestMessageTime,
    required this.latestMessageType,
    required this.users,
  });

  factory ConversationModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ConversationModel(
      latestMessage: data['latestMessage'] ?? '',
      latestMessageTime: DateTime.fromMillisecondsSinceEpoch(
        data['latestMessageTime'],
      ),
      latestMessageType: data['latestMessageType'] ?? '',
      users: List<String>.from(data['users'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latestMessage': latestMessage,
      'latestMessageTime': latestMessageTime.millisecondsSinceEpoch,
      'latestMessageType': latestMessageType,
      'users': users,
    };
  }
}
