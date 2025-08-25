import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField(
      {required this.hintText,
      super.key,
      this.prefix,
      this.postfix,
      this.width});

  final String hintText;
  final IconData? prefix;
  final IconData? postfix;
  final double? width;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: RoundedTransparentTextField(
              labelText: hintText,
              textColor: kcBlackColor.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }
}
