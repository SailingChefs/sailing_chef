import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';

class BottomButtonPinsDropView extends ViewModelWidget<PinDropMapViewModel> {
  const BottomButtonPinsDropView({super.key});

  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return Container(
      width: screenWidth(context),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                height: 42,
                width: 185,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kcButtonColor.withOpacity(0.1)),
                child: TextButton(
                  onPressed: viewModel.onCancel,
                  // => completer == null
                  //     ? Navigator.pop(context)
                  //     : completer!(SheetResponse(data: false)),
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
                width: 185,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kcPrimaryColorDark),
                child: TextButton(
                  onPressed: () {
                    viewModel.dropPin(isNew: true);
                  },
                  // => completer == null
                  //     ? Navigator.pop(context)
                  //     : completer!(SheetResponse(data: true)),
                  child: Text(
                    'Drop Pin',
                    style: globalTextStyle(
                        fontSize: 14,
                        color: kcWhiteColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
