import 'package:sailing_chefs/core/imports/core_imports.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;

  const CustomTextButton({
    required this.onPressed, required this.buttonText, super.key,
    this.fontSize = 14,
    this.textColor = kcWhiteColor,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: globalTextStyle(
          fontSize: fontSize.sp,
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
