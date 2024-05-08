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
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: kcBlackColor),
        ),
        verticalSpaceSmall,
        GestureDetector(
              onTap: viewModel.callCookingInstructionBottomSheet,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: kcVeryLightGrey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: kcBlackColor.withOpacity(0.5),
                        )),
                    horizontalSpaceSmall,
                    Text(
                      'Select a minimum of 2 tags',
                      style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kcBlackColor.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}
