import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/widgets/bottom_buttons.dart';
import 'package:sailing_chefs/ui/views/filter/widgets/category_tab.dart';
import 'package:sailing_chefs/ui/views/filter/widgets/course_tab_bar.dart';
import 'package:sailing_chefs/ui/views/filter/widgets/dietary_need_tabs.dart';
import 'package:sailing_chefs/ui/views/filter/widgets/time_slider.dart';
import 'package:sailing_chefs/ui/views/filter/widgets/top_bar.dart';

import 'filter_viewmodel.dart';

class FilterView extends StackedView<FilterViewModel> {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FilterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopBarFilterScreen(),
                    verticalSpaceMedium,
                    const TimeSliderFilterScreen(),
                    verticalSpaceMedium,
                    const CourseTabBarFilerScreen(),
                    verticalSpaceMedium,
                    const CategoryTabsFilterScreen(),
                    verticalSpaceMedium,
                    const DietaryNeedTabsFilterScreen(),
                    verticalSpaceMedium,
                  ])),
          const BottomButtons(),
        ],
      ),
    );
  }

  @override
  FilterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FilterViewModel();
}
