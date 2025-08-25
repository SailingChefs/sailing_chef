import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/all_following_recipes.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/all_saved_recipes.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/tab_bar.dart';

class SavedRecipesView extends StackedView<SavedRecipesViewModel> {
  const SavedRecipesView({
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    SavedRecipesViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kcWhiteColor,
            appBar: AppBar(
              backgroundColor: kcWhiteColor,
              elevation: 0,
              title: Text('Saved Recipes',
                  style: globalTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor)),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              child: Column(
                children: [
                  verticalSpaceMedium,
                  const TabBarSavedRecipesScreen(),
                  verticalSpaceMedium,
                  if (viewModel.isAllSelected)
                    const AllSavedRecipesScreen()
                  else
                    const FollowingSavedRecipesScreen(),
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
