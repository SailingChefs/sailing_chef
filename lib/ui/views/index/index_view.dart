import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/widgets/chef_list.dart';
import 'package:sailing_chefs/ui/views/index/widgets/culinaryschooldlist.dart';
import 'package:sailing_chefs/ui/views/index/widgets/dish_list.dart';
import 'package:sailing_chefs/ui/views/index/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/views/index/widgets/shimmer_loader.dart';
import 'package:sailing_chefs/ui/views/index/widgets/tabbar_indexscreen.dart';
import 'package:sailing_chefs/ui/views/index/widgets/top_bar.dart';

import 'index_viewmodel.dart';

class IndexView extends StackedView<IndexViewModel> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    IndexViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
        child: viewModel.isBusy
            ? const ShimmerLoader()
            : Scaffold(
                backgroundColor: kcBackgroundColor,
                body: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                    children: [
                      const TopBarIndexScreen(),
                      verticalSpace(10),
                      const TabBarIndexScreen(),
                      verticalSpace(10),
                      viewModel.isMySelected
                          ? const ChefListIndexScreen()
                          : const CullinaryListIndexScreen(),
                      verticalSpace(10),
                      const SearchBarIndexView(),
                      verticalSpace(10),
                      const DishListIndexScreen(),
                      verticalSpaceMedium,
                      Center(
                          child: TextButton(
                              onPressed: viewModel.toAllRecipesView,
                              child: Text(
                                'View All Recipes',
                                style: globalTextStyle(
                                    fontSize: 14, color: kcPrimaryColor),
                              )))
                    ],
                  ),
                ),
              ));
  }

  @override
  void onViewModelReady(IndexViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  IndexViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      IndexViewModel();
}
