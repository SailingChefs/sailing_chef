import 'package:chatview/chatview.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';

import 'user_chat_viewmodel.dart';

class UserChatView extends StackedView<UserChatViewModel> {
  const UserChatView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserChatViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: StreamBuilder<List<ConversationModel>>(
            stream: viewModel.getConversation(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ChatView(
                      chatController: viewModel.chatController,
                      currentUser: viewModel.currentUser,
                      chatViewState: ChatViewState.hasMessages,
                    )
                  : ChatView(
                      chatController: viewModel.chatController,
                      currentUser: viewModel.currentUser,
                      chatViewState: ChatViewState.loading);
            }));
  }

  @override
  UserChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserChatViewModel(convoId: '');
}
