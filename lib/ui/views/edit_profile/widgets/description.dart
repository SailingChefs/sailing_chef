import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class SemiRoundedTranpaentTextFieldBio extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String labelText;
  final bool? readOnly;
  final Icon? prefixIcon;
  final Icon? postfixIcon;
  final Color? fillColor;

  const SemiRoundedTranpaentTextFieldBio({
    super.key,
    this.validator,
    this.keyboardType,
    this.fillColor,
    this.inputFormatters,
    this.readOnly = false,
    this.controller,
    required this.labelText,
    this.prefixIcon,
    this.postfixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedTransparentTextField(
      readOnly: readOnly!,
      labelText: '',
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      fillColor: fillColor ?? Colors.grey.withOpacity(0.2),
      borderRadius: 27.dg,
      textColor: Colors.black.withOpacity(0.6),
      controller: controller,
    );
  }
}
