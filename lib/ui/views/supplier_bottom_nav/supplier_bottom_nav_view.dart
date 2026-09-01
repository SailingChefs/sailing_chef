// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_view.dart';
import 'package:sailing_chefs/ui/views/supplier_profile/supplier_profile_view.dart';
import 'package:stacked/stacked.dart';

import 'supplier_bottom_nav_viewmodel.dart';

class SupplierBottomNavView extends StackedView<SupplierBottomNavViewModel> {
  const SupplierBottomNavView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SupplierBottomNavViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _getViewForIndex(viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kcWhiteColor,
        selectedItemColor: kcPrimaryColor,
        unselectedIconTheme: const IconThemeData(color: kcMediumGrey),
        selectedIconTheme: const IconThemeData(color: kcPrimaryColor),
        unselectedLabelStyle:
            const TextStyle(color: kcMediumGrey, fontSize: 10),
        selectedLabelStyle:
            const TextStyle(color: kcPrimaryColor, fontSize: 10),
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.setIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/profile.svg',
              color: kcPrimaryColor,
            ),
            label: 'My Store',
            icon: SvgPicture.asset(
              'assets/images/icons/profile.svg',
              color: Colors.grey[600],
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
              color: Colors.grey[600],
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
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const SupplierProfileView();
      case 1:
        return const PinDropMapView();
      case 2:
        return const ChatListView();
      default:
        return const SupplierProfileView();
    }
  }

  @override
  SupplierBottomNavViewModel viewModelBuilder(BuildContext context) =>
      SupplierBottomNavViewModel();
}
