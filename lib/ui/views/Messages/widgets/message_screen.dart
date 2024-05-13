// import 'package:sailing_chefs/core/imports/core_imports.dart';
// import 'package:sailing_chefs/model/conversation_model.dart';
// import 'package:sailing_chefs/model/user_model.dart';
// import 'package:sailing_chefs/ui/views/Messages/chat_viewmodel.dart';
// import 'package:sailing_chefs/ui/views/Messages/widgets/chat_message.dart';
// import 'package:sailing_chefs/ui/views/Messages/widgets/input_field.dart';
// import 'package:sailing_chefs/ui/views/Messages/widgets/test.dart';

// class MainChatViewScreen extends ViewModelWidget<ChatViewModel> {
//   const MainChatViewScreen(this.reciever, this.conversationId, {super.key});
//   final String conversationId;
//   final UserModel reciever;
//   @override
//   Widget build(BuildContext context, ChatViewModel viewModel) {
//     return Scaffold(
//         body: SizedBox(
//       width: double.infinity,
//       height: MediaQuery.sizeOf(context).height * 0.95,
//       child: Column(
//         children: [
//           Container(height: 500,width: double.maxFinite,color: Colors.amber,),
//           Expanded(
//             child: NestedScrollView(
//                 headerSliverBuilder: (context, scrolled) => [
//                       SliverAppBar(
//                         collapsedHeight: kToolbarHeight,
//                         expandedHeight: 300,
//                         flexibleSpace: LayoutBuilder(
//                           builder:
//                               (BuildContext context, BoxConstraints constraints) {
//                             if (scrolled) {
//                               return Container(
//                                 color: Colors.green,
//                                 width: double.maxFinite,
//                               );
//                             }
//                             return Container(
//                               color: Colors.blue,
//                               width: double.maxFinite,
//                             );
//                           },
//                         ),
//                       )
//                     ],
//                 body: Column(
//                   children: [
//                     for (int index = 0;
//                         index < viewModel.messages.length;
//                         index++)
//                       Builder(builder: (context) {
//                         final message = viewModel.messages[index];
//                         return ChatMessage(
//                           message,
//                           user: reciever,
//                         );
//                       })
//                   ],
//                 )),
//           ),
//           // Column(
//           //   mainAxisSize: MainAxisSize.min,
//           //   mainAxisAlignment: MainAxisAlignment.start,
//           //   children: [
//           //     Center(
//           //       child: GestureDetector(
//           //         onTap: () {
//           //           Navigator.push(
//           //               context,
//           //               MaterialPageRoute(
//           //                   builder: (builder) => const TestClass()));
//           //         },
//           //         child: Container(
//           //           width: 90.w,
//           //           height: 90.h,
//           //           decoration: BoxDecoration(
//           //             shape: BoxShape.circle,
//           //             image: DecorationImage(
//           //               fit: BoxFit.cover,
//           //               image: NetworkImage(reciever.displayPicture ??
//           //                   'assets/images/icons/chef.jpg'),
//           //             ),
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //     verticalSpaceTiny,
//           //     Text(
//           //       reciever.displayName ?? 'Chef Name',
//           //       style: globalTextStyle(
//           //         fontSize: 22,
//           //         fontWeight: FontWeight.w600,
//           //         color: kcBlackColor,
//           //       ),
//           //     ),
//           //   ],
//           // ),
//           verticalSpaceLarge,
//           // Container(
//           //   padding: const EdgeInsets.symmetric(horizontal: 20),
//           //   width: double.infinity,
//           //   height: MediaQuery.of(context).size.height * 0.63,
//           //   child: ListView.builder(
//           //     itemCount: viewModel.messages.length,
//           //     controller: viewModel.scrollController,
//           //     physics: const AlwaysScrollableScrollPhysics(),
//           //     itemBuilder: (context, index) {
//           //       return ChatMessage(
//           //         viewModel.messages[index],
//           //         user: reciever,
//           //       );
//           //     },
//           //   ),
//           // ),
//           InputFieldChatScreen(user: reciever, conversationId: conversationId),
//         ],
//       ),
//     ));
//   }
// }
