import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/dialogs/block_account/block_account_dialog_model.dart';

class BlockAccountDialog extends StackedView<BlockAccountDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const BlockAccountDialog({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    BlockAccountDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      backgroundColor: kcWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you Sure you want to block this account?',
              textAlign: TextAlign.center,
              style: globalTextStyle(
                fontSize: 15.sp,
                color: kcBlackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpaceMedium,
            verticalSpaceTiny,
            FittedBox(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => completer(DialogResponse(confirmed: true)),
                    child: Container(
                      height: 45,
                      width: screenWidth(context) * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: kcPrimaryColor),
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: kcPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpaceMedium,
                  GestureDetector(
                    onTap: () {
                      viewModel.blockAccount(request.data as UserModel);
                    },
                    child: Container(
                      height: 45,
                      width: screenWidth(context) * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kcPrimaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BlockAccountDialogModel viewModelBuilder(BuildContext context) =>
      BlockAccountDialogModel(completer: completer);
}
