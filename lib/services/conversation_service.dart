import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/message_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class ConversationService {
  final _userService = locator<UserServices>();

  Future<String> createOrUpdateConversation(
      ConversationModel conversation) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference conversationsCollection =
        db.collection('conversations');

    String conversationId = ''; // Initialize with a default value

    try {
      // Sort users to ensure consistent order for comparison
      var sortedUsers = List<String>.from(conversation.users)..sort();
      var participantsFilter = sortedUsers.join(",");

      // Check for existing conversation
      QuerySnapshot existingConversations = await conversationsCollection
          .where('sortedParticipants', isEqualTo: participantsFilter)
          .limit(1)
          .get();

      if (existingConversations.docs.isNotEmpty) {
        // Conversation already exists
        conversationId = existingConversations.docs.first.id;
        log('Existing conversation ID: $conversationId');
      } else {
        // No existing conversation found, create a new one
        DocumentReference docRef = await conversationsCollection.add(conversation
            .toJson()
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
      return conversationId; // Return the initialized but possibly still empty ID
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String currentUserUid = firebaseAuth.currentUser!.uid;

  Stream<List<ConversationModel>> getConversations() {
    log(FirebaseAuth.instance.currentUser!.uid);
    return _firestore
        .collection('conversations')
        .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .asyncMap((QuerySnapshot querySnapshot) async {
      List<ConversationModel> conversations = [];
      for (var doc in querySnapshot.docs) {
        List<String> users = List<String>.from(doc.get('users'));
        String otherUserId = users
            .firstWhere((id) => id != FirebaseAuth.instance.currentUser!.uid);
        UserModel? otherUser = await _userService.fetchUserByUID(otherUserId);
        conversations.add(ConversationModel.fromDocument(doc, otherUser));
      }
      return conversations;
    }).handleError((error) {
      log('Error getting conversations for user $currentUserUid: $error');
      return [];
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

  Future<void> sendMessage(MessageModel message, String conversationId,
      {String? imageUrl, String? file}) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference conversationsCollection =
        db.collection('conversations');
    final CollectionReference messagesCollection =
        conversationsCollection.doc(conversationId).collection('messages');

    // message.type = message.content.runtimeType.toString();

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
        'latestMessageType': message.runtimeType,
      });
    } catch (error) {
      log('Error sending message: $error');
    }
  }

  Future<String> uploadImage(File imageFile, String fileName) async {
    try {
      


      EasyLoading.show();

      
      Reference ref =
          firebaseStorage.ref().child('conversationImages/$fileName');

      UploadTask uploadTask = ref.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

     

      EasyLoading.dismiss();


      return downloadUrl;
      
    } catch (e) {


      EasyLoading.dismiss();

      showToast(message: 'Error uploading image: $e');
      return '';
    }
  }
  int? lastIndex;
  Stream<List<MessageModel>> getMessages(String conversationId) async* {
    try {
      EasyLoading.show();
      final CollectionReference messagesCollection = FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationId)
          .collection('messages');
      final Query orderedQuery =
          messagesCollection.orderBy('timestamp', descending: false);

      final snapshots = orderedQuery.snapshots();

      await for (final snapshot in snapshots) {
        log("Loaded docs: ${snapshot.docs.length}");
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
