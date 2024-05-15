import 'package:sailing_chefs/core/imports/core_imports.dart';

class BackArrowWidget extends StatelessWidget {
  final void Function() onTap;
  const BackArrowWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8.0.dg),
        height: 25.h,
        width: 25.w,
        decoration: BoxDecoration(
          color: kcsgreycolor.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: kcBlackColor,
          size: 19.sp,
        ),
      ),
    );
  }
}
