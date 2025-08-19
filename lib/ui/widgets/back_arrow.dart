import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class BackArrowWidget extends StatelessWidget {
  final void Function() onTap;
  const BackArrowWidget({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset('assets/images/icons/backbutton.svg'));
  }
}
