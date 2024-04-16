import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/message_model.dart';

class ConversationService {
  Future<String> createConversation(ConversationModel conversation) async {
    try {
      final CollectionReference conversationsCollection =
          FirebaseFirestore.instance.collection('conversations');

      DocumentReference docRef =
          await conversationsCollection.add(conversation.toJson());

      return docRef.id;
    } catch (error) {
      log('Error creating conversation: $error');
      // Handle error appropriately
      return ''; // or throw an error
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String currentUserUid = firebaseAuth.currentUser!.uid;

  Stream<List<ConversationModel>> getConversations() {
    log(currentUserUid);
    return _firestore
        .collection('conversations')
        .where('users', arrayContains: currentUserUid)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<ConversationModel> conversations = [];
      for (var doc in querySnapshot.docs) {
        conversations.add(ConversationModel.fromDocument(doc));
      }
      // log('Conversations for user $currentUserUid: $conversations');
      return conversations;
    }).handleError((error) {
      log('Error getting conversations for user $currentUserUid: $error');
      return [];
    });
  }

Stream<Future<List<ConversationModel>>> setConversations(){
  return  FirebaseFirestore.instance
      .collection('conversations')
      .where('users', arrayContains: currentUserUid)
      .snapshots()
      .map((QuerySnapshot querySnapshot) async {
    List<ConversationModel> conversations = [];

    for (var doc in querySnapshot.docs) {
      ConversationModel conversation = ConversationModel.fromDocument(doc);

      QuerySnapshot messageSnapshot = await doc.reference
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (messageSnapshot.docs.isNotEmpty) {
        DocumentSnapshot latestMessageDoc = messageSnapshot.docs.first;
        MessageModel latestMessage = MessageModel.fromSnapshot(latestMessageDoc);
        conversation.latestMessage = latestMessage.content;
      } else {
        conversation.latestMessage = ''; 
      }

      conversations.add(conversation);
    }

    return conversations;
  }).handleError((error) {
    log('Error getting conversations for user $currentUserUid: $error');
    return []; 
  });
}

  final CollectionReference _conversationsCollection =
      FirebaseFirestore.instance.collection('conversations');

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

  Future<void> sendMessage(MessageModel message, String conversationId) async {
    // String conversationId = await getConversationId(message);
    try {
      final CollectionReference messagesCollection =
          _conversationsCollection.doc(conversationId).collection('messages');
      await messagesCollection.add((message.toMap()));
    } catch (error) {
      log('Error sending message: $error');
    }
  }

  Stream<List<MessageModel>> getMessages(String conversationId)async*  {
    try {
      final CollectionReference messagesCollection = FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationId)
          .collection('messages');
      final Query orderedQuery = messagesCollection.orderBy('timestamp', descending: false);

      final snapshots = orderedQuery.snapshots();

      await for (final snapshot in snapshots) {
        log("Loaded docs: ${snapshot.docs.length}");
        final messages = List<MessageModel>.empty(growable: true);

        for(final doc in snapshot.docs){
          try{
            messages.add(MessageModel.fromSnapshot(doc));
            
          }catch(e,stack){
            log('Error parsing document(${doc.id}): $e\n$stack');
          }
        }

        yield messages;
      }
    } catch (e,stack) {
      log('Error getting messages: $e\n$stack');
      yield []; // Yield an empty list if there's an error
    }
  }
}
