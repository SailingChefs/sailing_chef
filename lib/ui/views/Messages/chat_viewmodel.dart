import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/message_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';

class ChatViewModel extends StreamViewModel<List<MessageModel>> {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final _navigationLoactor = locator<NavigationService>();
  final _conversationService = locator<ConversationService>();
  final String convoId;
  XFile? selectedImageFile;
  List<MessageModel> messages = List.empty(growable: true);

  ChatViewModel({required this.convoId});
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
          ),
          conversationId);
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      textController.clear();
    }
  }

  void addMessage(MessageModel message, String conversationId) {
    _conversationService.sendMessage(message, conversationId);
    textController.clear();
    notifyListeners();
    rebuildUi();
  }

  void moveBack() {
    _navigationLoactor.back();
  }

  @override
  void onData(data) {
    if (data == null) return;
    messages = data;
    textController.clear();
    rebuildUi();
    super.onData(data);
  }

  @override
  Stream<List<MessageModel>> get stream =>
      _conversationService.getMessages(convoId);
}
