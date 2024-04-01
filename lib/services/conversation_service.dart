import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/messages_model.dart';

class ConversationService {
  Future<void> createConversation(ConversationModel conversation) async {
    try {
      final CollectionReference conversationsCollection =
          firebasestore.collection('conversations');

      await conversationsCollection.add(conversation.toJson());
    } catch (error) {
      log('Error creating conversation: $error');
      // Handle error appropriately
    }
  }

  Future<List<ConversationModel>> fetchConversations(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await firebasestore
          .collection('conversations')
          .where('users', arrayContains: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => ConversationModel.fromSnapshot(doc))
          .toList();
    } catch (error) {
      log('Error fetching conversations: $error');
      // Handle error appropriately
      return [];
    }
  }

  Future<String?> checkConversationExistence(List<String> userIds) async {
    try {
      // Sort user IDs to ensure consistent order
      userIds.sort();

      final QuerySnapshot querySnapshot = await firebasestore
          .collection('conversations')
          .where('users', arrayContainsAny: userIds)
          .get();

      // Check if all user IDs are present in any conversation
      for (final doc in querySnapshot.docs) {
        final conversationUserIds = List<String>.from(doc['users']);
        conversationUserIds.sort();
        if (const ListEquality().equals(userIds, conversationUserIds)) {
          return doc.id;
        }
      }

      // Return null if no conversation is found
      return null;
    } catch (error) {
      log('Error checking conversation existence: $error');
      // Handle error appropriately
      return null;
    }
  }

  final CollectionReference _conversationsCollection =
      firebasestore.collection('conversations');

  Future<void> sendMessage(String conversationId, MessageModel message) async {
    try {
      final CollectionReference messagesCollection =
          _conversationsCollection.doc(conversationId).collection('messages');
      await messagesCollection.add(message);
    } catch (error) {
      log('Error sending message: $error');
      // Handle error appropriately
    }
  }

  Stream<List<MessageModel>> getMessages(String conversationId) {
    final CollectionReference messagesCollection =
        _conversationsCollection.doc(conversationId).collection('messages');
    return messagesCollection.orderBy('timestamp').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => MessageModel.fromSnapshot(doc)).toList());
  }
}
