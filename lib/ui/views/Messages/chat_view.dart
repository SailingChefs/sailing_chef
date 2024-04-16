// ignore_for_file: prefer_const_constructors


import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/chat_message.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/input_field.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  final String conversationId;
  final UserModel user;
  const ChatView({required this.user, required this.conversationId, super.key});

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: kcBackgroundColor,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 25),
                  child: BackArrowWidget(
                    onTap: () {
                      viewModel.moveBack();
                    },
                  ),
                ),
                StreamBuilder<List<ConversationModel>>(
                  stream: viewModel.getConversation(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final firstConversation = snapshot.data!.firstOrNull;
                      if (firstConversation != null) {
                        final imageUrl = firstConversation.imageTitle.isNotEmpty
                            ? firstConversation.imageTitle
                                .first 
                            : 'assets/images/icons/chef.jpg'; 

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalSpaceLarge,
                            Container(
                              width: 90.w,
                              height: 90.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageUrl),
                                ),
                              ),
                            ),
                            verticalSpaceTiny,
                            Text(
                              firstConversation.name,
                              style: globalTextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: kcBlackColor,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text('No conversation data');
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              Expanded(
                child: ListView.builder(
                      itemCount: viewModel.messages.length,
                      controller: viewModel.scrollController,
                      itemBuilder: (context, index) {
                        return ChatMessage(viewModel.messages[index]);
                      },
                    ),
                // child: StreamBuilder<List<MessageModel>>(
                //   stream: ,
                //   builder: (context, snapshot) {
                //     log("data is message "+snapshot.data.toString());
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return CircularProgressIndicator();
                //     }else if(!snapshot.hasData){
                //       return const Text('No conversation data');
                //     }else if(snapshot.hasError){
                //       return Text(snapshot.error.toString());
                //     }
                //     return ;
                //   },
                // ),
              ),
                BuildInputFieldChatScreen(
                    user: user, conversationId: conversationId),
              ],
            ),
          ),
        );
      
  }
  @override

  @override
  ChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatViewModel(convoId: conversationId);
}
