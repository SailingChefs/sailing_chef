import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet_model.dart';

class DietaryNeedTabsFilterSheet extends ViewModelWidget<TagsSheetModel> {
  const DietaryNeedTabsFilterSheet({super.key});

  @override
  Widget build(BuildContext context, TagsSheetModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dietary Needs',
          style: globalTextStyle(
              fontSize: 20.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w500),
        ),
        verticalSpaceSmall,
        Wrap(
          spacing: 0,
          runSpacing: 16,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () {
                viewModel.handleMainTabsDietary(0);
                viewModel.passageSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color:
                      viewModel.selectedTabMainDietaryNeed == 'passagefriendly'
                          ? kcPrimaryColorDark
                          : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Passage friendly',
                      style: TextStyle(
                        fontSize: 12.0.dg,
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabMainDietaryNeed ==
                                'passagefriendly'
                            ? kcVeryLightGrey
                            : kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpaceSmall,
            GestureDetector(
              onTap: () {
                viewModel.handleMainTabsDietary(1);
                viewModel.mealSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabMainDietaryNeed == 'mealprep'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Meal Prep',
                      style: TextStyle(
                        fontSize: 12.0.dg,
                        fontWeight: FontWeight.w600,
                        color:
                            viewModel.selectedTabMainDietaryNeed == 'mealprep'
                                ? kcVeryLightGrey
                                : kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpaceSmall,
            GestureDetector(
              onTap: () {
                viewModel.handleMainTabsDietary(2);
                viewModel.platedSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.dg, vertical: 12.dg),
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabMainDietaryNeed == 'plated'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Plated',
                      style: TextStyle(
                        fontSize: 12.0.dg,
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabMainDietaryNeed == 'plated'
                            ? kcVeryLightGrey
                            : kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsDietary(0);
                viewModel.familySelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.dg, vertical: 13.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabSubDietaryNeed == 'family'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Family Style',
                      style: TextStyle(
                        fontSize: 12.0.dg,
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabSubDietaryNeed == 'family'
                            ? kcVeryLightGrey
                            : kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpaceSmall,
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsDietary(1);
                viewModel.lightSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.dg, vertical: 13.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabSubDietaryNeed == 'light'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Light Meal',
                      style: TextStyle(
                        fontSize: 12.0.dg,
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabSubDietaryNeed == 'light'
                            ? kcVeryLightGrey
                            : kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpaceSmall,
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsDietary(2);
                viewModel.charterSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.dg, vertical: 13.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabSubDietaryNeed == 'charter'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Charter',
                      style: TextStyle(
                        fontSize: 12.0.dg,
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabSubDietaryNeed == 'charter'
                            ? kcVeryLightGrey
                            : kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpaceSmall,
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsDietary(3);
                viewModel.crewSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.dg, vertical: 13.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabSubDietaryNeed == 'crew'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Crew',
                      style: TextStyle(
                        fontSize: 12.0.dg,
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabSubDietaryNeed == 'crew'
                            ? kcVeryLightGrey
                            : kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
