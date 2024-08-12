import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/maincontainer.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/save_share.dart';

import 'widgets/top_image.dart';

class SavedRecipeDetailsView extends StackedView<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  final List<RecipeModel> randomRecipeList;


  const SavedRecipeDetailsView({
    Key? key,
    required this.recipeModel,
    required this.randomRecipeList,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SavedRecipeDetailsViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center(
            child: CircularProgressIndicator(
            color: kcPrimaryColor,
          ))
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: kcBackgroundColor,
            body: SingleChildScrollView(
              child: Stack(children: [
                TopBarDetailsScreen(image: recipeModel.coverImage),
                MainRecipeViewContainer(
                  recipeModel: recipeModel,
                  recipeList: randomRecipeList,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  right: 30,
                  child: Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: kcVeryLightGrey,
                      border: Border.all(
                        color: kcWhiteColor,
                        width: 3.0,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:  recipeModel.user!.displayPicture == null 
                            ? const AssetImage(
                                'assets/images/misc/blank_image.png')
                            : NetworkImage(recipeModel.user!.displayPicture!)
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 40,
                    right: 10,
                    child: SaveShare(
                      recipe: recipeModel,
                    )),
                Positioned(
                  top: 40,
                  left: 10,
                  child: GestureDetector(
                    onTap: () => viewModel.moveBack(),
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
              ]),
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
