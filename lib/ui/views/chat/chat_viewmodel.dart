import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/messages_model.dart';

class ChatViewModel extends BaseViewModel {
  List<MessageModel> messages = [];
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final _navigationLoactor = locator<NavigationService>();
  XFile? selectedImageFile;

 final messageController=TextEditingController();
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      selectedImageFile = pickedFile;

      // addMessage(
      //   MessageModel(
      //     image: pickedFile.path, content: 'Hi Hafsa Here', receiverId: '1234', senderId: '4321', timestamp: DateTime.now(), type: '',
      //   ),
      // );
    }
  }

  void sendMessage() async{
    if (messageController.text.isNotEmpty) {
      // var pickedFile = await ImagePicker().pickImage(source: selectedImageFile!.path);

      addMessage(
        MessageModel(
           image: selectedImageFile?.path ?? '', content: messageController.text, receiverId: '1234', senderId: userDetails!.uid ?? '', timestamp: DateTime.now(), type: '',
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

  void addMessage(MessageModel message) {
    messages.add(message);
    notifyListeners();
    rebuildUi();
  }

  void moveBack() {
    _navigationLoactor.back();
  }
}
