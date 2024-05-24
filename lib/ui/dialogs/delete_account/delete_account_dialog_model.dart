import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/app.router.dart';
import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteAccountDialogModel extends BaseViewModel {
  final _userService = locator<UserServices>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  void deleteAccount() async {
   

    bool check = await _userService.deleteUserAndDocument();

    check
        ? showToast(message: 'Account Deleted Permanently')
        : showToast(message: 'Account Deletion was interrupted');

        if(check == true){
           await _authService.signOut();
            _navigationService.replaceWithLoginView();

  }
  }
}
