import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class RoundedTransparentTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool obscureText;
  final bool? suffixIconbool;
  final bool? prefixIcon;
  final IconData? suffixIconData;
  final IconData? prefixIconData;
  final bool? isPasswordVisible;
  final double? borderRadius;
  final Color? fillColor;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final Color? textColor;
  final void Function(String)? onChanged;
  final void Function()? onVisibilityToggle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final double? size;
  final bool? ispassvisible;
  final TextStyle? style;
  final FocusNode? focsNode;
  // When false, long-press selection (and thus accidental focus via long-press-drag) is disabled.
  final bool? enableInteractiveSelection;

  const RoundedTransparentTextField({
    super.key,
    this.controller,
    this.style,
    this.suffixIcon,
    this.readOnly,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIconbool = false,
    this.isPasswordVisible,
    this.onVisibilityToggle,
    this.validator,
    this.borderRadius,
    this.fillColor,
    this.textColor,
    this.prefixIcon,
    this.onChanged,
    this.suffixIconData,
    this.prefixIconData,
    this.borderColor,
    this.maxLength,
    this.maxLines,
    this.size,
    this.ispassvisible,
    this.maxLengthEnforcement,
    this.inputFormatters,
    this.focsNode,
    this.enableInteractiveSelection = false,
  });

  @override
  Widget build(BuildContext context) {
    const close = 'assets/images/icons/eye_button_close.png';
    final Widget closeEye = Image.asset(
      close,
      color: kcWhiteColor,
      width: 2.w,
      height: 6.h,
    );
    const open = 'assets/images/icons/eye_button.png';
    final Widget openEye = Image.asset(
      open,
      color: kcBlackColor.withOpacity(0.4),
      width: 2.w,
      height: 6.h,
    );
    final inputFormattersList = inputFormatters ?? [];
    if (maxLength != null) {
      inputFormattersList.add(LengthLimitingTextInputFormatter(maxLength));
    }
    return TextFormField(
      readOnly: readOnly ?? false,
      cursorColor: kcPrimaryColor,
      // Removing `showCursor: true` so only the focused field displays a cursor.
      // Forcing it to true made multiple text fields show cursors simultaneously.
      onChanged: onChanged,
      obscureText: obscureText,
      focusNode: focsNode,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      validator: validator,
      inputFormatters: inputFormattersList,
      enableInteractiveSelection: enableInteractiveSelection,
      style: style ??
          globalTextStyle(
              fontSize: 13.sp,
              color: textColor ?? kcWhiteColor,
              fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: globalTextStyle(
            fontSize: 14.sp,
            color: textColor ?? kcWhiteColor,
            fontWeight: FontWeight.w500),
        filled: true,
        fillColor: fillColor ?? kcwhitecolor.withOpacity(0.3),
        labelStyle: globalTextStyle(
            fontSize: 14.sp,
            color: textColor ?? kcWhiteColor,
            fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide:
              BorderSide(color: borderColor ?? kcWhiteColor.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide:
              BorderSide(color: borderColor ?? kcWhiteColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
          borderSide:
              BorderSide(color: borderColor ?? kcWhiteColor.withOpacity(0.2)),
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
          horizontal: 15.0,
        ),
        prefixIcon: (prefixIcon ?? false)
            ? Icon(
                prefixIconData,
                color: editIconColor,
                size: size ?? 16,
              )
            : null,
        suffixIcon: suffixIcon ??
            (suffixIconbool == false
                ? null
                : GestureDetector(
                    onTap: onVisibilityToggle,
                    child: (ispassvisible ?? false) ? closeEye : openEye)),
      ),
    );
  }
}
