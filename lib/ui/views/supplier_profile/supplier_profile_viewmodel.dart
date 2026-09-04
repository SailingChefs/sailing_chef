import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierProfileViewModel extends BaseViewModel {
  final UserModel supplier;
  final bool isSelf;

  SupplierProfileViewModel({required this.supplier, required this.isSelf});

  final _navigationService = locator<NavigationService>();
  final _conversationService = locator<ConversationService>();

  bool get hasAddress =>
      supplier.namedLocation != null && supplier.namedLocation!.isNotEmpty;

  bool _isProcessing = false;

  Future<void> openDirections() async {
    if (!hasAddress) return;
    final query = Uri.encodeComponent(supplier.namedLocation!);
    final uri = Uri.parse('https://maps.google.com/?q=$query');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> openWebsite() async {
    if (supplier.link == null || supplier.link!.isEmpty) return;
    var raw = supplier.link!.trim();
    if (!raw.startsWith('http')) raw = 'https://$raw';
    final uri = Uri.parse(raw);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> callPhone() async {
    if (supplier.contactNumber == null || supplier.contactNumber!.isEmpty) return;
    final uri = Uri.parse('tel:${supplier.contactNumber}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> messageSupplier() async {
    if (_isProcessing) return;
    _isProcessing = true;
    EasyLoading.show();
    notifyListeners();
    try {
      final conversation = ConversationModel(
        latestMessage: '',
        users: [FirebaseAuth.instance.currentUser!.uid, supplier.uid!],
        latestMessageType: 'text',
        latestMessageTime: DateTime.now(),
        lastActive: DateTime.now(),
        uid: '',
      );
      final conversationId =
          await _conversationService.createOrUpdateConversation(conversation);
      _navigationService.navigateToChatView(
          messageFromCource: '', receiver: supplier, conversationId: conversationId);
    } catch (e) {
      log('SupplierProfileViewModel.messageSupplier: $e');
    } finally {
      _isProcessing = false;
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  void editProfile() {
    _navigationService.navigateToSettingsView();
  }
}
