import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/message_model.dart';
import 'package:sailing_chefs/ui/views/Messages/chat_viewmodel.dart';

class ChatMessage extends ViewModelWidget<ChatViewModel> {
  final MessageModel message;
  const ChatMessage(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ChatViewModel viewModel) {
    final isCurrentUser = message.senderId == userDetails!.uid;
    final messageIndex = viewModel.messages.indexOf(message);
    final nextMessageIsDifferentUser =
        messageIndex + 1 < viewModel.messages.length &&
            viewModel.messages[messageIndex + 1].senderId == message.senderId;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isCurrentUser && messageIndex > 0 && nextMessageIsDifferentUser)
            const SizedBox(width: 3.0),
          if (!isCurrentUser && messageIndex > 0 && nextMessageIsDifferentUser)
            CircleAvatar(
              radius: 20.0,
              backgroundImage: userDetails!.displayPicture!.isNotEmpty
                  ? NetworkImage(userDetails!.displayPicture!)
                  : null,
              child: userDetails!.displayPicture!.isNotEmpty
                  ? null
                  : const Icon(Icons.person),
            ),
          horizontalSpaceSmall,
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? kcchatboxecolor
                  : kcPrimaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: isCurrentUser
                    ? const Radius.circular(30)
                    : const Radius.circular(30),
                topRight: isCurrentUser
                    ? const Radius.circular(30)
                    : const Radius.circular(30),
                bottomRight: isCurrentUser
                    ? const Radius.circular(0)
                    : const Radius.circular(30),
                bottomLeft: isCurrentUser
                    ? const Radius.circular(30)
                    : const Radius.circular(0),
              ),
            ),
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                if (message.type == 'image')
                  GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        message.content,
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (message.type == 'String')
                  Text(
                    message.content,
                    style: const TextStyle(color: kcBlackColor),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
