// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar_supplier/bottom_nav_bar_supplier_viewmodel.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart';
import 'package:sailing_chefs/ui/views/index/index_view.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_view.dart';
import 'package:sailing_chefs/ui/views/supplier_profile/supplier_profile_view.dart';

class BottomNavBarSupplierView extends StackedView<BottomNavBarSupplierViewModel> {
  const BottomNavBarSupplierView({super.key});

  @override
  Widget builder(
    BuildContext context,
    BottomNavBarSupplierViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _viewForIndex(viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kcWhiteColor,
        selectedItemColor: kcPrimaryColor,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        selectedIconTheme: const IconThemeData(color: kcPrimaryColor),
        unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 10),
        selectedLabelStyle: const TextStyle(color: kcPrimaryColor, fontSize: 10),
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.setIndex,
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

  Widget _viewForIndex(int index) {
    switch (index) {
      case 0:
        return const IndexView();
      case 1:
        return const PinDropMapView();
      case 2:
        return const ChatListView();
      case 3:
        return SupplierProfileView(supplier: userDetails!, isSelf: true);
      default:
        return const IndexView();
    }
  }

  @override
  BottomNavBarSupplierViewModel viewModelBuilder(BuildContext context) =>
      BottomNavBarSupplierViewModel();
}
