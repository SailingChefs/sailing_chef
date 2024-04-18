
import 'package:sailing_chefs/ui/views/sign_up/component/roleselector_compnent.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

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
                        width: 103.dg,
                        height: 34,
                        textFontSize: 14.sp,
                        textFontWeight: FontWeight.w600,
                        textColor: kclightgreencolor,
                        onPressed: () {
                          viewModel.toLogin();
                        },
                        buttonText: 'login',
                        isEnabled: true,
                      ),
                    ],
                  ),
                  verticalSpace(MediaQuery.of(context).size.height * 0.05),
                  SingleChildScrollView(
                    child: Column(
                      
                      children: [
                        Text(
                          'Lets create your account',
                          style: globalTextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                        verticalSpace(MediaQuery.of(context).size.height * 0.010),
                        Text(
                          'sign up as',
                          style: globalTextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        verticalSpace(MediaQuery.of(context).size.height * 0.028),
                        RoleSelector(viewModel: viewModel),
                        verticalSpace(MediaQuery.of(context).size.height * 0.05),
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
                              verticalSpace(
                                  MediaQuery.of(context).size.height * 0.020),
                              RoundedTransparentTextField(
                                controller: viewModel.emailController,
                                labelText: 'Email',
                                validator: viewModel.validateEmail,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              verticalSpace(
                                  MediaQuery.of(context).size.height * 0.020),
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
                              verticalSpace(
                                  MediaQuery.of(context).size.height * 0.040),
                              RoundedElevatedButton(
                                textFontSize: 12.sp,
                                width: 240.w,
                                height: 34.h,
                                borderRadius: 30,
                                textColor: kclightgreencolor,
                                isEnabled: viewModel.isSignupButtonEnabled(),
                                onPressed: () {
                                  viewModel.signup();
                                },
                                buttonText: 'create account',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // verticalSpace(MediaQuery.of(context).size.height*0.030),
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  //   child: OrDesign(),
                  // ),
                  // verticalSpace(MediaQuery.of(context).size.height*0.070),
                  // GestureDetector(
                  //   onTap: viewModel.toLogin,
                  //   child: RichText(
                  //     text: TextSpan(
                  //       children: <TextSpan>[

                  //         TextSpan(
                  //           text: 'login',
                  //           style: globalTextStyle(
                  //             color: kcwhitecolor,
                  //             fontWeight: FontWeight.w600, fontSize: 16.sp,
                  //           ),
                  //         ),

                  //         TextSpan(
                  //           text: ' to existing account',
                  //           style: globalTextStyle(
                  //             color: kcwhitecolor,
                  //             fontWeight: FontWeight.w400, fontSize: 16.sp,
                  //           ),
                  //         ),

                  //       ],
                  //     ),
                  //   ),
                  // ),
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
