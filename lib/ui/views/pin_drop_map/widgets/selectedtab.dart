import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';

class SelectedWidgetPinDrop extends ViewModelWidget<PinDropMapViewModel> {
  final String selectedTabSelection;
  final int index;
  final VoidCallback selection;
  const SelectedWidgetPinDrop({
    super.key,
    required this.selectedTabSelection,
    required this.index,
    required this.selection,
  });

  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.handleTagSelection(selectedTabSelection);
        selection;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.dg, vertical: 12.dg),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.dg),
          ),
          color: viewModel.tagTabSelections.contains(selectedTabSelection)
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
                color: viewModel.tagTabSelections
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
