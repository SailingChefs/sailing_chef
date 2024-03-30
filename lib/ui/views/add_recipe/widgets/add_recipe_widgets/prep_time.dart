import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_textbtn.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class PrepTime extends ViewModelWidget<AddRecipeViewModel> {
  const PrepTime({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Prep Time',
              style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor),
            ),
            CustomTextButton(
                onPressed: () {},
                buttonText: 'Set time',
                textColor: kcPrimaryColor),
          ],
        ),
        Text(
          'How long does it take to cook this recipe?',
          style: globalTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kcBlackColor.withOpacity(0.5)),
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: RoundedTransparentTextField(
                controller: viewModel.prepTimeController,
                labelText: 'Prep Time',
                validator: viewModel.validatePrepTime,
                textColor: kcBlackColor.withOpacity(0.5),
                keyboardType: TextInputType.number,
              ),
            ),
             Container(
  height: 40.h,
   width: MediaQuery.sizeOf(context).width * 0.3,
  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: kcVeryLightGrey.withOpacity(0.2),
  ),
  child: Row(
    children: [
      Icon(Icons.timelapse_outlined,
          color: kcBlackColor.withOpacity(0.5), size: 20.0),
      horizontalSpaceMedium,
      Expanded(
        flex: 2,
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: kcWhiteColor,
          underline: const SizedBox(),
          icon: Icon(FlutterRemix.arrow_down_s_line,
              color: kcBlackColor.withOpacity(0.5), size: 30.0),
          value: viewModel.selectedTimeMethod,
          onChanged: (String? newValue) {
            viewModel.onTimeMethodSelection( newValue!);
          },
          items: viewModel.timeMethod.map((index) {
            return DropdownMenuItem<String>(
              value: index.toString(), // Set the value here
              child: Text(index),
            );
          }).toList(),
        ),
      ),
    ],
  ),
),

          ],
        )
      ],
    );
  }
}
