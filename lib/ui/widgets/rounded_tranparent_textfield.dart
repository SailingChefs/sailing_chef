// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class RoundedTransparentTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final bool? suffixIcon;
  final bool? prefixIcon;
  final Icon? suffixIconData;
  final Icon? prefixIconData;
  final bool? isPasswordVisible;
  final double? borderRadius;
  final Color? fillColor;
  final Color? textColor;
  final Function(String)? onChanged;
  final Function()? onVisibilityToggle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;

  const RoundedTransparentTextField({
    Key? key,
    this.controller,
    this.readOnly = false,
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
    this.prefixIcon,
    this.onChanged,
    this.suffixIconData,
    this.prefixIconData, this.borderColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,
      onChanged: onChanged,
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
          borderSide: BorderSide(color: borderColor?? kcWhiteColor.withOpacity(0.2)),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide: BorderSide(color:  borderColor?? kcWhiteColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide: BorderSide(
              color:  borderColor?? kcWhiteColor.withOpacity(0.2)), // Unfocused border color
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
        prefix: prefixIconData,
        suffix: suffixIconData,
        suffixIcon: suffixIcon == false
            ? null
            : GestureDetector(
                onTap: onVisibilityToggle,
                child: Image.asset('assets/images/icons/eye_button.png')),
      ),
    );
  }
}
