import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_view.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart';
import 'package:sailing_chefs/ui/views/index/index_view.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_view.dart';
import 'package:sailing_chefs/ui/views/profile/profile_view.dart';

import 'bottom_nav_bar_viewmodel.dart';

class BottomNavBarView extends StackedView<BottomNavBarViewModel> {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  Widget builder(context, viewModel, child) {
    return Scaffold(
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
              Icons.pin_drop_sharp,
              color: kcDarkColor,
            ),
            label: '',
            icon: Icon(
              Icons.pin_drop_outlined,
              color: kcMediumGrey,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              FlutterRemix.add_circle_fill,
              color: kcDarkColor,
              size: 48,
            ),
            label: '',
            icon: Icon(
              FlutterRemix.add_circle_fill,
              color: kcDarkColor,
              size: 48,
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
    );
  }

  @override
  BottomNavBarViewModel viewModelBuilder(BuildContext context) =>
      locator<BottomNavBarViewModel>();

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const IndexView();
      case 1:
        return const PinDropMapView();
      case 2:
        return const AddRecipeView(
          isFromProfileView: false,
        );
      case 3:
        return const ChatListView();
      case 4:
        return const ProfileView();
      default:
        return const Text('On Index Number  4');
    }
  }
}
