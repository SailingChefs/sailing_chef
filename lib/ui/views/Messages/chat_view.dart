import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/chat_message.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/input_field.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

import '../../../core/helpers/capitalize_first_fucntion.dart';
import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  final String conversationId;
  final UserModel receiver;
  final String? messageFromCource;

  const ChatView(
      {required this.receiver,
      required this.conversationId,
      super.key,
      required this.messageFromCource});

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return ViewModelBuilder<ChatViewModel>.reactive(
        viewModelBuilder: () =>
            ChatViewModel(messageFromCource!, convoId: conversationId),
        onViewModelReady: (viewModel) {
          WidgetsBinding.instance.addPostFrameCallback((_) {});
        },
        builder: (context, viewModel, child) {
          return SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: kcwhitecolor,
                appBar: _CollapsedAppBar(
                  viewModel,
                  conversationId,
                  receiver,
                ),
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
        });
  }

  @override
  void onViewModelReady(ChatViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) =>
      ChatViewModel(messageFromCource!, convoId: conversationId);
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
                  verticalSpaceMedium,
                  _ExpandedAppBar(viewModel, receiver, conversationId),
                  for (int index = 0;
                      index < viewModel.messages.length + 1;
                      index++)
                    if (index < viewModel.messages.length)
                      ChatMessage(
                        viewModel.messages[index],
                        user: receiver,
                      )
                    else if (index >= viewModel.messages.length &&
                        viewModel.uploadingImage)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: kcsgreycolor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                width: 120.0,
                                height: 178.0,
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: kcPrimaryColor,
                                )),
                              ),
                            ),
                          ),
                          verticalSpaceSmall,
                        ],
                      )
                    else if (index >= viewModel.messages.length &&
                        viewModel.uploadingFile)
                      Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.68,
                            ),
                            decoration: BoxDecoration(
                              color: kcWhiteColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: kcLightGrey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                  title: const Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      'File Name'),
                                  subtitle: const Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      'File Path'),
                                  trailing: GestureDetector(
                                      onTap: () async {},
                                      child: const Icon(
                                        Icons.download,
                                        color: kcsgreycolor,
                                      )),
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        'assets/images/icons/unid.png',
                                        width: 50.0,
                                        height: 50.0,
                                        fit: BoxFit.cover,
                                      ))),
                            ),
                          ),
                          verticalSpaceSmall,
                        ],
                      )
                    else
                      const SizedBox(),
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
    return SizedBox(
      height: 180,
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: BackArrowWidget(onTap: () {
          //     viewModel.getBack();
          //   }),
          // ),
          Center(
            child: GestureDetector(
              onTap: () {
                viewModel.navigateToProfile(receiver);
              },
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ImageUtils.safeNetworkImageForAvatar(
                        receiver.displayPicture),
                  ),
                ),
              ),
            ),
          ),
          verticalSpaceTiny,
          Center(
            child: Text(
              capitalizeEachWord(receiver.displayName ?? 'Chef Name'),
              style: globalTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: kcBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CollapsedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatViewModel viewModel;

  const _CollapsedAppBar(this.viewModel, this.conversationId, this.receiver);
  final String conversationId;
  final UserModel receiver;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: kcwhitecolor,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          BackArrowWidget(onTap: () {
            viewModel.getBack();
          }),
          Text(
            capitalizeEachWord(receiver.displayName ?? 'Chef Name'),
            style: globalTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcBlackColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.navigateToProfile(receiver);
            },
            child: Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ImageUtils.safeNetworkImageForAvatar(
                      receiver.displayPicture),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
