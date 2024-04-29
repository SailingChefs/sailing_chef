import 'dart:developer';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/user_services.dart';

class ChatListViewModel extends BaseViewModel {
  final _convoService = locator<ConversationService>();
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();
  final _userService = locator<UserServices>();

  List<UserModel>? chatUsers = [];

  Stream<List<ConversationModel>> getConversation() {
    Stream<List<ConversationModel>> conversations =
        _convoService.getConversations();
    log('conversations from chat_list_viewmodel: $conversations');

    return conversations;
  }

  String twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    } else {
      return '0$n';
    }
  }

  void toChatScreen(ConversationModel selectedConversation) async {
    try {
      bool check = false;

      if (firebaseAuth.currentUser!.uid == selectedConversation.users[0]) {
        check = await _userService.doesUserExist(selectedConversation.users[1]);
        if (check) {
          UserModel user =
              await _userService.fetchUserByUID(selectedConversation.users[1]);
          _navigationService.navigateToChatView(
              receiver: user, conversationId: selectedConversation.uid);
        }
      } else if (firebaseAuth.currentUser!.uid ==
          selectedConversation.users[1]) {
        check = await _userService.doesUserExist(selectedConversation.users[0]);
        if (check) {
          UserModel user =
              await _userService.fetchUserByUID(selectedConversation.users[0]);
          _navigationService.navigateToChatView(
              receiver: user, conversationId: selectedConversation.uid);
        }
      }
      log('chefList: $check');
    } catch (e) {
      log('chefList: $e');
    }
  }

  // void toChatScreen(ConversationModel selectedConversation) {
  //   // log('cheflist: fuction ${chefList!.length} ${selectedConversation.users.length}');
  //   try {
  //     for (var chef in chatUsers!) {
  //       log('cheflist: ${selectedConversation.users[0]}');
  //       log('cheflist: ${selectedConversation.users[1]}');
  //       log('cheflist: ${chef.uid}');
  //       if (chef.uid == selectedConversation.users[0] &&
  //           firebaseAuth.currentUser!.uid != chef.uid) {
  //         _navigationService.navigateToChatView(
  //             receiver: chef, conversationId: selectedConversation.uid);
  //       }
  //       if (chef.uid == selectedConversation.users[1] &&
  //           firebaseAuth.currentUser!.uid != chef.uid) {
  //         _navigationService.navigateToChatView(
  //             receiver: chef, conversationId: selectedConversation.uid);
  //       }
  //     }
  //   } catch (e) {
  //     log('cheflist: $e');
  //   }
  // }

  void onViewModelReady() async {
    setBusy(true);
    chatUsers = await _chefService.fetchChefDocuments();
    // getConversation();
    setBusy(false);
  }
}
