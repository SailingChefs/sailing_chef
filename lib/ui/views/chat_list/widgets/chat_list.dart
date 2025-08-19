import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_viewmodel.dart';
import 'package:sailing_chefs/ui/views/chat_list/widgets/shimmerloader.dart';

class ChatListScreen extends ViewModelWidget<ChatListViewModel> {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, ChatListViewModel viewModel) {
    return StreamBuilder<List<ConversationModel>>(
        stream: viewModel.getConversation(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const ShimmerLoaderChatList()
              : snapshot.hasData
                  ? snapshot.data!.isEmpty
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          child: Center(
                            child: Text('No Chats',
                                style: globalTextStyle(fontSize: 18, color: kcPrimaryColor)),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final conversation = snapshot.data![index];

                                final dateTime =
                                    DateTime.parse(conversation.latestMessageTime.toString());
                                final hour = dateTime.hour;
                                final minute = dateTime.minute;

                                final period = (hour < 12) ? 'AM' : 'PM';

                                var hour12 = (hour > 12) ? (hour - 12) : hour;
                                if (hour12 == 0) {
                                  hour12 = 12;
                                }
                                String twoDigits(int n) {
                                  if (n >= 10) {
                                    return '$n';
                                  }
                                  return '0$n';
                                }

                                return Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          viewModel.toChatScreen(conversation);
                                        },
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.all(5),
                                          title: Text(
                                            capitalizeEachWord(conversation.user!.displayName!),
                                          ),
                                          subtitle: conversation.latestMessageType == 'String'
                                              ? Text(
                                                  conversation.latestMessage.capitalize(),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: kcBlackColor.withOpacity(0.5)),
                                                )
                                              : (conversation.latestMessageType == 'image') ||
                                                      conversation.latestMessageType == 'file'
                                                  ? Text(
                                                      'Sent an attachement',
                                                      style: TextStyle(
                                                          color: kcBlackColor.withOpacity(0.5)),
                                                    )
                                                  : Text(
                                                      style: TextStyle(
                                                          color: kcBlackColor.withOpacity(0.5)),
                                                      'Craete new Message',
                                                    ),
                                          leading: CircleAvatar(
                                            radius: 30.r,
                                            backgroundImage: ImageUtils.safeNetworkImageForAvatar(
                                              conversation.user?.displayPicture,
                                            ),
                                          ),
                                          trailing: Text(
                                              '${twoDigits(hour12)}:${twoDigits(minute)} $period'),
                                        )),
                                    const Divider(
                                      color: kcVeryLightGrey,
                                      thickness: 0.5,
                                    ),
                                  ],
                                );
                              }),
                        )
                  : Container();
        });
  }
}
