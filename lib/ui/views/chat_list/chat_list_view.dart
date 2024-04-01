import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/chat_list/widgets/chat_list.dart';
import 'package:sailing_chefs/ui/views/chat_list/widgets/top_bar.dart';
import 'package:stacked/stacked.dart';

import 'chat_list_viewmodel.dart';

class ChatListView extends StackedView<ChatListViewModel> {
  const ChatListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChatListViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body:  Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(children: [
            const TopBarChatListScreen(),
            verticalSpaceMedium,
            const Expanded(child: ChatListScreen()),
          ],),
        )
      ),
    );
  }

  @override
  ChatListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatListViewModel();
}
