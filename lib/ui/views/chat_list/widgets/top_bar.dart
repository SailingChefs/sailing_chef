import 'package:sailing_chefs/core/imports/core_imports.dart';

class TopBarChatListScreen extends StatelessWidget {
  const TopBarChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Image.asset(
        'assets/images/logo/SAILING CHEFS2.png',
      ),
      IconButton(
          onPressed: () {}, icon: const Icon(FlutterRemix.edit_box_fill)),
    ]);
  }
}
