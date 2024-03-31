import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField(
      {super.key, this.hintText, this.prefix, this.postfix, this.width});
  final String? hintText;
  final IconData? prefix, postfix;
  final double? width;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            prefix,
            color: kcBlackColor.withOpacity(0.5),
            size: 30.sp,
          ),
        ),
        SizedBox(
          width: width ?? 300.w,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SemiRoundedTranpaentTextField(
              controller: controller,
              labelText: '$hintText',
            ),
          ),
        ),
      ],
    );
  }
}
