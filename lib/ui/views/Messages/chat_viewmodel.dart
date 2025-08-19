import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/message_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatViewModel extends StreamViewModel<List<MessageModel>> {
  final String messageFromCource;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final _navigationLoactor = locator<NavigationService>();
  final _conversationService = locator<ConversationService>();
  final String convoId;
  XFile? selectedImageFile;
  List<MessageModel> messages = List.empty(growable: true);

  bool isAtTop = false;
  bool isImageSending = false;

  ChatViewModel(this.messageFromCource, {required this.convoId}) {
    messageController.text = messageFromCource;
  }

  void onViewModelReady() {
    log('message $messageFromCource');
    // scrollController.addListener(() {
    //   isAtTop = scrollController.offset <= kToolbarHeight;
    //   if (scrollController.position.pixels < 180) {
    //     isAtTop = true;
    //   }

    //   rebuildUi();
    // });
    if (messageFromCource.isNotEmpty) {
      messageController.text = messageFromCource;
      rebuildUi();
    } else {
      messageController.text = '';
      rebuildUi();
    }
  }

  bool _uploadingImage = false;
  bool _uploadingFile = false;

  bool get uploadingImage => _uploadingImage;
  bool get uploadingFile => _uploadingFile;

  Stream<List<ConversationModel>> getConversation() {
    final var conversations =
        _conversationService.getConversations();

    return conversations;
  }

  final messageController = TextEditingController();

  Future<void> getImage(
      ImageSource source, String receiverId, conversationId) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: source);

    if (pickedFile != null) {
      selectedImageFile = pickedFile;

      rebuildUi();
      _uploadingImage = true;
      final imageUrl = await _conversationService.uploadImage(
          File(selectedImageFile!.path), selectedImageFile!.name);
      _uploadingImage = false;
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

      rebuildUi();
    }
  }

  Future<void> sendMessage(receiverId, conversationId,
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

  bool validateLink(String? value) {
    final urlRegex = RegExp(
      r'^(?:https?:\/\/|www\.|)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(?:\/[a-zA-Z0-9_\-\.~%!*$?&+:@=,;]*)?(?:\?(?:[a-zA-Z0-9_\-\.~%!*$?&+:@=,;]+))?$',
      caseSensitive: false,
    );
    return urlRegex.hasMatch(value!) ? true : false;
  }

  Future<void> onClickUrl(String url) async {
    var uri = Uri.parse(url);

    if (uri.scheme.isEmpty) {
      uri = Uri.parse('https:$url');
    }

    await launchUrl(uri);
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
  void onData(List<MessageModel>? data) {
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

  Future<void> getFile(String receiverId, String conversationId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip', 'pdf', 'doc', 'docx'],
    );
    if (result != null) {
      _uploadingFile = true;
      rebuildUi();
      pickFile = File(result.files.single.path!);
      final fileName = result.files.single.path!.split('/').last;
      final storageRef =
          FirebaseStorage.instance.ref().child('files/$fileName');
      final uploadTask = storageRef.putFile(pickFile!);

      final taskSnapshot = await uploadTask;

      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

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
      log('No file selected');
    }
  }

  void getBack() {
    _navigationLoactor.back();
  }

  void copyMessage(String content) {
    Clipboard.setData(ClipboardData(text: content));
    showToast(message: 'Message copied');
  }

  void navigateToProfile(UserModel receiver) {
    _navigationLoactor.navigateToChefProfileView(user: receiver);
  }
}

extension StringExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
