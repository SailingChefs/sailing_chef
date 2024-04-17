import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  String name;
  List<String> imageTitle; 
  bool isOnline;
  DateTime lastActive;
  String latestMessage;
  DateTime latestMessageTime;
  String latestMessageType;
  String uid;
  List<String> users;

  ConversationModel({
    required this.name,
    required this.imageTitle,
    required this.isOnline,
    required this.lastActive,
    required this.latestMessage,
    required this.latestMessageTime,
    required this.latestMessageType,
    required this.uid,
    required this.users,
  });

  factory ConversationModel.fromDocument(DocumentSnapshot doc) {
    return ConversationModel(
      name: doc.get('Name'),
      imageTitle: List<String>.from(doc.get('imageTitle')),
      isOnline: doc.get('isOnline'),
      lastActive: (doc.get('lastActive') as Timestamp).toDate(),
      latestMessage: doc.get('latestMessage'),
      latestMessageTime: (doc.get('latestMessageTime') as Timestamp).toDate(),
      latestMessageType: doc.get('latestMessageType'),
      uid: doc.id,
      users: List<String>.from(doc.get('users')),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'imageTitle': List<dynamic>.from(imageTitle),
      'isOnline': isOnline,
      'lastActive': lastActive,
      'latestMessage': latestMessage,
      'latestMessageTime': latestMessageTime,
      'latestMessageType': latestMessageType,
      'uid': uid,
      'users': List<dynamic>.from(users),
    };
  }
}