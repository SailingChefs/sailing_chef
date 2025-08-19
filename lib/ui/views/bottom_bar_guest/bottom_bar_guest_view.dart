// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          unselectedIconTheme: const IconThemeData(color: kcWhiteColor),
          selectedIconTheme: const IconThemeData(color: kcPrimaryColor),
          unselectedLabelStyle: const TextStyle(color: kcWhiteColor),
          selectedLabelStyle: const TextStyle(color: kcPrimaryColor),
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.setIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/images/icons/homeselected.svg',
                color: kcPrimaryColor,
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/icons/homeselected.svg',
                color: Colors.grey[500],
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/images/misc/bookmark.svg',
                color: kcPrimaryColor,
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/misc/bookmark.svg',
                color: Colors.grey[600],
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/images/icons/chat.svg',
                color: kcPrimaryColor,
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/icons/chat.svg',
                color: Colors.grey[600],
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/images/icons/profile.svg',
                color: kcPrimaryColor,
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/icons/profile.svg',
                color: Colors.grey[600],
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
