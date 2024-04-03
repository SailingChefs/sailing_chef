import 'package:sailing_chefs/core/imports/core_imports.dart';

class FollowBtuton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final IconData? prefix, postfix;

  const FollowBtuton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.fontSize = 14,
    this.textColor = kcWhiteColor,
    this.fontWeight = FontWeight.normal,
    this.prefix,
    this.postfix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 155.w,
        height: 40.h,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kcPrimaryColor,
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
