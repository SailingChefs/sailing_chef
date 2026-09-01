import 'package:sailing_chefs/core/imports/core_imports.dart';

class OrDesign extends StatelessWidget {
  const OrDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            indent: 75.dg,
            endIndent: 15,
            color: kcPrimaryColor,
            thickness: 1,
          ),
        ),
        Text(
          'or',
          style: globalTextStyle(
              fontSize: 16.sp,
              color: kcWhiteColor,
              fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: Divider(
            indent: 15,
            endIndent: 70.dg,
            color: kcPrimaryColor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
