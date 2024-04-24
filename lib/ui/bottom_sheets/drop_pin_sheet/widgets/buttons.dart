import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/drop_pin_sheet_sheet_model.dart';

class ButtonsPindrop extends ViewModelWidget<DropPinSheetSheetModel> {
  final Function(SheetResponse response)? completer;
  const ButtonsPindrop({super.key, required this.completer});

  @override
  Widget build(BuildContext context, DropPinSheetSheetModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            height: 42,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kcbuttoncolor.withOpacity(0.1)),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: globalTextStyle(
                    fontSize: 14,
                    color: kcBlackColor.withOpacity(0.6),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Container(
            height: 42,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: kcPrimaryColor),
            child: TextButton(
              onPressed: () {
                viewModel.savePinDrop();
                completer!(SheetResponse(data: true));
              },
              child: Text(
                'Save',
                style: globalTextStyle(
                    fontSize: 14,
                    color: kcwhitecolor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
