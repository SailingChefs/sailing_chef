import 'package:sailing_chefs/core/imports/core_imports.dart';

class ChatListViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void toChatScreen() {
    _navigationService.navigateToChatView();
  }
}
