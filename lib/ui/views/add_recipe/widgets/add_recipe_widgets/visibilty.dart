import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class VisibiltyDropDown extends ViewModelWidget<AddRecipeViewModel> {
  const VisibiltyDropDown({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visibility',
          style: globalTextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.w600, color: kcBlackColor),
        ),
        verticalSpaceSmall,
        Container(
          height: 50.h,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.transparent,
            border: Border.all(
              color: kcPrimaryColorDark,
              width: 2.0,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              iconDisabledColor: kcPrimaryColorDark,
              iconEnabledColor: kcPrimaryColorDark,
              style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor.withOpacity(0.4)),
              isExpanded: true,
              value: viewModel.selectedValue,
              onChanged: (String? newValue) {
                viewModel.updateValue(newValue!);
              },
              items: viewModel.values.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
