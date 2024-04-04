import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/methods.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/tab_bars_recipe.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/view_profile_row.dart';
import '../saved_recipe_details_viewmodel.dart';

class MainRecipeViewContainer
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  const MainRecipeViewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kcwhitecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Healthy Taco Salad',
                            style: globalTextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: kcBlackColor,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 45,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                FlutterRemix.time_line,
                                size: 12,
                                color: kcBlackColor.withOpacity(0.5),
                              ),
                              horizontalSpaceTiny,
                              const Text(
                                '20 mins',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: kcBlackColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 2),
                      child: Text(
                        'This Healthy Taco Salad is the universal delight of taco night',
                        style: globalTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: kcBlackColor,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    const ViewProfileRow(),
                    verticalSpaceLarge,
                    const TabBarWidgets(),
                    verticalSpaceTiny,
                    viewModel.isIngredientsSelected
                        ? const IngredientsClass()
                        : const Methods(),
                    verticalSpaceSmall,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
