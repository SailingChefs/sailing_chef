import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/supplier_sign_up/supplier_sign_up_viewmodel.dart';

class SupplierStep3 extends ViewModelWidget<SupplierSignUpViewModel> {
  const SupplierStep3({super.key});

  @override
  Widget build(BuildContext context, SupplierSignUpViewModel viewModel) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      child: Form(
        key: viewModel.step3FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Almost there — create your account',
              style: globalTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: kcBlackColor.withOpacity(0.55),
              ),
            ),
            SizedBox(height: 24.h),
            _FieldLabel('Email'),
            SizedBox(height: 6.h),
            _AccountField(
              controller: viewModel.emailController,
              hint: 'your@email.com',
              keyboardType: TextInputType.emailAddress,
              validator: viewModel.validateEmail,
            ),
            SizedBox(height: 16.h),
            _FieldLabel('Password'),
            SizedBox(height: 6.h),
            _AccountField(
              controller: viewModel.passwordController,
              hint: 'At least 8 characters',
              obscureText: !viewModel.showPassword,
              validator: viewModel.validatePassword,
              suffixIcon: GestureDetector(
                onTap: viewModel.togglePasswordVisibility,
                child: Icon(
                  viewModel.showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: kcBlackColor.withOpacity(0.4),
                  size: 20,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _FieldLabel('Confirm password'),
            SizedBox(height: 6.h),
            _AccountField(
              controller: viewModel.confirmPasswordController,
              hint: 'Re-enter password',
              obscureText: !viewModel.showConfirmPassword,
              validator: viewModel.validateConfirmPassword,
              suffixIcon: GestureDetector(
                onTap: viewModel.toggleConfirmPasswordVisibility,
                child: Icon(
                  viewModel.showConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: kcBlackColor.withOpacity(0.4),
                  size: 20,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'By creating an account you agree to our Terms of Service and Privacy Policy.',
              style: globalTextStyle(
                fontSize: 11.sp,
                color: kcBlackColor.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: globalTextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: kcBlackColor.withOpacity(0.75),
      ),
    );
  }
}

class _AccountField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const _AccountField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      cursorColor: kcPrimaryColor,
      style: globalTextStyle(
        fontSize: 13.sp,
        color: kcBlackColor,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: globalTextStyle(
          fontSize: 13.sp,
          color: kcBlackColor.withOpacity(0.35),
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: kcVeryLightGrey,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 14,
        ),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: suffixIcon,
              )
            : null,
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: kcPrimaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: kcErrorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: kcErrorColor),
        ),
      ),
    );
  }
}
