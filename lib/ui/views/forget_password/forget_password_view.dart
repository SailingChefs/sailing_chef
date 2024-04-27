import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/imports/core_imports.dart';
import '../../widgets/custom_textbtn.dart';
import '../../widgets/rounded_elevated_button.dart';
import '../../widgets/rounded_tranparent_textfield.dart';
import 'forget_password_viewmodel.dart';

class ForgetPasswordView extends StackedView<ForgetPasswordViewModel> {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgetPasswordViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kcBackgroundColor,
        body: Stack(
          children: [
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
                      CircleAvatar(
                          backgroundColor: Colors.transparent.withOpacity(0.4),
                          radius: 16.r,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              size: 16.r,
                              color: Colors.white,
                            ),
                          )),
                      SizedBox(
                        width: 150.w,
                        height: 80.h,
                        child: Image.asset(
                          'assets/images/logo/SAILING CHEFS.png',
                        ),
                      ),
                      const SizedBox()
                    ],
                  ),
                  verticalSpace(MediaQuery.of(context).size.height * 0.088),
                  Text(
                    'Forget Password',
                    style: globalTextStyle(
                        fontSize: 20.sp,
                        color: kcWhiteColor,
                        fontWeight: FontWeight.w600),
                  ),
                  verticalSpace(MediaQuery.of(context).size.height * 0.015),
                  Text(
                    'Enter Email Address to recover Password',
                    style: globalTextStyle(
                        fontSize: 11.sp,
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                              color: kcBackgroundColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(50)),
                          child: CustomTextButton(
                            onPressed: () {
                              viewModel.sendEmailLink(
                                  email: viewModel.emailController.text);
                            },
                            buttonText: 'Send',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            textColor: kcWhiteColor,
                          ),
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
          ],
        ));
  }

  @override
  ForgetPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgetPasswordViewModel();
}
