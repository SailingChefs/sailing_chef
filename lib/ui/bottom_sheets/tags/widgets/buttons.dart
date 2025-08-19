import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';

class BottomButtonsTagsSheet extends ViewModelWidget<TagsSheetModel> {
  final Function(SheetResponse response)? completer;

  const BottomButtonsTagsSheet({required this.completer, super.key});

  @override
  Widget build(BuildContext context, TagsSheetModel viewModel) {
    return Container(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 20, bottom: 25),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RoundedElevatedButton(
            onPressed: () {
              viewModel.reset();
              // completer!(SheetResponse(data: true));
              Navigator.pop(context);
            },
            buttonText: 'Cancel',
            isEnabled: true,
            buttonColor: kcVeryLightGrey,
            textColor: kcBlackColor,
            width: MediaQuery.sizeOf(context).width * 0.42,
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          RoundedElevatedButton(
            onPressed: viewModel.apply,
            buttonText: 'Done',
            isEnabled: true,
            textColor: kcWhiteColor,
            width: MediaQuery.sizeOf(context).width * 0.42,
            height: MediaQuery.sizeOf(context).height * 0.04,
            buttonColor: kcPrimaryColorDark,
          )
        ],
      ),
    );
  }
}
