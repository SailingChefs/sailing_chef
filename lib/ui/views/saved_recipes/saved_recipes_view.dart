import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/all_following_recipes.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/all_saved_recipes.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/tab_bar.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/top_bar.dart';

import 'saved_recipes_viewmodel.dart';

class SavedRecipesView extends StackedView<SavedRecipesViewModel> {
  const SavedRecipesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SavedRecipesViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Column(
                      children: [
                        const TopBarSavedRecipesScreen(),
                        verticalSpaceLarge,
                        const TabBarSavedRecipesScreen(),
                        verticalSpaceMedium,
                        const SearchBarSavedRecipesScreen(),
                        verticalSpaceMedium,
                        viewModel.isAllSelected
                            ? const AllSavedRecipesScreen()
                            : const FollowingSavedRecipesScreen(),
                      ],
                    ),
                  )),
            ),
    );
  }

  @override
  void onViewModelReady(SavedRecipesViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  SavedRecipesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SavedRecipesViewModel();
}
