import 'package:sailing_chefs/core/imports/core_imports.dart';

class LablesText extends StatelessWidget {
  const LablesText({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Text(text,
          style: globalTextStyle(
            fontSize: 14.sp,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w500,
            color: editTextColor,
          )),
    );
  }
}
