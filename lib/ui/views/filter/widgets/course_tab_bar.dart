import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';

class CourseTabBarFilerScreen extends ViewModelWidget<FilterViewModel> {
  const CourseTabBarFilerScreen({super.key});

  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
    return Column(
      children: [
        Text(
          'Course',
          style: globalTextStyle(
              fontSize: 20.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w500),
        ),
        verticalSpaceSmall,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                viewModel.handleTabMainCourse(0);
                viewModel.breakfastSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 22.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabMainCourse == 'breakfast'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Breakfast',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabMainCourse == 'breakfast'
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
                viewModel.handleTabMainCourse(1);
                viewModel.lunchSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 22.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabMainCourse == 'lunch'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lunch',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabMainCourse == 'lunch'
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
                viewModel.handleTabMainCourse(2);
                viewModel.lunchSelected();
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 22.dg, vertical: 12.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTabMainCourse == 'dinner'
                      ? kcPrimaryColorDark
                      : kcVeryLightGrey.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dinner',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTabMainCourse == 'dinner'
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
        verticalSpaceSmall,
        FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  viewModel.handleSubTabsCourse(0);
                  viewModel.starterSelected();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 13.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.selectedTabSub == 'starter'
                        ? kcPrimaryColorDark
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Starter',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedTabSub == 'starter'
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
                  viewModel.handleSubTabsCourse(1);
                  viewModel.canapeSelected();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 13.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.selectedTabSub == 'canape'
                        ? kcPrimaryColorDark
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Canapé',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedTabSub == 'canape'
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
                  viewModel.handleSubTabsCourse(2);
                  viewModel.sideSelected();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 13.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.selectedTabSub == 'side'
                        ? kcPrimaryColorDark
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Side',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedTabSub == 'side'
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
                  viewModel.handleSubTabsCourse(3);
                  viewModel.sweetSelected();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 13.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.selectedTabSub == 'sweet'
                        ? kcPrimaryColorDark
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sweet',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedTabSub == 'sweet'
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
        ),
      ],
    );
  }
}
