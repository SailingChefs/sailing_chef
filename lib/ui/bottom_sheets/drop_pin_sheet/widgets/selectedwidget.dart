import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/drop_pin_sheet_sheet_model.dart';

class SelectedWidgetPinDrop extends ViewModelWidget<DropPinSheetSheetModel> {
  final String selectedTabSelection;
  final int index;
  final VoidCallback selection;
  const SelectedWidgetPinDrop({
    required this.selectedTabSelection, required this.index, required this.selection, super.key,
  });

  @override
  Widget build(BuildContext context, DropPinSheetSheetModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.handleTabSelection(selectedTabSelection);
        selection;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.dg, vertical: 12.dg),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.dg),
          ),
          color: viewModel.selectedTabSelections.contains(selectedTabSelection)
              ? kcPrimaryColorDark
              : kcVeryLightGrey.withOpacity(0.4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedTabSelection,
              style: globalTextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: viewModel.selectedTabSelections
                        .contains(selectedTabSelection)
                    ? kcVeryLightGrey
                    : kcBlackColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
