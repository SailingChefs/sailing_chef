import 'package:sailing_chefs/core/imports/core_imports.dart';

class RoundedElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double textFontSize;
  final Color textColor;
  final FontWeight textFontWeight;
  final bool isEnabled;

  const RoundedElevatedButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.width,
    this.height,
    this.borderRadius = 30,
    this.buttonColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.textFontSize = 16, // Adjust the default font size
    this.textColor = kcTextColor,
    this.textFontWeight = FontWeight.w400,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth.w,
          ),
        ),
        backgroundColor: buttonColor ?? kcWhiteColor,
        disabledBackgroundColor: kcPrimaryColor.withOpacity(0.2),
        fixedSize: Size(width ?? 231.w, height ?? 41.h),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.0.dg),
        child: Text(
          buttonText,
          style: globalTextStyle(
            fontSize: textFontSize.sp,
            color: isEnabled ? textColor : kcPrimaryColor.withOpacity(0.5),
            fontWeight: textFontWeight,
          ),
        ),
      ),
    );
  }
}
