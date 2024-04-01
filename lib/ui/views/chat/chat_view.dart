import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chat/widgets/input_field.dart';

import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  const ChatView({super.key});

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (context, viewModel, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: kcBackgroundColor,
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: viewModel.scrollController,
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      return Container();
                      //  return ChatMessage(viewModel.messages[index]);
                    },
                  ),
                ),
                const BuildInputFieldChatScreen(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  ChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatViewModel();
}
