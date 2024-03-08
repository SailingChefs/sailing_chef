import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/chat_model.dart';

class ChatViewModel extends BaseViewModel {
  List<ChatMessageModel> messages = [];
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      addMessage(
        ChatMessageModel(
          text: '', // You might want to provide a caption for the image
          image: FileImage(File(pickedFile.path)),
          isMe: true,
        ),
      );
    }
  }

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      addMessage(
        ChatMessageModel(
          text: text,
          isMe: true,
        ),
      );

      textController.clear();

      // Scroll to the bottom of the list after sending a message
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void addMessage(ChatMessageModel message) {
    messages.add(message);
    notifyListeners();
    rebuildUi();
  }
}
