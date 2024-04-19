import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class ServingQuantity extends ViewModelWidget<AddRecipeViewModel> {
  const ServingQuantity({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Serving',
          style: globalTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: kcBlackColor),
        ),
        verticalSpaceSmall,
        Container(
          height: 50.h,
          width: 105.w,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0.r),
            color: kcVeryLightGrey.withOpacity(0.2),
          ),
          child: Row(
            children: [
              Icon(FlutterRemix.group_line,
                  color: kcBlackColor.withOpacity(0.5), size: 18.0),
              horizontalSpaceMedium,
              Expanded(
                flex: 1,
                child: DropdownButton<int>(
                  isExpanded: true,
                  dropdownColor: kcWhiteColor,
                  underline: const SizedBox(),
                  icon: Icon(FlutterRemix.arrow_down_s_line,
                      color: kcBlackColor.withOpacity(0.5), size: 30.0),
                  value: viewModel.selectedQuantity,
                  onChanged: (int? newValue) {
                    viewModel.updateQuantity(newValue!);
                  },
                  items: List.generate(5, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
