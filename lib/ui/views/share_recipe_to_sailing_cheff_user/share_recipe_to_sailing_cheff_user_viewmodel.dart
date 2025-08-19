import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/message_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class ShareRecipeToSailingCheffUserViewModel extends BaseViewModel {
  final _serviceConversations = locator<ConversationService>();

  bool _isProcessing = false; // Add a flag

  Future<String?> getChatRoom(
    UserModel chef,
  ) async {
    if (_isProcessing) return null; // If already processing, return immediately

    _isProcessing = true; // Set flag to indicate processing has started

    notifyListeners();

    try {
      final conversationModel = ConversationModel(
        latestMessage: '',
        users: [
          FirebaseAuth.instance.currentUser!.uid,
          chef.uid!,
        ],
        latestMessageType: 'text',
        latestMessageTime: DateTime.now(),
        lastActive: DateTime.now(),
        uid: '',
      );
      final conversationId =
          await _serviceConversations.createOrUpdateConversation(conversationModel);
      log('conversationId: $conversationId');

      return conversationId;
      // _navigationService.navigateToChatView(
      //     messageFromCource: '',
      //     receiver: chef,
      //     conversationId: conversationId);
    } catch (e) {
      log('Error: $e');
    } finally {
      _isProcessing = false; // Reset flag after processing is done
      notifyListeners();
    }
    return null;
  }

  Future<void> addMessage(MessageModel message, String conversationId) async {
    await _serviceConversations.sendMessage(message, conversationId);

    rebuildUi();
  }

  void sendMessage(receiverId, conversationId, Uri content) {
    addMessage(
        MessageModel(
          content: content.toString(),
          receiverId: receiverId,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          timestamp: DateTime.now(),
          type: 'String',
          fileName: '',
        ),
        conversationId);
    rebuildUi();
  }

  Future<void> sendLinkToSailingChefUser(UserModel user, Uri dynamicLink) async {
    final chatroomID = await getChatRoom(user);

    if (chatroomID != null) {
      sendMessage(user.uid, chatroomID, dynamicLink);
    }
    showToast(message: 'Link has been Send');
  }

  Future<List<UserModel>> fetchChefDocuments() async {
    final users = <UserModel>[];

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          // .where(
          //   'user_role',
          //   isEqualTo: 'chef',
          // )
          .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
          // .orderBy('created_at', descending: true)
          .get();
      for (final doc in querySnapshot.docs) {
        // UserModel? currUser = await _userService
        //     .fetchUserByUID(firebaseAuth.currentUser!.uid);
        final user = UserModel.fromSnapshot(doc);

        // int recipeCount = await FirebaseFirestore.instance
        //     .collection('recipes')
        //     .where('uid', isEqualTo: user.uid)
        //     .get()
        //     .then((value) => value.size);

        // user.recipeCount = recipeCount;

        if (!userDetails!.blockedAccounts!.contains(user.uid)) {
          users.add(user);
        }
      }

      return users;
    } catch (error) {
      // Handle any errors

      return users; // Return an empty list in case of error
    }
  }

  List<UserModel> allusers = [];

  Future<void> onViewModelReady() async {
    allusers = await fetchChefDocuments();

    notifyListeners();
    rebuildUi();
  }
}
