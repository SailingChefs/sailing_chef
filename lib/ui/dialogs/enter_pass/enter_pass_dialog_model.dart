
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class EnterPassDialogModel extends BaseViewModel {
  final _userService = locator<UserServices>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final TextEditingController passwordController = TextEditingController();
 bool  showPassword = false;
  void passwordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
    rebuildUi();
  }
  
  void deleteAccount() async {
   
   bool check = await _userService.checkPassword(passwordController.text);

 
   if(check == true ){
       bool deleted = await _userService.deleteUserAndDocument(passwordController.text);

    deleted
        ? showToast(message: 'Account Deleted Permanently')
        : showToast(message: 'Account Deletion was interrupted');

    if (deleted == true) {
      await _authService.signOut();
      _navigationService.replaceWithLoginView();
    }
  }
   else{
     showToast(message: 'Wrong Password');
   }
  
}
}