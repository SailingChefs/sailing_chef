import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/message_model.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:stacked/stacked.dart';

class ConversationService with ListenableServiceMixin {
  final _userService = locator<UserServices>();

  Future<String> createOrUpdateConversation(
      ConversationModel conversation) async {
    // final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference conversationsCollection =
        firebasestore.collection('conversations');

    var conversationId = ''; // Initialize with a default value

    try {
      // Sort users to ensure consistent order for comparison
      final sortedUsers = List<String>.of(conversation.users)..sort();
      final participantsFilter = sortedUsers.join(',');

      // Check for existing conversation
      final existingConversations = await conversationsCollection
          .where('sortedParticipants', isEqualTo: participantsFilter)
          .limit(1)
          .get();

      if (existingConversations.docs.isNotEmpty) {
        // Conversation already exists
        conversationId = existingConversations.docs.first.id;
        log('Existing conversation ID: $conversationId');
      } else {
        // No existing conversation found, create a new one
        final docRef = await conversationsCollection.add(conversation.toJson()
          ..['sortedParticipants'] =
              participantsFilter); // Include sorted list as a string for easier matching
        conversationId = docRef.id;

        // Optionally, update the conversation to include its own ID if needed
        await docRef.update({'uid': conversationId});
        log('New conversation created with ID: $conversationId');
      }

      return conversationId;
    } catch (error) {
      log('Error managing conversation: $error');
      return conversationId;
    }
  }

  Stream<List<ConversationModel>> getConversations() {
    log(FirebaseAuth.instance.currentUser!.uid);
    return firebasestore
        .collection('conversations')
        .where('users', arrayContains: firebaseAuth.currentUser!.uid)
        .snapshots()
        .asyncMap((QuerySnapshot querySnapshot) async {
      final conversations = <ConversationModel>[];
      for (final doc in querySnapshot.docs) {
        final users = List<String>.from(doc.get('users') as List<dynamic>);
        final otherUserId =
            users.firstWhere((id) => id != firebaseAuth.currentUser!.uid);
        final otherUser = await _userService.fetchUserByUID(otherUserId);
        conversations.add(ConversationModel.fromDocument(doc, otherUser));
      }
      return conversations;
    }).handleError((error) {
      return <ConversationModel>[];
    });
  }

  // Stream<List<ConversationModel>> getConversations() {
  //   log(currentUserUid);
  //   return _firestore
  //       .collection('conversations')
  //       .where('users', arrayContains: currentUserUid)
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) {
  //     List<ConversationModel> conversations = [];
  //     for (var doc in querySnapshot.docs) {
  //       conversations.add(ConversationModel.fromDocument(doc));
  //     }
  //     // log('Conversations for user $currentUserUid: $conversations');
  //     return conversations;
  //   }).handleError((error) {
  //     log('Error getting conversations for user $currentUserUid: $error');
  //     return [];
  //   });
  // }

// Stream<Future<List<ConversationModel>>> setConversations(){
//   return  FirebaseFirestore.instance
//       .collection('conversations')
//       .where('users', arrayContains: currentUserUid)
//       .snapshots()
//       .map((QuerySnapshot querySnapshot) async {
//     List<ConversationModel> conversations = [];

//     for (var doc in querySnapshot.docs) {
//       ConversationModel conversation = ConversationModel.fromDocument(doc);

//       QuerySnapshot messageSnapshot = await doc.reference
//           .collection('messages')
//           .orderBy('timestamp', descending: true)
//           .limit(1)
//           .get();

//       if (messageSnapshot.docs.isNotEmpty) {
//         DocumentSnapshot latestMessageDoc = messageSnapshot.docs.first;
//         MessageModel latestMessage = MessageModel.fromSnapshot(latestMessageDoc);
//         conversation.latestMessage = latestMessage.content;
//       } else {
//         conversation.latestMessage = '';
//       }

//       conversations.add(conversation);
//     }

//     return conversations;
//   }).handleError((error) {
//     log('Error getting conversations for user $currentUserUid: $error');
//     return [];
//   });
// }

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
        final conversationUserIds =
            List<String>.from(doc['users'] as List<dynamic>);
        conversationUserIds.sort();
        if (const ListEquality<String>().equals(userIds, conversationUserIds)) {
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

  Future<void> sendMessage(MessageModel message, String conversationId,
      {String? imageUrl, String? file}) async {
    final CollectionReference conversationsCollection =
        firebasestore.collection('conversations');
    final CollectionReference messagesCollection =
        conversationsCollection.doc(conversationId).collection('messages');

    if (imageUrl != null) {
      message.content = imageUrl;
    }

    if (file != null) {
      message.content = file;
    }

    try {
      // Add the message to the messages subcollection
      await messagesCollection.add(message.toMap());

      // Update the parent conversation document with the latest message info
      await conversationsCollection.doc(conversationId).update({
        'latestMessage': message.content,
        'latestMessageTime': FieldValue.serverTimestamp(),
        'latestMessageType': message.type,
      });
    } catch (error) {
      log('Error sending message: $error');
    }
  }

  Future<String> uploadImage(File imageFile, String fileName) async {
    try {
      final ref = firebaseStorage.ref().child('conversationImages/$fileName');

      final uploadTask = ref.putFile(imageFile);

      final taskSnapshot = await uploadTask;
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      showToast(message: 'Error uploading image: $e');
      return '';
    }
  }

  int? lastIndex;
  Stream<List<MessageModel>> getMessages(String conversationId) async* {
    try {
      EasyLoading.show();
      final CollectionReference messagesCollection = firebasestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages');
      final orderedQuery =
          messagesCollection.orderBy('timestamp', descending: false);

      final snapshots = orderedQuery.snapshots();

      await for (final snapshot in snapshots) {
        log('Loaded docs: ${snapshot.docs.length}');
        final messages = List<MessageModel>.empty(growable: true);

        for (final doc in snapshot.docs) {
          try {
            messages.add(MessageModel.fromSnapshot(doc));
          } catch (e, stack) {
            log('Error parsing document(${doc.id}): $e\n$stack');
          }
        }
        EasyLoading.dismiss();
        yield messages;
      }
    } catch (e, stack) {
      EasyLoading.dismiss();
      log('Error getting messages: $e\n$stack');
      yield []; // Yield an empty list if there's an error
    }
  }
}
