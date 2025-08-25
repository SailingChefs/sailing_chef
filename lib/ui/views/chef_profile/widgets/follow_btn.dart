import 'package:sailing_chefs/core/imports/core_imports.dart';

class FollowBtuton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final IconData? prefix;
  final IconData? postfix;

  const FollowBtuton({
    required this.onPressed,
    required this.buttonText,
    super.key,
    this.fontSize = 14,
    this.textColor = kcWhiteColor,
    this.fontWeight = FontWeight.normal,
    this.prefix,
    this.postfix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 155.w,
        height: MediaQuery.of(context).size.height * 0.05,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonText == 'Following'
                ? kcPrimaryColorDark.withOpacity(0.5)
                : kcPrimaryColorDark,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                prefix,
                color: kcwhitecolor,
                size: 20.sp,
              ),
              Text(
                buttonText,
                style: globalTextStyle(
                  fontSize: fontSize.sp,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
              ),
              Icon(
                postfix,
                color: kcwhitecolor,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
