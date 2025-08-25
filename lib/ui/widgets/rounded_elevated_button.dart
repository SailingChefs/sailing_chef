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

  final String? font;

  const RoundedElevatedButton({
    required this.onPressed,
    required this.buttonText,
    required this.isEnabled,
    super.key,
    this.width,
    this.height,
    this.borderRadius = 30,
    this.buttonColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.textFontSize = 14,
    this.textColor = kcTextColor,
    this.textFontWeight = FontWeight.w400,
    this.font,
  });

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
        disabledBackgroundColor: kcWhiteColor.withOpacity(0.3),
        fixedSize: Size(width ?? 107.w, height ?? 34.h),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.0.dg),
        child: Text(
          buttonText,
          maxLines: 1,
          style: globalTextStyle(
            fontSize: textFontSize.sp,
            color: isEnabled ? textColor : kcWhiteColor.withOpacity(0.4),
            fontWeight: textFontWeight,
          ),
        ),
      ),
    );
  }
}
