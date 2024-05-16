import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/chat_message.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/input_field.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  final String conversationId;
  final UserModel receiver;

  const ChatView(
      {required this.receiver, required this.conversationId, super.key});

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kcwhitecolor,
          body: Stack(
            children: [
              _MessageListAndAppBar(viewModel, receiver, conversationId),
            ],
          ),
          bottomSheet: InputFieldChatScreen(
            user: receiver,
            conversationId: conversationId,
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(ChatViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) =>
      ChatViewModel(convoId: conversationId);
}

class _MessageListAndAppBar extends StatelessWidget {
  final ChatViewModel viewModel;
  final UserModel receiver;
  final String conversationId;

  const _MessageListAndAppBar(
    this.viewModel,
    this.receiver,
    this.conversationId,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              controller: viewModel.scrollController,
              child: Column(
                children: [
                  viewModel.isAtTop
                      ? _CollapsedAppBar(viewModel, conversationId, receiver)
                      : _ExpandedAppBar(viewModel, receiver, conversationId),
                  for (int index = 0;
                      index < viewModel.messages.length;
                      index++)
                    ChatMessage(
                      viewModel.messages[index],
                      user: receiver,
                    ),
                  verticalSpaceLarge,
                  verticalSpaceSmall,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExpandedAppBar extends StatelessWidget {
  final ChatViewModel viewModel;
  final UserModel receiver;
  final String conversationId;

  const _ExpandedAppBar(
    this.viewModel,
    this.receiver,
    this.conversationId,
  );

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !viewModel.isAtTop,
      child: SizedBox(
        height: 180,
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceSmall,
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: BackArrowWidget(onTap: () {
                viewModel.getBack();
              }),
            ),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 90.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(receiver.displayPicture!),
                    ),
                  ),
                ),
              ),
            ),
            verticalSpaceTiny,
            Center(
              child: Text(
                receiver.displayName ?? 'Chef Name',
                style: globalTextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollapsedAppBar extends StatelessWidget {
  final ChatViewModel viewModel;

  const _CollapsedAppBar(this.viewModel, this.conversationId, this.receiver);
  final String conversationId;
  final UserModel receiver;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainState: false,
      visible: viewModel.isAtTop,
      child: Container(
        height: kToolbarHeight,
        color: kcwhitecolor,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            children: [
              verticalSpaceSmall,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                BackArrowWidget(onTap: () {
                  viewModel.getBack();
                }),
                Text(
                  receiver.displayName ?? 'Chef Name',
                  style: globalTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor,
                  ),
                ),
                Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(receiver.displayPicture!),
                    ),
                  ),
                ),
              ]),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
