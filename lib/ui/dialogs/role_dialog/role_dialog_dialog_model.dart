import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/user_services.dart';

class RoleDialogDialogModel extends BaseViewModel {
  String selectedSignUpAs = 'guest';
  final UserServices _userServices = UserServices();
  void handleSignUpAs(int index) {
    switch (index) {
      case 0:
        selectedSignUpAs = 'guest';
        break;
      case 1:
        selectedSignUpAs = 'culinarySchool';
        break;
      case 2:
        selectedSignUpAs = 'chef';
        break;

      default:
        break;
    }

    // Update the user's role
    userDetails!.userRole = selectedSignUpAs;

    // Store the user's role in the database
    _userServices.storeUserRole(userDetails!);
  }
}
