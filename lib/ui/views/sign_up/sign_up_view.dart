import 'package:sailing_chefs/ui/views/sign_up/component/roleselector_compnent.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';
import 'package:sailing_chefs/ui/widgets/or_design.dart';

import '../../../core/imports/core_imports.dart';
import '../../widgets/rounded_elevated_button.dart';
import 'sign_up_viewmodel.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignUpViewModel viewModel,
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
                      image: AssetImage(
                          'assets/images/background/back_screen.png'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 80.h,
                        child: Image.asset(
                          'assets/images/logo/SAILING CHEFS.png',
                        ),
                      ),
                      RoundedElevatedButton(
                        width: 81.dg,
                        height: 34,
                        textFontSize: 14.sp,
                        textFontWeight: FontWeight.w600,
                        onPressed: () {
                          viewModel.toLogin();
                        },
                        buttonText: 'login',
                        isEnabled: true,
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  verticalSpaceSmall,
                  Text(
                    'Let\'s Create Your Account ',
                    style: globalTextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  verticalSpaceSmall,
                  Text(
                    'sign up as',
                    style: globalTextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                  verticalSpaceMedium,
                  RoleSelector(viewModel: viewModel),
                  verticalSpaceLarge,
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        RoundedTransparentTextField(
                          controller: viewModel.textController,
                          labelText: 'Name',
                          validator: viewModel.validateName,
                          keyboardType: TextInputType.name,
                        ),
                        verticalSpaceSmall,
                        verticalSpaceTiny,
                        RoundedTransparentTextField(
                          controller: viewModel.emailController,
                          labelText: 'Email',
                          validator: viewModel.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        verticalSpaceSmall,
                        verticalSpaceTiny,
                        RoundedTransparentTextField(
                          controller: viewModel.passwordController,
                          labelText: 'Password',
                          obscureText: !viewModel.showPassword,
                          suffixIcon: true,
                          isPasswordVisible: viewModel.showPassword,
                          onVisibilityToggle: () {
                            viewModel.passwordVisibility();
                          },
                          validator: viewModel.validatePassword,
                        ),
                        verticalSpaceMedium,
                        verticalSpaceSmall,
                        RoundedElevatedButton(
                          textFontSize: 12.sp,
                          width: 240.w,
                          height: 40.h,
                          borderRadius: 30,
                          isEnabled: viewModel.isSignupButtonEnabled(),
                          onPressed: () {
                            viewModel.signup();
                          },
                          buttonText: 'Create Account',
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceLarge,
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: OrDesign(),
                  ),
                ]),
              ),
            )),
          ])),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignUpViewModel();
}
