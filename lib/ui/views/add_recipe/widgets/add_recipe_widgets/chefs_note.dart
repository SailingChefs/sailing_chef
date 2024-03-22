import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class ChefsNote extends ViewModelWidget<AddRecipeViewModel> {
  const ChefsNote({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Chef\'s Note',
        style: globalTextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: kcBlackColor),
      ),
      verticalSpaceTiny,
      GestureDetector(
        onTap: viewModel.callBottomSheet,
        child: Container(
          height: 50.h,
          padding: EdgeInsets.only(
            left: 20.dg,
          ),
          decoration: BoxDecoration(
            color: kcVeryLightGrey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add tips for this recipe',
                style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor.withOpacity(0.5)),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mic,
                    color: kcPrimaryColorDark,
                  )),
            ],
          ),
        ),
      ),
    ]);
  }
}
