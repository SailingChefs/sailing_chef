import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_viewmodel.dart';
import 'package:sailing_chefs/ui/views/chat_list/widgets/chat_list.dart';
import 'package:sailing_chefs/ui/views/chat_list/widgets/shimmerloader.dart';
import 'package:sailing_chefs/ui/views/chat_list/widgets/top_bar.dart';
import 'package:stacked/stacked.dart';

class ChatListView extends StackedView<ChatListViewModel> {
  const ChatListView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ChatListViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const ShimmerLoaderChatList()
        : SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: RefreshIndicator(
                  color: kcPrimaryColor,
                  onRefresh: () async {
                    viewModel.notifyListeners();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopBarChatListScreen(),
                        verticalSpaceMedium,
                        const ChatListScreen(),
                      ],
                    ),
                  ),
                )),
          );
  }

  // @override
  // onViewModelReady(ChatListViewModel viewModel) {
  //   viewModel.onViewModelReady();
  //   super.onViewModelReady(viewModel);
  // }
  @override
  ChatListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatListViewModel();
}
