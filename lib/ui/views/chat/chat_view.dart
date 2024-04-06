
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chat/widgets/chat_message.dart';
import 'package:sailing_chefs/ui/views/chat/widgets/input_field.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

import '../../../core/global_uservariable.dart';
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
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  child: BackArrowWidget(
                    onTap: () {
                      viewModel.moveBack();
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpaceLarge,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.transparent,
                      ),
                      width: 90.w,
                      height: 90.h,
                      child: userDetails!.displayPicture!.isNotEmpty ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          (userDetails!.displayPicture!),
                        ),
                      ) : const SizedBox()
                    ),
                    verticalSpaceTiny,
                    Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Danica Nel',
                            style: globalTextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: kcBlackColor,
                            ),
                          ),
                        ),
            
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    controller: viewModel.scrollController,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      return ChatMessage(viewModel.messages[index]);
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
