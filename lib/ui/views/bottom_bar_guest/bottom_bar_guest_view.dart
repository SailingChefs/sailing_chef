import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart';
import 'package:sailing_chefs/ui/views/index/index_view.dart';
import 'package:sailing_chefs/ui/views/profile/profile_view.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_view.dart';
import 'package:stacked/stacked.dart';

import 'bottom_bar_guest_viewmodel.dart';

class BottomBarGuestView extends StackedView<BottomBarGuestViewModel> {
  const BottomBarGuestView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BottomBarGuestViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder<BottomBarGuestViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: getViewForIndex(viewModel.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kcWhiteColor,
          selectedItemColor: kcPrimaryColor,
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          selectedIconTheme: const IconThemeData(color: kcPrimaryColor),
          unselectedLabelStyle: const TextStyle(color: Colors.white),
          selectedLabelStyle: const TextStyle(color: kcPrimaryColor),
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.setIndex,
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(
                FlutterRemix.home_fill,
                color: kcDarkColor,
              ),
              label: '',
              icon: Icon(
                FlutterRemix.home_line,
                color: kcMediumGrey,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                FlutterRemix.bookmark_fill,
                color: kcDarkColor,
              ),
              label: '',
              icon: Icon(
                Icons.bookmark_border_outlined,
                color: kcMediumGrey,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.chat_bubble_rounded,
                color: kcDarkColor,
              ),
              label: '',
              icon: Icon(
                Icons.chat_bubble_outline_outlined,
                color: kcMediumGrey,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                FlutterRemix.account_circle_fill,
                color: kcDarkColor,
              ),
              label: '',
              icon: Icon(
                FlutterRemix.account_circle_line,
                color: kcMediumGrey,
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => BottomBarGuestViewModel(),
    );
  }

  @override
  BottomBarGuestViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BottomBarGuestViewModel();
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const IndexView();
    case 1:
      return const SavedRecipesView();
    case 2:
      return const ChatListView();
    case 3:
      return const ProfileView();

    default:
      return const Text('On Index Number  3');
  }
}
