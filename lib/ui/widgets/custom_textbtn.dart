import 'package:sailing_chefs/core/imports/core_imports.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.fontSize = 14,
    this.textColor = kcWhiteColor,
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);

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
