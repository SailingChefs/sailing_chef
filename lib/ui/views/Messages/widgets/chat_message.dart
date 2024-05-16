// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/message_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/Messages/chat_viewmodel.dart';
import 'package:sailing_chefs/ui/views/Messages/widgets/image_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatMessage extends ViewModelWidget<ChatViewModel> {
  final MessageModel message;
  final UserModel user;

  const ChatMessage(this.message, {Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context, ChatViewModel viewModel) {
    final isCurrentUser =
        message.senderId == FirebaseAuth.instance.currentUser!.uid;
    final messageIndex = viewModel.messages.indexOf(message);
    final nextMessageIsDifferentUser =
        messageIndex + 1 < viewModel.messages.length &&
            viewModel.messages[messageIndex + 1].senderId == message.senderId;

        final last =
        messageIndex  < viewModel.messages.length &&
            viewModel.messages[messageIndex].senderId == message.senderId;
    final timestampInMinutes =
        DateTime.now().difference(message.timestamp).inDays;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 3.0,
        horizontal: nextMessageIsDifferentUser ? 21 : 0.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (!isCurrentUser &&
                  messageIndex > 0 &&
                  !nextMessageIsDifferentUser)
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: user.displayPicture!.isNotEmpty
                      ? NetworkImage(user.displayPicture!)
                      : null,
                  child: user.displayPicture!.isNotEmpty
                      ? null
                      : const Icon(Icons.person),
                ),
              horizontalSpaceTiny,
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.69,
                ),
                child: Column(
                  crossAxisAlignment: isCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (message.type == 'image')
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImageViewerScreen(
                                imageUrl: message.content,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0),
                              bottomLeft: isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0),
                              topRight: !isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0),
                              bottomRight: !isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0)),
                          child: CachedNetworkImage(
                            imageUrl: message.content,
                            width: 120.0,
                            height: 178.0,
                            progressIndicatorBuilder:
                                (context, url, progress) => Container(
                              width: 120,
                              height: 178,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0),
                              bottomLeft: isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0),
                              topRight: !isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0),
                              bottomRight: !isCurrentUser
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0)),
                                  )),
                            
                        
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (message.type == 'String')
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? kcchatboxecolor
                              : kcPrimaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: isCurrentUser
                                ? const Radius.circular(30)
                                : const Radius.circular(30),
                            topRight: isCurrentUser
                                ? const Radius.circular(30)
                                : const Radius.circular(30),
                            bottomRight: isCurrentUser
                                ? const Radius.circular(0)
                                : const Radius.circular(30),
                            bottomLeft: isCurrentUser
                                ? const Radius.circular(30)
                                : const Radius.circular(0),
                          ),
                        ),
                        child: Text(
                          message.content,
                          style: const TextStyle(color: kcBlackColor),
                        ),
                      ),
                    if (message.type == 'file')
                      viewModel.uploadingFile && !last
                          ? Container(
                              padding: const EdgeInsets.all(10.0),
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
                                          onTap: () async {
                                           
                                          },
                                          child: const Icon(Icons.download,color: kcsgreycolor,)),
                                      leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.asset(
                                            'assets/images/icons/unid.png',
                                            width: 50.0,
                                            height: 50.0,
                                            fit: BoxFit.cover,
                                          )))
                            )
                          : Container(
                              padding: const EdgeInsets.all(10.0),
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
                              child: message.content.contains('pdf')
                                  ? ListTile(
                                      title: Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          message.fileName.toString()),
                                      subtitle: Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          message.content),
                                      trailing: GestureDetector(
                                          onTap: () async {
                                            await launch(message.content);
                                          },
                                          child: const Icon(Icons.download)),
                                      leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.asset(
                                            'assets/images/icons/pdf.png',
                                            width: 50.0,
                                            height: 50.0,
                                            fit: BoxFit.cover,
                                          )))
                                  : message.content.contains('doc')
                                      ? ListTile(
                                          title: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              message.fileName.toString()),
                                          subtitle: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              message.content),
                                          trailing: GestureDetector(
                                              onTap: () async {
                                                await launch(message.content);
                                              },
                                              child:
                                                  const Icon(Icons.download)),
                                          leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                'assets/images/icons/docx.png',
                                                width: 50.0,
                                                height: 50.0,
                                                fit: BoxFit.cover,
                                              )))
                                      : message.content.contains('docx')
                                          ? ListTile(
                                              title: Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  message.fileName.toString()),
                                              subtitle: Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  message.content),
                                              trailing: GestureDetector(
                                                  onTap: () async {
                                                    await launch(
                                                        message.content);
                                                  },
                                                  child: const Icon(
                                                      Icons.download)),
                                              leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.asset(
                                                    'assets/images/icons/docx.png',
                                                    width: 50.0,
                                                    height: 50.0,
                                                    fit: BoxFit.cover,
                                                  )))
                                          : message.content.contains('zip')
                                              ? ListTile(
                                                  title: Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      message.fileName
                                                          .toString()),
                                                  subtitle: Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      message.content),
                                                  trailing: GestureDetector(
                                                      onTap: () async {
                                                        await launch(
                                                            message.content);
                                                      },
                                                      child: const Icon(
                                                          Icons.download)),
                                                  leading: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.asset(
                                                      'assets/images/icons/zip.png',
                                                      width: 50.0,
                                                      height: 50.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                            ),
                  ],
                ),
              ),
              horizontalSpaceTiny,
              if (isCurrentUser &&
                  messageIndex > 0 &&
                  !nextMessageIsDifferentUser)
                const SizedBox(),
              if (isCurrentUser &&
                  messageIndex > 0 &&
                  !nextMessageIsDifferentUser)
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: userDetails!.displayPicture != null
                      ? NetworkImage(userDetails!.displayPicture!)
                      : const AssetImage('assets/images/icons/imageicon.png')
                          as ImageProvider<Object>,
                  child: userDetails!.displayPicture!.isNotEmpty
                      ? null
                      : const Icon(Icons.person),
                ),
            ],
          ),
          nextMessageIsDifferentUser
              ? Container()
              : Row(
                  mainAxisAlignment: isCurrentUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    horizontalSpaceSmall,
                    horizontalSpaceSmall,
                    horizontalSpaceSmall,
                    horizontalSpaceTiny,
                    Text(
                      '$timestampInMinutes days ago',
                      style: globalTextStyle(
                          fontSize: 12, color: kcBlackColor.withOpacity(0.4)),
                    ),
                    horizontalSpaceSmall,
                    horizontalSpaceSmall,
                    horizontalSpaceSmall,
                    horizontalSpaceTiny,
                  ],
                )
        ],
      ),
    );
  }
}
