import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/Messages/chat_viewmodel.dart';

// ignore: must_be_immutable
class InputFieldChatScreen extends ViewModelWidget<ChatViewModel> {
  const InputFieldChatScreen({
    required this.user, required this.conversationId, super.key,
  });
  final UserModel user;
  final String conversationId;

  @override
  Widget build(BuildContext context, ChatViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 63,
      decoration: BoxDecoration(
        color: kcbuttoncolor.withOpacity(0.03),
        borderRadius: const BorderRadius.only(
          
        ),
      ),
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: GestureDetector(
                  onTap: () {
                    viewModel.getImage(
                        ImageSource.camera, user.uid!, conversationId);
                  },
                  child: SvgPicture.asset(
                    'assets/images/icons/camera.svg',
                    width: 24,
                    height: 24,
                    color: kcBlackColor.withOpacity(0.7),
                  ),
                ),
              ),
              Flexible(
                child: TextField(
                  controller: viewModel.messageController,
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
                      horizontal: 20.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: GestureDetector(
                  onTap: () {
                    viewModel.isBusy
                        ? EasyLoading()
                        : viewModel.getFile(user.uid!, conversationId);
                  },
                  child: SvgPicture.asset(
                    'assets/images/icons/clip.svg',
                    width: 24,
                    height: 24,
                    color: kcBlackColor.withOpacity(0.7),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.sendMessage(user.uid, conversationId);
                },
                child: SvgPicture.asset('assets/images/icons/send.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
