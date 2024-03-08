import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chat/chat_viewmodel.dart';

class BuildInputFieldChatScreen extends ViewModelWidget<ChatViewModel> {
  const BuildInputFieldChatScreen({super.key});

  @override
  Widget build(BuildContext context, ChatViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: kcLightGrey.withOpacity(0.03),
        boxShadow: [
          BoxShadow(
            color: kcLightGrey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.camera_alt_outlined,
            ),
            onPressed: () {
              viewModel.getImage(ImageSource.camera);
            },
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                filled: true,
                fillColor: kcWhiteColor.withOpacity(0.9),
                hintText: 'Type your message here...',
                hintStyle: TextStyle(
                    fontSize: 12.sp, color: kcBlackColor.withOpacity(0.6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(
                      color: kcWhiteColor
                          .withOpacity(0.2)), // Unfocused border color
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: const BorderSide(
                    color: kcErrorColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
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
          IconButton(
            icon: const Icon(FlutterRemix.attachment_2),
            onPressed: () {
              viewModel.getImage(ImageSource.gallery);
            },
          ),
          GestureDetector(
            onTap: () {
              viewModel.sendMessage(viewModel.textController.text);
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kcPrimaryColor,
              ),
              child: const Icon(
                FlutterRemix.send_plane_fill,
                color: kcWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
