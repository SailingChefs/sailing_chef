import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/user_services.dart';

class RoleDialogDialogModel extends BaseViewModel {
  String selectedSignUpAs = '';
  final UserServices _userServices = UserServices();
  void handleSignUpAs(int index) {
    switch (index) {
      case 0:
        selectedSignUpAs = 'guest';
      case 1:
        selectedSignUpAs = 'culinarySchool';
      case 2:
        selectedSignUpAs = 'chef';

      default:
        break;
    }

    // Update the user's role
    userDetails!.userRole = selectedSignUpAs;
    notifyListeners();

    // Store the user's role in the database
    _userServices.storeUserRole(userDetails!, selectedSignUpAs);
  }
}
