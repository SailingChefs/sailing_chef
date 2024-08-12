import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/forget_password/forget_topBar.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

import 'forget_password_viewmodel.dart';

class ForgetPasswordView extends StackedView<ForgetPasswordViewModel> {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgetPasswordViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/background/back_screen.png'),
                    fit: BoxFit.fill)),
          ),
          Positioned.fill(
            child: Container(
              height: screenHeight(context),
              width: screenWidth(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background/back.png'),
                      fit: BoxFit.fill)),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 35.0.dg, left: 20.dg, right: 20.dg),
                child: Column(children: [
                  const ForgetPasswordTopBar(),
                  verticalSpaceLarge,
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Forget Password',
                          style: globalTextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.010),
                        Text(
                          'Enter your email and we will send you a link to reset your password',
                          textAlign: TextAlign.center,
                          style: globalTextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        verticalSpaceLarge,
                        RoundedTransparentTextField(
                          controller: viewModel.emailController,
                          labelText: 'email',
                          onChanged: (value) => viewModel.rebuildUi(),
                          validator: viewModel.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        verticalSpaceLarge,
                        RoundedElevatedButton(
                          width: 243.12.w,
                          height: 51.h,
                          textFontSize: 18.sp,
                          textFontWeight: FontWeight.w500,
                          textColor: kcPrimaryColor,
                          borderRadius: 30,
                          isEnabled: viewModel.isSignupButtonEnabled(),
                          buttonText: 'send link',
                          onPressed: () => viewModel.sendEmailLink(
                              email: viewModel.emailController.text),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  ForgetPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgetPasswordViewModel();
}
