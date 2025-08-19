// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_view.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart';
import 'package:sailing_chefs/ui/views/index/index_view.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_view.dart';
import 'package:sailing_chefs/ui/views/profile/profile_view.dart';

import 'bottom_nav_bar_viewmodel.dart';

class BottomNavBarView extends StackedView<BottomNavBarViewModel> {
  int? index;

  BottomNavBarView({this.index, Key? key}) : super(key: key);

  @override
  Widget builder(context, viewModel, child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: index != null
          ? getViewForIndex(index!)
          : getViewForIndex(viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kcWhiteColor,
        selectedItemColor: kcPrimaryColor,
        unselectedIconTheme: const IconThemeData(color: kcWhiteColor),
        selectedIconTheme: const IconThemeData(color: kcPrimaryColor),
        unselectedLabelStyle: const TextStyle(color: kcWhiteColor),
        selectedLabelStyle: const TextStyle(color: kcPrimaryColor),
        // currentIndex: index != null ? index : viewModel.currentIndex,
        currentIndex: index != null ? index! : viewModel.currentIndex,
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
              'assets/images/icons/locationIcon.svg',
              color: kcPrimaryColor,
            ),
            label: '',
            icon: SvgPicture.asset(
              'assets/images/icons/locationIcon.svg',
              color: Colors.grey[600],
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/centerplus.svg',
            ),
            label: '',
            icon: SvgPicture.asset(
              'assets/images/icons/centerplus.svg',
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
    );
  }

  @override
  bool get disposeViewModel => false;

  @override
  BottomNavBarViewModel viewModelBuilder(BuildContext context) =>
      locator<BottomNavBarViewModel>();

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        log(index.toString());
        return const IndexView();
      case 1:
        log(index.toString());
        return const PinDropMapView();
      case 2:
        log(index.toString());
        return const AddRecipeView();
      case 3:
        log(index.toString());
        return const ChatListView();
      case 4:
        log(index.toString());
        return const ProfileView();
      default:
        return const Text('On Index Number  4');
    }
  }
}
