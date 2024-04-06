import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/widgets/chef_list.dart';
import 'package:sailing_chefs/ui/views/index/widgets/dish_list.dart';
import 'package:sailing_chefs/ui/views/index/widgets/search_bar.dart';
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
          ? const Center(child: CircularProgressIndicator(
            color: kcBackgroundColor,
          ))
          : Scaffold(
              backgroundColor: kcBackgroundColor,
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    const TopBarIndexScreen(),
                    verticalSpaceMedium,
                    const ChefListIndexScreen(),
                    verticalSpaceMedium,
                    const SearchBarIndexView(),
                    verticalSpaceMedium,
                    const DishListIndexScreen(),
                    verticalSpaceMedium,
                  ],
                ),
              ),
            ),
    );
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
