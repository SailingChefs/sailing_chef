import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_view.dart';
import 'package:sailing_chefs/ui/views/chat/chat_view.dart';
import 'package:sailing_chefs/ui/views/index/index_view.dart';
import 'package:sailing_chefs/ui/views/profile/profile_view.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_view.dart';
import 'bottom_nav_bar_viewmodel.dart';

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavBarViewModel>.reactive(
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
      ),
      viewModelBuilder: () => BottomNavBarViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const IndexView();
      case 1:
        return const SavedRecipesView();
      case 2:
        return const AddRecipeView();
      case 3:
        return const ChatView();
      case 4:
        return const ProfileView();
      default:
        return const Text('On Index Number  4');
    }
  }
}
