// ignore_for_file: camel_case_types

import 'package:sailing_chefs/core/imports/core_imports.dart';

class SaveRecipeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final IconData? prefix, postfix;

  const SaveRecipeButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
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
        width: 310.w,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kclightgreencolor,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                prefix,
                color: kcsgreycolor,
                size: 20.sp,
              ),
              horizontalSpaceSmall,
              Text(
                buttonText,
                style: globalTextStyle(
                  fontSize: fontSize.sp,
                  color: textColor,
                  letterSpacing: -0.5,
                  fontWeight: fontWeight,
                ),
              ),
              horizontalSpaceSmall,
              Icon(
                postfix,
                color: kcsgreycolor,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
