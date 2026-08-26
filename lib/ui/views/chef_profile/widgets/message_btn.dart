// ignore_for_file: prefer_const_constructors

import 'package:sailing_chefs/core/imports/core_imports.dart';

class MessageBtuton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final IconData? prefix, postfix;

  const MessageBtuton({
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
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(
            color: filterIconColor,
          )),
          onPressed: onPressed,
          child: FittedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                    color: filterIconColor,
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
      ),
    );
  }
}
