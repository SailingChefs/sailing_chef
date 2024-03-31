// import 'package:sailing_chefs/core/imports/core_imports.dart';
// import 'package:sailing_chefs/model/messages_model.dart';

// class ChatMessage extends StatelessWidget {
//   final MessageModel message;
//   const ChatMessage(this.message, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment:
//             message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: <Widget>[
//           if (!message.isMe) ...[
//             const CircleAvatar(
//               child: Text('A'), // You can use an actual user image here
//             ),
//             const SizedBox(width: 10.0),
//           ],
//           Expanded(
//             child: Column(
//               crossAxisAlignment: message.isMe
//                   ? CrossAxisAlignment.end
//                   : CrossAxisAlignment.start,
//               children: <Widget>[
//                 if (message.image != null) ...[
//                   GestureDetector(
//                     onTap: () {
//                       // Open image or perform any action on image tap
//                     },
//                     child: ClipOval(
//                       child: Image(
//                         image: message.image!,
//                         width: 50.0,
//                         height: 50.0,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 5.0),
//                 ],
//                 Container(
//                   padding: const EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                     color: message.isMe
//                         ? kcPrimaryColor.withOpacity(0.2)
//                         : kcLightGrey.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         message.text,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       const SizedBox(height: 5.0),
//                       Text(
//                         // Display message timestamp here (replace with actual timestamp)
//                         '12:34 PM',
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           color: kcBlackColor.withOpacity(0.6),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
