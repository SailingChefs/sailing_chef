import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/chat_message.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/input_field.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/test.dart';
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
              StreamBuilder<List<ConversationModel>>(
                stream: viewModel.getConversation(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final imageUrl = receiver.displayPicture ??
                        'assets/images/icons/chef.jpg';
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => const TestClass()));
                            },
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
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              verticalSpaceLarge,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.63,
                child: ListView.builder(
                  itemCount: viewModel.messages.length,
                  controller: viewModel.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatMessage(
                      viewModel.messages[index],
                      user: receiver,
                    );
                  },
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

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:sailing_chefs/model/user_model.dart';
// import 'package:sailing_chefs/ui/views/Messages/widgets/chat_message.dart';
// import 'package:sailing_chefs/ui/views/Messages/widgets/input_field.dart';
// import 'package:stacked/stacked.dart';
//
// import 'chat_viewmodel.dart';
//
// class ChatView extends StackedView<ChatViewModel> {
//   final String conversationId;
//   final UserModel receiver;
//
//   const ChatView(
//       {required this.receiver, required this.conversationId, super.key});
//
//   @override
//   Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       bottomSheet: BuildInputFieldChatScreen(
//           user: receiver, conversationId: conversationId),
//       body: SizedBox(
//         height: size.height * 0.9,
//         child: Stack(
//           children: [
//             CustomScrollView(
//               slivers: [
//                 const SliverAppBar(
//                   leadingWidth: 80,
//                   backgroundColor: Colors.transparent,
//
//                   // collapsedHeight: 400,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         CircleAvatar(
//                           radius: 100,
//                           backgroundImage: NetworkImage(
//                               'https://imgv3.fotor.com/images/gallery/cartoon-character-generated-by-Fotor-ai-art-creator.jpg'),
//                         ),
//                         Text(
//                           "Someones's Moon",
//                           style: TextStyle(fontSize: 25),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   expandedHeight: 400,
//
//                   // flexibleSpace:
//                 ),
//                 SliverList(
//                     delegate: SliverChildListDelegate([
//                   //     for()
//                   // Expanded(
//                   //   // height: MediaQuery.sizeOf(context).height * 0.5.h,
//                   //   child: ListView.builder(
//                   //     itemCount: viewModel.messages.length,
//                   //     controller: viewModel.scrollController,
//                   //     physics: const AlwaysScrollableScrollPhysics(),
//                   //     itemBuilder: (context, index) {
//                   //       return ChatMessage(
//                   //         viewModel.messages[index],
//                   //         user: receiver,
//                   //       );
//                   //     },
//                   //   ),
//                   // ),
//                 ]))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   ChatViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       ChatViewModel(convoId: conversationId);
// }
