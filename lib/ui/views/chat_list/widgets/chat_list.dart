import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_viewmodel.dart';

class ChatListScreen extends ViewModelWidget<ChatListViewModel> {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, viewModel) {
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : StreamBuilder<List<ConversationModel>>(
            stream: viewModel.getConversation(),
            builder: (context, snapshot) {
              log(snapshot.data.toString());

              return snapshot.hasData
                  ? SizedBox(
                      width: double.infinity,
                      height: 400.h,
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            ConversationModel conversation =
                                snapshot.data![index];

                            DateTime dateTime = DateTime.parse(
                                conversation.latestMessageTime.toString());
                            int hour = dateTime.hour;
                            int minute = dateTime.minute;

                            String period = (hour < 12) ? 'AM' : 'PM';

                            int hour12 = (hour > 12) ? (hour - 12) : hour;
                            if (hour12 == 0) {
                              hour12 = 12;
                            }
                            String twoDigits(int n) {
                              if (n >= 10) {
                                return '$n';
                              } else {
                                return '0$n';
                              }
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
                                        conversation.user!.displayName!,
                                      ),
                                      subtitle: conversation
                                                  .latestMessageType ==
                                              'String'
                                          ? Text(
                                              conversation.latestMessage
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: kcPrimaryColor
                                                      .withOpacity(0.5)),
                                            )
                                          : Text(
                                              'Sent an attachement',
                                              style: TextStyle(
                                                  color: kcPrimaryColor
                                                      .withOpacity(0.5)),
                                            ),
                                      leading: CircleAvatar(
                                        radius: 30.r,
                                        backgroundImage: NetworkImage(
                                            conversation.user!.displayPicture!),
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
