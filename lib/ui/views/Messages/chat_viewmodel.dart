import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  bool isAtTop = false;
  bool isImageSending = false;

  ChatViewModel({required this.convoId});

  void onViewModelReady() {
    scrollController.addListener(() {
      isAtTop = scrollController.offset <= kToolbarHeight;
      if (scrollController.position.pixels < 180) {
        isAtTop = true;
      }
      rebuildUi();
    });
    
  }

  bool _uploadingImage = false;
  bool _uploadingFile = false;

  bool get uploadingImage => _uploadingImage;
  bool get uploadingFile => _uploadingFile;

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
      _uploadingImage = true;
      rebuildUi();

      String imageUrl = await _conversationService.uploadImage(
          File(selectedImageFile!.path), selectedImageFile!.name);

      await addMessage(
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
      _uploadingImage = false;
      rebuildUi();

    

    }
  }



  void sendMessage(receiverId, conversationId,
      {String? imageUrl, String? fileUrl, String? fileName}) async {
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
    }
    if (imageUrl != null) {
      _uploadingImage = true;
      rebuildUi();
      await addMessage(
          MessageModel(
            content: imageUrl,
            receiverId: receiverId,
            senderId: FirebaseAuth.instance.currentUser!.uid,
            timestamp: DateTime.now(),
            type: 'image',
            fileName: '',
          ),
          conversationId);

      _uploadingImage = false;
      rebuildUi();
    }

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    messageController.clear();
  }

  Future<void> addMessage(MessageModel message, String conversationId) async {
    await _conversationService.sendMessage(message, conversationId);
    messageController.clear();
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

  File? pickFile;

  @override
  Stream<List<MessageModel>> get stream =>
      _conversationService.getMessages(convoId);

  void getFile(String receiverId, String conversationId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip', 'pdf', 'doc', 'docx'],
    );
    if (result != null) {
      _uploadingFile = true;
      rebuildUi();
      pickFile = File(result.files.single.path!);
      String fileName = result.files.single.path!.split('/').last;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('files/$fileName');
      UploadTask uploadTask = storageRef.putFile(pickFile!);

      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      addMessage(
          MessageModel(
            content: downloadUrl,
            receiverId: receiverId,
            senderId: FirebaseAuth.instance.currentUser!.uid,
            timestamp: DateTime.now(),
            type: 'file',
            fileName: fileName,
          ),
          conversationId);

      _uploadingFile = false;
      rebuildUi();
    } else {
      log("No file selected");
    }
  }

  void getBack() {
    _navigationLoactor.back();
  }
}
