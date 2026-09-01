import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';

class ButtonsDropPin extends ViewModelWidget<PinDropMapViewModel> {
  const ButtonsDropPin({super.key});

  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return Positioned(
      bottom: 70.h,
      left: 0,
      right: 0,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          width: double.infinity,
          height: 85.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: 42,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kcButtonColor.withOpacity(0.1)),
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
                      borderRadius: BorderRadius.circular(30),
                      color: kcPrimaryColor),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
          )),
    );
  }
}
