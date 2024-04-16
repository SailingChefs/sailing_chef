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
            indent: 60.dg,
            endIndent: 20,
            color: kclightgreencolor,
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
            indent: 20,
            endIndent: 60.dg,
            color: kclightgreencolor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
