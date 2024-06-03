import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'block_account_dialog_model.dart';

class BlockAccountDialog extends StackedView<BlockAccountDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const BlockAccountDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BlockAccountDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      backgroundColor: kcWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you Sure you want to block this account?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            verticalSpaceMedium,
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
                        border: Border.all(color: const Color(0xFF1E5D6D)),
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: Color(0xFF1E5D6D),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  GestureDetector(
                    onTap: () {
                      viewModel.blockAccount(request.data);
                    },
                    child: Container(
                      height: 45,
                      width: screenWidth(context) * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E5D6D),
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
