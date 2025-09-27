import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/model/user_model.dart';

class ConversationModel {
  DateTime lastActive;
  String latestMessage;
  DateTime latestMessageTime;
  String latestMessageType;
  String uid;
  List<String> users;
  UserModel? user;

  ConversationModel({
    required this.lastActive,
    required this.latestMessage,
    required this.latestMessageTime,
    required this.latestMessageType,
    required this.uid,
    required this.users,
    this.user,
  });
  factory ConversationModel.fromDocument(DocumentSnapshot doc, UserModel? otherUser) {
    return ConversationModel(
      lastActive: (doc.get('lastActive') as Timestamp).toDate(),
      latestMessage: doc.get('latestMessage') as String,
      latestMessageTime: (doc.get('latestMessageTime') as Timestamp).toDate(),
      latestMessageType: doc.get('latestMessageType') as String,
      uid: doc.id,
      users: List<String>.from(doc.get('users') as List<dynamic>),
      user: otherUser,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastActive': lastActive,
      'latestMessage': latestMessage,
      'latestMessageTime': latestMessageTime,
      'latestMessageType': latestMessageType,
      'uid': uid,
      'users': List<dynamic>.of(users),
    };
  }
}
