import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';

class CourseTabBarFilerScreen extends ViewModelWidget<FilterViewModel> {
  const CourseTabBarFilerScreen({super.key});

  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course',
          style: globalTextStyle(
              fontSize: 20.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w500),
        ),
        verticalSpaceSmall,
        // Wrap(),
        FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  viewModel.handleTabMainCourse(0);
                  // viewModel.breakfastSelected();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.isBreakfastSelected
                        ? kcPrimaryColor
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Breakfast',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.isBreakfastSelected
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
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.isLunchSelected
                        ? kcPrimaryColor
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lunch',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.isLunchSelected
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
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.isDinnerSelected
                        ? kcPrimaryColor
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dinner',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.isDinnerSelected
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
        verticalSpaceSmall,
        FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  viewModel.handleSubTabsCourse(0);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.isStarterSelected
                        ? kcPrimaryColor
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Starter',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.isStarterSelected
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
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.isCanapeSelected
                        ? kcPrimaryColor
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Canapé',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.isCanapeSelected
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
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.isSideSelected
                        ? kcPrimaryColor
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Side',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.isSideSelected
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
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.dg),
                    ),
                    color: viewModel.isSweetSelected
                        ? kcPrimaryColor
                        : kcVeryLightGrey.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sweet',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.isSweetSelected
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
        )
      ],
    );
  }
}
