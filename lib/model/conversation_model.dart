import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConversationModel {
  String name;
  List<String> imageTitle; 
  bool isOnline;
  String lastActive;
  String latestMessage;
  String latestMessageTime;
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
      name: doc['Name'],
      imageTitle: List<String>.from(doc['imageTitle']),
      isOnline: doc['isOnline'],
      lastActive: doc['lastActive'],
      latestMessage: doc['latestMessage'],
      latestMessageTime: doc['latestMessageTime'],
      latestMessageType: doc['latestMessageType'],
      uid: doc.id,
      users: List<String>.from(doc['users']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'imageTitle': List<dynamic>.from(imageTitle),
      'isOnline': isOnline,
      'lastActive': lastActive,
      'latestMessage': latestMessage,
      'latestMessageTime': DateFormat.jm().format(latestMessageTime as DateTime).toString(),
      'latestMessageType': latestMessageType,
      'uid': uid,
      'users': List<dynamic>.from(users),
    };
  }
}