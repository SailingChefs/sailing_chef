import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class SemiRoundedTranpaentTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? labelText;
  final bool? readOnly;
  final IconData? prefixIcon;
  final IconData? postfixIcon;
  final bool? suffixIcon;
  final bool? prefixIcons;
  final double? borderRadius;
  final int? maxLength;
  final int? maxLines;
  final Color? fillColor;
  final double? size;
  final Widget? suffixIconData;
    final MaxLengthEnforcement? maxLengthEnforcement;

  const SemiRoundedTranpaentTextField(
      {super.key,
      this.validator,
      this.fillColor,
      this.suffixIconData,
      this.keyboardType,
      this.borderRadius,
      this.inputFormatters,
      this.readOnly ,
      this.controller,
      this.labelText,
      this.prefixIcon,
      this.postfixIcon,
      this.maxLength,
      this.maxLines,
      this.size,
      this.suffixIcon,

      this.prefixIcons, this.maxLengthEnforcement});

  @override
  Widget build(BuildContext context) {
    return RoundedTransparentTextField(
      // readOnly: readOnly ,
      labelText: labelText!,
      maxLength: maxLength,
      maxLines: maxLines,
      prefixIconData: prefixIcon,
      suffixIcon: suffixIconData,
      suffixIconData: postfixIcon,
      validator: validator,
      prefixIcon: prefixIcons,
      suffixIconbool: suffixIcon,
      size: size,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      fillColor: kcPrimaryColor.withOpacity(0.08),
      borderRadius: borderRadius ?? 10.dg,
      textColor: Colors.black.withOpacity(0.6),
      controller: controller, maxLengthEnforcement: maxLengthEnforcement,
    );
  }
}
