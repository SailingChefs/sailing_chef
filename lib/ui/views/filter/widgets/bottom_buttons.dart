import 'package:flutter/widgets.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';
import 'package:stacked/stacked.dart';

class BottomButtons extends ViewModelWidget<FilterViewModel> {
  
  const BottomButtons({super.key});


  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
    return Container(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 20, bottom: 25),
      decoration: BoxDecoration(
        color: kcPrimaryColorDark.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RoundedElevatedButton(
            onPressed: viewModel.reset,
            buttonText: 'Reset',
            isEnabled: true,
            buttonColor: kcPrimaryColor,
            textColor: kcVeryLightGrey,
            width: MediaQuery.sizeOf(context).width * 0.42,
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          RoundedElevatedButton(
            onPressed:() => viewModel.apply (),
            buttonText: 'Apply',
            isEnabled: true,
            textColor: kcPrimaryColor,
            width: MediaQuery.sizeOf(context).width * 0.42,
            height: MediaQuery.sizeOf(context).height * 0.04,
            buttonColor: kcVeryLightGrey,
          )
        ],
      ),
    );
  }
}
