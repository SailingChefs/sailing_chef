
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/maincontainer.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/save_share.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

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
            resizeToAvoidBottomInset: false,
            backgroundColor: kcBackgroundColor,
            body: Stack(children: [
              TopBarDetailsScreen(image: recipeModel.coverImage),
              MainRecipeViewContainer(
                recipeModel: recipeModel,
                recipeList: randomRecipeList,
              ),
              Positioned(
            top: MediaQuery.of(context).size.height * 0.39,
            right: 30,
            child:     Container(
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
            color: kcVeryLightGrey,
            border: Border.all(
              color: kcWhiteColor,
              width: 2.0,
            ),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: recipeModel.user!.displayPicture!.isEmpty
                  ? const AssetImage('assets/images/misc/blank_image.png')
                  : NetworkImage(recipeModel.user!.displayPicture!) as ImageProvider,
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
                child: BackArrowWidget(onTap: () {
                  viewModel.moveBack();
                }),
              ),
            ]),
          );
  }

  @override
  void onViewModelReady(SavedRecipeDetailsViewModel viewModel) {
    viewModel.onViewModelReady(
      recipeModel.docId!,);
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
