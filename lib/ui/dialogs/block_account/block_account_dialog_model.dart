import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/block_user_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_view.dart';
import '../../common/show_toast.dart';

class BlockAccountDialogModel extends BaseViewModel {
  final Function(DialogResponse) completer;
  BlockAccountDialogModel({required this.completer});
  final _navigationService = locator<NavigationService>();
  final _blockedAccountService = locator<BlockUserService>();
  final _recipeService = locator<RecipeService>();

  void blockAccount(UserModel user) async {
    bool check =
        await _blockedAccountService.updateBlockedAccounts([user.uid!], user);
    check
        ? showToast(message: "Account Blocked")
        : showToast(message: "Problem blocking Account");
    _recipeService.isInitialized = false;
    await _recipeService.initialized();
    //  if(check == true){

    //     completer(SheetResponse(
    //         confirmed: true,
    //         data: check) as DialogResponse);

    _navigationService.clearStackAndShowView(
      const BottomNavBarView(),
    );
  }
}
