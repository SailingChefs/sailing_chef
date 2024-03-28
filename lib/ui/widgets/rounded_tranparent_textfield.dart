// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class RoundedTransparentTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final bool? suffixIcon;
  final bool? prefixIcon;
  final bool? isPasswordVisible;
  final double? borderRadius;
  final Color? fillColor;
  final Color? textColor;
  final Function()? onVisibilityToggle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const RoundedTransparentTextField({
    Key? key,
    this.controller,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon = false,
    this.isPasswordVisible,
    this.onVisibilityToggle,
    this.inputFormatters,
    this.validator,
    this.borderRadius,
    this.fillColor,
    this.textColor,
    IconData? prefix,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: controller,
      validator: validator,
      style: TextStyle(fontSize: 12.sp, color: textColor ?? kcWhiteColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? kcVeryLightGrey.withOpacity(0.2),
        labelStyle:
            TextStyle(fontSize: 14.sp, color: textColor ?? kcWhiteColor),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide: BorderSide(
              color: kcWhiteColor.withOpacity(0.2)), // Unfocused border color
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide: const BorderSide(
            color: kcErrorColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide: const BorderSide(
            color: kcErrorColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        suffixIcon: suffixIcon == false
            ? null
            : GestureDetector(
                onTap: onVisibilityToggle,
                child: Image.asset('assets/images/icons/eye_button.png')),
        prefix: prefixIcon == false
            ? null
            : GestureDetector(
                onTap: onVisibilityToggle,
                child: Icon(
                  Icons.add,
                  color: kcBlackColor,
                ),
              ),
      ),
    );
  }
}
