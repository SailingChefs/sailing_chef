import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/ui/dialogs/delete_account/delete_account_dialog_model.dart';

class DeleteAccountDialog extends StackedView<DeleteAccountDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeleteAccountDialog({
    required this.request, required this.completer, super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    DeleteAccountDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      alignment: Alignment.bottomRight,
      backgroundColor: kcWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you Sure you want to delete your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: viewModel.isGoogleSignInUser(
                          FirebaseAuth.instance.currentUser!)
                      ? viewModel.sureDeltete
                      : viewModel.deleteAccount,
                  child: Container(
                    height: 40,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                        color: kcWhiteColor,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: kcErrorColor,
                        )),
                    child: Center(
                      child: Text(
                        'Yes',
                        style: globalTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: kcErrorColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    completer(DialogResponse(confirmed: true));
                    // viewModel.saveButton(recipe, images, path);
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kcPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'No',
                        style: globalTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kcWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  DeleteAccountDialogModel viewModelBuilder(BuildContext context) =>
      DeleteAccountDialogModel();
}
