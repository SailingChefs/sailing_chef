import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/sign_up/sign_up_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class SignUpForm extends ViewModelWidget<SignUpViewModel> {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          RoundedTransparentTextField(
            controller: viewModel.textController,
            labelText: 'Full name',
            onChanged: (value) => viewModel.rebuildUi(),
            validator: viewModel.validateName,
            fillColor: filledcolorlogin.withOpacity(0.3),
            keyboardType: TextInputType.name,
          ),
          verticalSpace(MediaQuery.of(context).size.height * 0.020),
          RoundedTransparentTextField(
            controller: viewModel.emailController,
            fillColor: filledcolorlogin.withOpacity(0.3),
            labelText: 'Email',
            onChanged: (value) => viewModel.rebuildUi(),
            validator: viewModel.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          verticalSpace(MediaQuery.of(context).size.height * 0.020),
          RoundedTransparentTextField(
            controller: viewModel.passwordController,
            labelText: 'Password',
            fillColor: filledcolorlogin.withOpacity(0.3),
            ispassvisible: viewModel.showPassword,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !viewModel.showPassword,
            suffixIconbool: true,
            isPasswordVisible: viewModel.showPassword,
            onChanged: (value) => viewModel.rebuildUi(),
            onVisibilityToggle: () {
              viewModel.passwordVisibility();
              viewModel.showPassword;
            },
            validator: viewModel.validatePassword,
          ),
          verticalSpace(MediaQuery.of(context).size.height * 0.040),
          RoundedElevatedButton(
            textFontSize: 12.sp,
            width: 243.12.w,
            height: 51.h,
            textColor: kclightgreencolor,
            isEnabled: viewModel.isSignupButtonEnabled(),
            onPressed: () => viewModel.signup(),
            buttonText: 'Create account',
          ),
        ],
      ),
    );
  }
}
