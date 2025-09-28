import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';

class CategoryTabsFilterScreen extends ViewModelWidget<FilterViewModel> {
  const CategoryTabsFilterScreen({super.key});

  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style:
              globalTextStyle(fontSize: 20.0.dg, color: kcBlackColor, fontWeight: FontWeight.w500),
        ),
        verticalSpaceSmall,
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            GestureDetector(
              onTap: () {
                viewModel.handleMainTabsCategory(0);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isPassageSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Passage Friendly',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isPassageSelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleMainTabsCategory(1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color:
                      viewModel.isMealSelected ? kcPrimaryColor : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Meal Prep',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        viewModel.isMealSelected ? kcVeryLightGrey : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleMainTabsCategory(2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isPlatedSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Text(
                  'Plated',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: viewModel.isPlatedSelected
                        ? kcVeryLightGrey
                        : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.handleSubTabsCategory(0);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isFamilySelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Family Style',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: viewModel.isFamilySelected
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
                viewModel.handleSubTabsCategory(1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color:
                      viewModel.isLightSelected ? kcPrimaryColor : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Light Meal',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: viewModel.isLightSelected
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
                viewModel.handleSubTabsCategory(2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.isCharterSelected
                      ? kcPrimaryColor
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Charter',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: viewModel.isCharterSelected
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
                viewModel.handleSubTabsCategory(3);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color:
                      viewModel.isCrewSelected ? kcPrimaryColor : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Crew',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: viewModel.isCrewSelected
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
