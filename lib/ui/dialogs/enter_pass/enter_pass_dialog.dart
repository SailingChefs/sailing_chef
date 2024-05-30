import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';
import 'enter_pass_dialog_model.dart';

class EnterPassDialog extends StackedView<EnterPassDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EnterPassDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EnterPassDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: kcWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please Enter Your Password to Continue',
              textAlign: TextAlign.center,
              style: globalTextStyle(
                color: kcBlackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            RoundedTransparentTextField(
              controller: viewModel.passwordController,
              labelText: 'password',
             
              textColor: kcBlackColor.withOpacity(0.6),
              ispassvisible: viewModel.showPassword,
              onChanged: (value) => viewModel.rebuildUi(),
              fillColor: kcBlackColor.withOpacity(0.1),
              keyboardType: TextInputType.visiblePassword,
              obscureText: !viewModel.showPassword,
              suffixIconbool: true,
              isPasswordVisible: viewModel.showPassword,
              onVisibilityToggle: () {
                viewModel.passwordVisibility();
                viewModel.showPassword;
              },
              // validator: viewModel.validatePassword,
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
              onTap: () {
                completer(DialogResponse(confirmed: true));
                // viewModel.toSettings();
                },
              child: Container(
                height: 40,
                // width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child:  Text(
                  'Cancel',
                  style: globalTextStyle(
                    color: kcWhiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
                GestureDetector(
                  onTap: viewModel.deleteAccount,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kcErrorColor),
                    ),
                    child: Text(
                      'Delete',
                      style: globalTextStyle(
                        color: kcErrorColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
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
  EnterPassDialogModel viewModelBuilder(BuildContext context) =>
      EnterPassDialogModel();
}
