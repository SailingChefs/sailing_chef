import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';

class PrimaryColorRoundedElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  const PrimaryColorRoundedElevatedButton(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return RoundedElevatedButton(
      onPressed: onPressed,
      buttonText: buttonText,
      isEnabled: true,
      buttonColor: kcPrimaryColor,
      width: 113.w,
      textColor: kcWhiteColor,
    );
  }
}
