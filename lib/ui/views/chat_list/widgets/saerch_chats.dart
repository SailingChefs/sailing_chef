// // ignore_for_file: deprecated_member_use
// import 'package:sailing_chefs/core/imports/core_imports.dart';
// import 'package:sailing_chefs/ui/views/chat_list/chat_list_viewmodel.dart';

// class SearchBarAllChatsScreen
//     extends ViewModelWidget<ChatListViewModel> {
//   const SearchBarAllChatsScreen({super.key,});

//   @override
//   Widget build(BuildContext context, ChatListViewModel viewModel) {
//     return FittedBox(
//       child: Row(
//         children: [
//           SizedBox(
//             width: MediaQuery.sizeOf(context).width * 0.9,
//             height: 40.dg,
//             child: TextField(
//               onEditingComplete: () => viewModel.rebuildUi(),
//               onChanged: (value) {
//                 viewModel.rebuildUi();
//               },
//               // onSubmitted: (value) => viewModel.searchUsers(),
//               controller: viewModel.searchController,
//               textAlign: TextAlign.start,
//               decoration: InputDecoration(
//                 hintStyle: TextStyle(
//                   color: kcBlackColor.withOpacity(0.6),
//                   fontSize: 12.sp,
//                 ),
//                 filled: true,
//                 fillColor: kcsgreycolor.withOpacity(0.09),
//                 labelStyle: TextStyle(
//                     fontSize: 12.sp, color: kcBlackColor.withOpacity(0.6)),
//                 labelText: 'Search',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0.r),
//                   borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0.r),
//                   borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0.r),
//                   borderSide: BorderSide(
//                       color: kcBlackColor
//                           .withOpacity(0.2)),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0.r),
//                   borderSide: const BorderSide(
//                     color: kcErrorColor,
//                   ),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0.r),
//                   borderSide: const BorderSide(
//                     color: kcErrorColor,
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 10.0,
//                   horizontal: 20.0,
//                 ),
//                 prefixIcon: Icon(
//                   FlutterRemix.search_line,
//                   color: kcBlackColor.withOpacity(0.6),
//                   size: 20,
//                 ),
//               ),
//             ),
//           ),

//         ],
//       ),
//     );
//   }
// }
