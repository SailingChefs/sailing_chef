import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/chat_message.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/input_field.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  final String conversationId;
  final UserModel receiver;

  const ChatView( {required this.receiver, required this.conversationId,super.key});

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kcBackgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: BackArrowWidget(
                  onTap: viewModel.moveBack,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<List<ConversationModel>>(
                      stream: viewModel.getConversation(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {

                          final imageUrl =
                              receiver.displayPicture ?? 'assets/images/icons/chef.jpg';

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              verticalSpaceLarge,
                              Center(
                                child: Container(
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
                              ),
                              verticalSpaceTiny,
                              Text(
                                receiver.displayName ?? 'Chef Name',
                                style: globalTextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: kcBlackColor,
                                ),
                              ),
                            ],
                          );
                                                } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.59.h,
                      child: ListView.builder(
                        itemCount: viewModel.messages.length,
                        controller: viewModel.scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatMessage(viewModel.messages[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BuildInputFieldChatScreen(
                  user: receiver, conversationId: conversationId),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatViewModel(convoId: conversationId);
}
