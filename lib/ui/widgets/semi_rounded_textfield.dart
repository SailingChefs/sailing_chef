import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class SemiRoundedTranpaentTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;

  const SemiRoundedTranpaentTextField(
      {super.key,
      this.validator,
      this.keyboardType,
      this.inputFormatters,
      this.controller,
      required this.labelText,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return RoundedTransparentTextField(
      labelText: labelText,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      fillColor: Colors.grey.withOpacity(0.2),
      borderRadius: 10.dg,
      textColor: Colors.black.withOpacity(0.6),
      
    );
  }
}
