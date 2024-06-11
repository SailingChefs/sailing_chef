import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class TopBarChatListScreen extends StatelessWidget {
  const TopBarChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/icons/logoo.svg',
      height: 29.h,
      width: 180,
      fit: BoxFit.cover,
    );
  }
}
