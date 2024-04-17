import 'dart:io';

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/message_model.dart';
import 'package:sailing_chefs/ui/views/Messages/chat_viewmodel.dart';

class ChatMessage extends ViewModelWidget<ChatViewModel> {
  final MessageModel message;
  const ChatMessage(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ChatViewModel viewModel) {
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.senderId != userDetails!.uid
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: <Widget>[
          //   if (message.senderId != userDetails!.uid) ...[
          //     Container(
          //       color: Colors.amber,
          //       width: 120,
          //       height: 180,
          //       child: message.type == 'image'
          //           ? ClipRRect(
          //               child: Image.file(
          //                 File(message.content),
          //                 width: 50.0,
          //                 height: 50.0,
          //                 fit: BoxFit.cover,
          //               ),
          //             )
          //           : const SizedBox(),
          //     ),
          //   ],
          if (message.senderId == userDetails!.uid) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: message.senderId == userDetails!.uid
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: <Widget>[
                  if (message.content.isNotEmpty)
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
                            width: 250,
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: message.senderId != userDetails!.uid
                                  ? kcPrimaryColor.withOpacity(0.2)
                                  : kcLightGrey.withOpacity(0.08),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (message.content.isNotEmpty)
                                  Text(
                                    message.content,
                                    style: const TextStyle(color: kcBlackColor),
                                  ),
                                if (message.content.isNotEmpty)
                                  const SizedBox(height: 5.0),
                                if (message.type == 'image')
                                  GestureDetector(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                      child: Image.file(
                                        File(message.content),
                                        width: 1550.0,
                                        height: 175.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
