import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {

  
  User    user = User();

   void onViewModelReady() async {
    setBusy(true);
    user = await UserServices.getUserDetails(firebaseAuth.currentUser!.uid);

    setBusy(false);
  }
}
