import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'drop_pin_buttons_sheet_model.dart';

class DropPinButtonsSheet extends StackedView<DropPinButtonsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const DropPinButtonsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DropPinButtonsSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
        width: double.infinity,
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
                      color: kcbuttoncolor.withOpacity(0.1)),
                  child: TextButton(
                    onPressed: () => completer == null
                        ? Navigator.pop(context)
                        : completer!(SheetResponse(data: false)),
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
                      color: filterIconColor),
                  child: TextButton(
                    onPressed: () => completer == null
                        ? Navigator.pop(context)
                        : completer!(SheetResponse(data: true)),
                    child: Text(
                      'Drop Pin',
                      style: globalTextStyle(
                          fontSize: 14,
                          color: kcwhitecolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  DropPinButtonsSheetModel viewModelBuilder(BuildContext context) =>
      DropPinButtonsSheetModel();
}
