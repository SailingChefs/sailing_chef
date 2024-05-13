import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/Messages/chat_viewmodel.dart';

class InputFieldChatScreen extends ViewModelWidget<ChatViewModel> {
  const InputFieldChatScreen({
    super.key,
    required this.user,
    required this.conversationId,
  });
  final UserModel user;
  final String conversationId;

  @override
  Widget build(BuildContext context, ChatViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: kcLightGrey.withOpacity(0.03),
        boxShadow: [
          BoxShadow(
            color: kcLightGrey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.camera_alt_outlined,
                ),
                onPressed: () {
                  viewModel.getImage(
                      ImageSource.camera, user.uid!, conversationId);
                },
              ),
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: viewModel.messageController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kcWhiteColor.withOpacity(0.9),
                      hintText: 'Type your message here...',
                      hintStyle: TextStyle(
                          fontSize: 12, color: kcBlackColor.withOpacity(0.6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: kcWhiteColor.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: kcWhiteColor.withOpacity(0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: kcWhiteColor.withOpacity(0.2)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: kcErrorColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: kcErrorColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(FlutterRemix.attachment_2),
                onPressed: () {
                  // viewModel.getImage(
                  //     ImageSource.gallery, user.uid!, conversationId);
                  viewModel.getFile(user.uid!, conversationId);
                },
              ),
              GestureDetector(
                onTap: () {
                  viewModel.sendMessage(user.uid!, conversationId);
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: viewModel.messageController.text.isEmpty
                        ? kcLightGrey
                        : kcPrimaryColor,
                  ),
                  child: const Icon(
                    FlutterRemix.send_plane_fill,
                    color: kcWhiteColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
