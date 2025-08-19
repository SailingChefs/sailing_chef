import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'long_press_comment_dialog_model.dart';

class LongPressCommentDialog extends StackedView<LongPressCommentDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const LongPressCommentDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LongPressCommentDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)), // Increased corner radius
      backgroundColor: Colors.white,
      elevation: 10, // Adding shadow for depth
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 25, vertical: 20), // Increased padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => completer(DialogResponse(confirmed: true)),
                child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor:
                        Colors.grey.shade200, // Softer background color
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ),
            ),
            // Adding space
            ListTile(
              onTap: () {
                viewModel.editOrDelete(true);
              },
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                // Circle background for icons
                radius: 20,
                backgroundColor:
                    kcPrimaryColor.withOpacity(0.1), // Softer background
                child: const Icon(
                  Icons.edit,
                  color: kcPrimaryColor,
                ),
              ),
              title: Text(
                "Edit",
                style: TextStyle(
                    fontSize: 20.sp, // Increased font size for readability
                    fontWeight: FontWeight.w700,
                    color: kcPrimaryColor),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 4,
                )),
            ListTile(
              onTap: () {
                viewModel.editOrDelete(false);
              },
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                // Circle background for delete icon
                radius: 20,
                backgroundColor:
                    kcErrorColor.withOpacity(0.1), // Softer red background
                child: const Icon(
                  Icons.delete,
                  color: kcErrorColor,
                ),
              ),
              title: Text(
                "Delete",
                style: TextStyle(
                    fontSize: 20.sp, // Increased font size for readability
                    fontWeight: FontWeight.w700,
                    color: kcErrorColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  LongPressCommentDialogModel viewModelBuilder(BuildContext context) =>
      LongPressCommentDialogModel(completer: completer);
}
