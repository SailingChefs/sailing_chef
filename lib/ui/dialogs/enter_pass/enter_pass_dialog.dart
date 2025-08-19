import 'package:flutter/cupertino.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/dialogs/enter_pass/enter_pass_dialog_model.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class EnterPassDialog extends StackedView<EnterPassDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EnterPassDialog({
    required this.request, required this.completer, super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    EnterPassDialogModel viewModel,
    Widget? child,
  ) {
    final size = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.05),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                fillColor: kcBlackColor.withOpacity(0.06),
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
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: viewModel.vaigateToForgetPassword,
                  child: Text(
                    'forgot password?',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: kcBlackColor),
                  ),
                ),
              ),
              verticalSpaceSmall,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        child: Text(
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
              ),
            ],
          ),
        ),
      ),
    );

    // Container(
    //   color: kcwhitecolor,
    //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height * 0.3,
    //   child: Dialog(
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //     backgroundColor: kcWhiteColor,
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //           Text(
    //             'Please Enter Your Password to Continue',
    //             textAlign: TextAlign.center,
    //             style: globalTextStyle(
    //               color: kcBlackColor,
    //               fontSize: 14.sp,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           verticalSpaceSmall,
    //           RoundedTransparentTextField(
    //             controller: viewModel.passwordController,
    //             labelText: 'password',

    //             textColor: kcBlackColor.withOpacity(0.6),
    //             ispassvisible: viewModel.showPassword,
    //             onChanged: (value) => viewModel.rebuildUi(),
    //             fillColor: kcBlackColor.withOpacity(0.1),
    //             keyboardType: TextInputType.visiblePassword,
    //             obscureText: !viewModel.showPassword,
    //             suffixIconbool: true,
    //             isPasswordVisible: viewModel.showPassword,
    //             onVisibilityToggle: () {
    //               viewModel.passwordVisibility();
    //               viewModel.showPassword;
    //             },
    //             // validator: viewModel.validatePassword,
    //           ),
    //           verticalSpaceMedium,
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             mainAxisSize: MainAxisSize.max,
    //             children: [
    //               GestureDetector(
    //                 onTap: () {
    //                   completer(DialogResponse(confirmed: true));
    //                   // viewModel.toSettings();
    //                 },
    //                 child: Container(
    //                   height: 40,
    //                   // width: double.infinity,
    //                   padding: const EdgeInsets.symmetric(horizontal: 40),
    //                   alignment: Alignment.center,
    //                   decoration: BoxDecoration(
    //                     color: kcPrimaryColor,
    //                     borderRadius: BorderRadius.circular(30),
    //                   ),
    //                   child: Text(
    //                     'Cancel',
    //                     style: globalTextStyle(
    //                       color: kcWhiteColor,
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 14.sp,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               GestureDetector(
    //                 onTap: viewModel.deleteAccount,
    //                 child: Container(
    //                   height: 40,
    //                   padding: const EdgeInsets.symmetric(horizontal: 40),
    //                   alignment: Alignment.center,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(30),
    //                     border: Border.all(color: kcErrorColor),
    //                   ),
    //                   child: Text(
    //                     'Delete',
    //                     style: globalTextStyle(
    //                       color: kcErrorColor,
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 14.sp,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  EnterPassDialogModel viewModelBuilder(BuildContext context) =>
      EnterPassDialogModel();
}
