import 'dart:io';

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/messages_model.dart';
import 'package:sailing_chefs/ui/views/chat/chat_viewmodel.dart';

class ChatMessage extends ViewModelWidget<ChatViewModel> {
  final MessageModel message;
  const ChatMessage(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ChatViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.receiverId == userDetails!.uid
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          if (message.senderId != userDetails!.uid) ...[
            SizedBox(
              width: 120,
              height: 180,
              child: message.image!.isNotEmpty
                  ? ClipRRect(
                      child: Image.file(
                        File(message.image ?? ''),
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: message.senderId == userDetails!.uid
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                
                Row(
                  children: [
                    CircleAvatar(
                        child: userDetails!.displayPicture!.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  (userDetails!.displayPicture!),
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const SizedBox()),
                    horizontalSpaceSmall,
                    Flexible(
                      child: Container(
                        width: 230,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: message.senderId == userDetails!.uid
                              ? kcPrimaryColor.withOpacity(0.2)
                              : kcLightGrey.withOpacity(0.08),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.content,
                              style: const TextStyle(color: kcBlackColor),
                            ),
                            const SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {},
                    child: viewModel.selectedImageFile!.path.isNotEmpty
                         ? ClipRRect(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(20), bottomRight: Radius.circular(0), bottomLeft: Radius.circular(20)),
                            child: Image.file(
                              File(message.image ?? ''),
                              width: 120.0,
                              height: 175.0,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(),
                  ),
              ],
            ),
          ),
        ] 
      ),
    );
  }
}
