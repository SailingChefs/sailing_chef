import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';
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
                        width: screenWidth(context) * 0.3,
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
                          fillColor: filledcolorlogin.withOpacity(0.3),
                          labelText: 'email',
                          validator: viewModel.validateEmail,
                          onChanged: (value) => viewModel.rebuildUi(),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.027),
                        RoundedTransparentTextField(
                          controller: viewModel.passwordController,
                          labelText: 'password',
                          ispassvisible: viewModel.showPassword,
                          onChanged: (value) => viewModel.rebuildUi(),
                          fillColor: filledcolorlogin.withOpacity(0.3),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !viewModel.showPassword,
                          suffixIconbool: true,
                          isPasswordVisible: viewModel.showPassword,
                          onVisibilityToggle: () {
                            viewModel.passwordVisibility();
                            viewModel.showPassword;
                          },
                          validator: viewModel.validatePassword,
                        ),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.014),
                        CustomTextButton(
                          onPressed: () {
                            viewModel.vaigateToForgetPassword();
                          },
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
                  // verticalSpaceLarge,
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  //   child: OrDesign(),
                  // ),
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
