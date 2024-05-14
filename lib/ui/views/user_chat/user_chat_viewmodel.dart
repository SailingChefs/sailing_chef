import 'dart:io';

// import 'package:chatview/chatview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';

import '../../../../model/message_model.dart';

class UserChatViewModel extends BaseViewModel {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final _navigationLoactor = locator<NavigationService>();
  final _conversationService = locator<ConversationService>();
  final String convoId;
  XFile? selectedImageFile;
  UserChatViewModel({required this.convoId});

  List<MessageModel> messages = List.empty(growable: true);

  Stream<List<ConversationModel>> getConversation() {
    Stream<List<ConversationModel>> conversations =
        _conversationService.getConversations();

    return conversations;
  }

  final messageController = TextEditingController();

  Future<void> getImage(
      ImageSource source, String receiverId, conversationId) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      selectedImageFile = pickedFile;
      String imageUrl = await _conversationService.uploadImage(
          File(selectedImageFile!.path), selectedImageFile!.name);

      addMessage(
          MessageModel(
            content: imageUrl,
            receiverId: receiverId,
            senderId: FirebaseAuth.instance.currentUser!.uid,
            timestamp: DateTime.now(),
            type: 'image',
            fileName: '',
          ),
          conversationId);

      selectedImageFile = null;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendMessage(receiverId, conversationId) async {
    if (messageController.text.isNotEmpty) {
      addMessage(
          MessageModel(
            content: messageController.text,
            receiverId: receiverId,
            senderId: FirebaseAuth.instance.currentUser!.uid,
            timestamp: DateTime.now(),
            type: 'String',
            fileName: '',
          ),
          conversationId);
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      messageController.clear();
    }
  }

  void addMessage(MessageModel message, String conversationId) async {
    await _conversationService.sendMessage(message, conversationId);
    messageController.clear();
    notifyListeners();
    rebuildUi();
  }

  void moveBack() {
    _navigationLoactor.back();
  }

  void onData(data) {
    if (data == null) return;
    messages = data;
    textController.clear();
    rebuildUi();
    // super.onData(data);
  }

  // @override
  // Stream<List<Message>> get stream =>
  //     _conversationService.getMessages(convoId);

  // final currentUser = ChatUser(
  //   id: FirebaseAuth.instance.currentUser!.uid,
  //   name: userDetails!.displayName!,
  //   profilePhoto: userDetails!.displayPicture!,
  // );
  // final chatController = ChatController(
  //   initialMessageList: List.empty(growable: true),
  //   scrollController: ScrollController(),
  //   chatUsers: [
  //     ChatUser(
  //       id: '2',
  //       name: 'Simform',
  //       profilePhoto: 'https://picsum.photos/200',
  //     ),
  //     ChatUser(
  //       id: '3',
  //       name: 'Jhon',
  //       profilePhoto: 'https://picsum.photos/200',
  //     ),
  //     ChatUser(
  //       id: '4',
  //       name: 'Mike',
  //       profilePhoto: 'https://picsum.photos/200',
  //     ),
  //     ChatUser(
  //       id: '5',
  //       name: 'Rich',
  //       profilePhoto: 'https://picsum.photos/200',
  //     ),
  //   ],
  // );
}
