// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/add_recipe_session_service.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_view.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_viewmodel.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart';
import 'package:sailing_chefs/ui/views/index/index_view.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_view.dart';
import 'package:sailing_chefs/ui/views/profile/profile_view.dart';

class BottomNavBarView extends StackedView<BottomNavBarViewModel> {
  final int? index;

  const BottomNavBarView({this.index, super.key});

  @override
  Widget builder(BuildContext context, BottomNavBarViewModel viewModel, Widget? child) {
    final dialogService = locator<DialogService>();
    final addRecipeSessionService = locator<AddRecipeSessionService>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getViewForIndex(index ?? viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kcWhiteColor,
        selectedItemColor: kcPrimaryColor,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        selectedIconTheme: const IconThemeData(color: kcPrimaryColor),
        unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 10),
        selectedLabelStyle: const TextStyle(color: kcPrimaryColor, fontSize: 10),
        currentIndex: index ?? viewModel.currentIndex,
        onTap: (newTabIndex) async {
          if (viewModel.currentIndex == 2 &&
              newTabIndex != 2 &&
              addRecipeSessionService.shouldPromptOnExit) {
            final dialogData = addRecipeSessionService.getDialogData();
            if (dialogData == null || (dialogData['images'] as List).isEmpty) {
              viewModel.setIndex(newTabIndex);
              return;
            }
            final response = await dialogService.showCustomDialog<dynamic, dynamic>(
              variant: DialogType.saveDraftAlertbox,
              title: 'Do you want to save it for later?',
              data: dialogData,
            );
            if (!(response?.confirmed ?? false)) {
              return;
            }
          }
          viewModel.setIndex(newTabIndex);
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/homeselected.svg',
              color: kcPrimaryColor,
            ),
            label: 'Home',
            icon: SvgPicture.asset(
              'assets/images/icons/homeselected.svg',
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/locationIcon.svg',
              color: kcPrimaryColor,
            ),
            label: 'Map',
            icon: SvgPicture.asset(
              'assets/images/icons/locationIcon.svg',
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/centerplus.svg',
            ),
            label: 'Add',
            icon: SvgPicture.asset(
              'assets/images/icons/centerplus.svg',
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/chat.svg',
              color: kcPrimaryColor,
            ),
            label: 'Messages',
            icon: SvgPicture.asset(
              'assets/images/icons/chat.svg',
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/profile.svg',
              color: kcPrimaryColor,
            ),
            label: 'Profile',
            icon: SvgPicture.asset(
              'assets/images/icons/profile.svg',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get disposeViewModel => false;

  @override
  BottomNavBarViewModel viewModelBuilder(BuildContext context) => locator<BottomNavBarViewModel>();

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
