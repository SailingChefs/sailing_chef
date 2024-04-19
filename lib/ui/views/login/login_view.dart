import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';
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
                      SizedBox(
                        width: 150.w,
                        height: 80.h,
                        child: Image.asset(
                          'assets/images/logo/SAILING CHEFS.png',
                        ),
                      ),
                      RoundedElevatedButton(
                        onPressed: viewModel.toSignUp,
                        buttonText: 'sign up',
                        textColor: kclightgreencolor,
                        buttonColor: kcWhiteColor,
                        width: 103.dg,
                        height: 34,
                        textFontSize: 14.sp,
                        textFontWeight: FontWeight.w600,
                        isEnabled: true,
                      ),
                    ],
                  ),
                  verticalSpace(MediaQuery.of(context).size.height * 0.088),
                  Text(
                    'welcome back ',
                    style: globalTextStyle(
                        fontSize: 20.sp,
                        color: kcWhiteColor,
                        fontWeight: FontWeight.w600),
                  ),
                  verticalSpace(MediaQuery.of(context).size.height * 0.015),
                  Text(
                    'login here',
                    style: globalTextStyle(
                        fontSize: 16.sp,
                        color: kcWhiteColor,
                        fontWeight: FontWeight.w400),
                  ),
                  verticalSpace(MediaQuery.of(context).size.height * 0.060),
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        RoundedTransparentTextField(
                          controller: viewModel.emailController,
                          labelText: 'email',
                          validator: viewModel.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.027),
                        RoundedTransparentTextField(
                          controller: viewModel.passwordController,
                          labelText: 'password',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !viewModel.showPassword,
                          suffixIcon: true,
                          validator: viewModel.validatePassword,
                          onVisibilityToggle: () {
                            viewModel.passwordVisibility();
                          },
                        ),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.014),
                        CustomTextButton(
                          onPressed: () {},
                          buttonText: 'forget password?',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          textColor: kcWhiteColor,
                        ),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.045),
                        RoundedElevatedButton(
                          onPressed: viewModel.login,
                          textColor: kclightgreencolor,
                          buttonText: 'login',
                          width: 144.dg,
                          height: 40.dg,
                          textFontSize: 18.sp,
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
