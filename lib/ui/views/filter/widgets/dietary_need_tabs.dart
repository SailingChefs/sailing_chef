import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';

class DietaryNeedTabsFilterScreen extends ViewModelWidget<FilterViewModel> {
  const DietaryNeedTabsFilterScreen({super.key});

  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
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
          spacing: 8,
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
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isDietaryPassageSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Passage friendly',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isDietaryPassageSelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleMainTabsDietary(1);
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isDietaryMealSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Meal Prep',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isDietaryMealSelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleMainTabsDietary(2);
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isDietaryPlatedSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Plated',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isDietaryPlatedSelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsDietary(0);
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isDietaryFamilySelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Family Style',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isDietaryFamilySelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsDietary(1);
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isDietaryLightSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Light Meal',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isDietaryLightSelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsDietary(2);
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isDietaryCharterSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Charter',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isDietaryCharterSelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsDietary(3);
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isDietaryCrewSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Crew',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isDietaryCrewSelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
