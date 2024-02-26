import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/custom_elevatedbtn.dart';
import 'package:sailing_chefs/ui/widgets/custom_textfield.dart';
import 'package:sailing_chefs/ui/widgets/or_design.dart';
import '../../widgets/custom_textbtn.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kcBackgroundColor,
          body: Stack(children: [
            Container(
              height: screenHeight(context),
              width: screenWidth(context),
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
                      Image.asset(
                        'assets/images/logo/SAILING CHEFS.png',
                        width: 130.w,
                        height: 70.h,
                      ),
                      CustomElevatedButton(
                        onPressed: viewModel.toSignUp,
                        buttonText: 'Sign up',
                        width: 80.dg,
                        height: 14.dg,
                        textFontSize: getResponsiveLargeFontSize(context),
                        isEnabled: true,
                      )
                    ],
                  ),
                  verticalSpaceLarge,
                  Text(
                    'Welcome Back ',
                    style: globalTextStyle(
                        fontSize: 20.sp,
                        color: kcPrimaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Login Here',
                    style: globalTextStyle(
                        fontSize: 14.sp,
                        color: kcPrimaryColor,
                        fontWeight: FontWeight.w400),
                  ),
                  verticalSpaceLarge,
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: viewModel.emailController,
                          labelText: 'Email',
                          validator: viewModel.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        verticalSpaceSmall,
                        verticalSpaceTiny,
                        CustomTextField(
                          controller: viewModel.passwordController,
                          labelText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !viewModel.showPassword,
                          suffixIcon: true,
                          validator: viewModel.validatePassword,
                          onVisibilityToggle: () {
                            viewModel.passwordVisibility();
                          },
                        ),
                        verticalSpaceSmall,
                        verticalSpaceTiny,
                        CustomTextButton(
                          onPressed: () {},
                          buttonText: 'Forget Password?',
                          // other optional parameters can be provided here
                        ),
                        verticalSpaceSmall,
                        verticalSpaceTiny,
                        CustomElevatedButton(
                          onPressed: viewModel.login,
                          buttonText: 'Login',
                          width: 144.dg,
                          height: 40.dg,
                          textFontSize: getResponsiveMediumFontSize(context),
                          isEnabled: viewModel.isLoginButtonEnabled(),
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
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
