import 'dart:developer';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/conversation_service.dart';

class ChatListViewModel extends BaseViewModel {
  final _convoService = locator<ConversationService>();
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();

  List<UserModel>? chefList = [];

  Stream<List<ConversationModel>> getConversation() {
    Stream<List<ConversationModel>> conversations =
        _convoService.getConversations();
    log('conversations from chat_list_viewmodel: $conversations');
    return conversations;
  }

  void toChatScreen(ConversationModel selectedConversation) {
   
    log('cheflist: fuction ${chefList!.length} ${selectedConversation.users.length}');
    try {
      for (var chef in chefList!) {
        log('cheflist: ${selectedConversation.users[0]}');
        log('cheflist: ${selectedConversation.users[1]}');
         log('cheflist: ${chef.uid}');
        if (chef.uid == selectedConversation.users[0] && firebaseAuth.currentUser!.uid != chef.uid) {
          _navigationService.navigateToChatView(receiver: chef, conversationId:selectedConversation.uid);
        }
        if (chef.uid == selectedConversation.users[1] && firebaseAuth.currentUser!.uid != chef.uid) {
          _navigationService.navigateToChatView(receiver: chef, conversationId:selectedConversation.uid);
        }
      }
    } catch (e) {
      log('cheflist: $e');
    }
  }

  void onViewModelReady() async {
    setBusy(true);
    chefList = await _chefService.fetchChefDocuments();
    setBusy(false);
  }
}
