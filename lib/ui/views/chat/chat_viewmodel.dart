import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/messages_model.dart';

class ChatViewModel extends BaseViewModel {
  List<MessageModel> messages = [];
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      // addMessage(
      //   MessageModel(
      //     image: pickedFile.path,



      //   ),
     // );
    }
  }

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      // addMessage(
      //   // MessageModel(
      //   //   text: text,
      //   //   isMe: true,
      //   // ),
      // );

      textController.clear();

      // Scroll to the bottom of the list after sending a message
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void addMessage(MessageModel message) {
    messages.add(message);
    notifyListeners();
    rebuildUi();
  }
}
