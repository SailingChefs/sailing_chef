import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/maincontainer.dart';

import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/save_share.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/top_image.dart';

class SavedRecipeDetailsView extends StackedView<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  final List<RecipeModel> randomRecipeList;
  final bool isFromPrivateProfile;
  const SavedRecipeDetailsView({
    required this.recipeModel, required this.isFromPrivateProfile, required this.randomRecipeList, super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    SavedRecipeDetailsViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center()
        : WillPopScope(
            onWillPop: () async {
              try {
                await viewModel.updateShoppingList();
              } catch (e, stackTrace) {
                log('Failed to update shopping list on pop: $e');
                log('StackTrace: $stackTrace');
              }
              // Ensure that the pop operation is not blocked
              return true;
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                leading: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await viewModel.updateShoppingList();
                      } catch (e, stackTrace) {
                        log('Failed to update shopping list on pop: $e');
                        log('StackTrace: $stackTrace');
                      }
                      viewModel.moveBack();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 8.0.dg),
                      height: 36.h,
                      width: 36.w,
                      decoration: const BoxDecoration(
                        color: kcVeryLightGrey,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: kcBlackColor,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
                actions: [
                  SaveShare(
                    isFromPrivateProfile: isFromPrivateProfile,
                    recipe: recipeModel,
                  ),
                  16.w.horizontalSpace,
                ],
                backgroundColor: Colors.transparent,
              ),
              extendBodyBehindAppBar: true,
              backgroundColor: kcBackgroundColor,
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    TopBarDetailsScreen(
                      isFromPrivateProfile: isFromPrivateProfile,
                      image: recipeModel.coverImage,
                      reciepmodel: recipeModel,
                    ),
                    MainRecipeViewContainer(
                      isFromPrivateProfile: isFromPrivateProfile,
                      recipeModel: recipeModel,
                      recipeList: randomRecipeList,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void onViewModelReady(SavedRecipeDetailsViewModel viewModel) {
    viewModel.onViewModelReady(
      recipeModel.docId!,
    );
    super.onViewModelReady(viewModel);
  }

  @override
  SavedRecipeDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SavedRecipeDetailsViewModel(
        recipeModel: recipeModel,
      );
}
