import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class BottomSlider extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final List<RecipeModel> recipeList;
  const BottomSlider(
      {required this.isFromPrivateProfile,
      required this.recipeList,
      super.key});
  final bool isFromPrivateProfile;
  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return recipeList.isEmpty
        ? Container()
        : !isFromPrivateProfile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More Recipes',
                    style: globalTextStyle(
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.w700,
                      color: kcBlackColor,
                    ),
                  ),
                  SizedBox(
                    // width: screenWidth(context),
                    height: screenHeight(context) * 0.35,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          var isRecipeSaved = false;

                          if (userDetails!.savedRecipes!
                              .contains(recipeList[index].docId)) {
                            isRecipeSaved = !isRecipeSaved;
                          }

                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () => viewModel.toRecipeDetails(
                                  recipeList[index],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.dg, 10.dg, 0.dg, 30.dg),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 140.w,
                                        height: 180.h,
                                        child: ImageUtils.networkImageWithFallback(
                                          // .contains('jpg') dropped any
                                          // cover image not literally named
                                          // ".jpg" (.png/.jpeg/.heic, etc.),
                                          // and .first threw when nothing
                                          // matched. isFirebaseImageUrl
                                          // recognises every common image
                                          // extension, and the fallback
                                          // helper handles both "no match"
                                          // and genuine load failures.
                                          imageUrl: recipeList[index]
                                              .coverImage
                                              .firstWhere(
                                                  (element) =>
                                                      element.isFirebaseImageUrl,
                                                  orElse: () => ''),
                                          width: 140.w,
                                          height: 160.h,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(22.7.dg),
                                          ),
                                        ),
                                      ),
                                      verticalSpaceTiny,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          horizontalSpaceSmall,
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                capitalizeEachWord(
                                                    recipeList[index].title),
                                                style: globalTextStyle(
                                                  fontSize: 13.sp,
                                                  color: kcBlackColor
                                                      .withOpacity(0.6),
                                                  letterSpacing: -0.3,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.addToSaveList(
                                                recipeList[index],
                                              );
                                            },
                                            child: isRecipeSaved
                                                ? Icon(
                                                    Icons.bookmark,
                                                    color: kcBlackColor
                                                        .withOpacity(0.6),
                                                    size: 20.dg,
                                                  )
                                                : Icon(
                                                    Icons.bookmark_border,
                                                    color: kcBlackColor
                                                        .withOpacity(0.6),
                                                    size: 20.dg,
                                                  ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              horizontalSpaceSmall,
                            ],
                          );
                        }),
                  ),
                ],
              )
            : Container();
  }
}
