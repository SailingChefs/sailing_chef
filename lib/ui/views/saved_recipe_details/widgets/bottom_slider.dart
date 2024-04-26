import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class BottomSlider extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  const BottomSlider({super.key});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return SizedBox(
        // width: screenWidth(context),
        height: screenHeight(context) * 0.32,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.recipeList.length,
            itemBuilder: (context, index) {
              bool isRecipeSaved = false;
              for (SavedRecipeModel savedRecipe in viewModel.savedRecipeList) {
                if (savedRecipe.recipeId == viewModel.recipeList[index].docId) {
                  isRecipeSaved = !isRecipeSaved;
                  break;
                }
              }
              return GestureDetector(
                onTap: () =>
                    viewModel.toRecipeDetails(viewModel.recipeList[index]),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.dg, 30.dg, 0.dg, 30.dg),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 129.w,
                          height: 140.h,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.7.dg)),
                              child: Image.network(
                                viewModel.recipeList[index].coverImage.first,
                                fit: BoxFit.cover,
                                width: 119.w,
                                height: 162.h,
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                  capitalizeEachWord(
                                      viewModel.recipeList[index].title),
                                  style: globalTextStyle(
                                    fontSize: 10.sp,
                                    color: kcBlackColor.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  viewModel.addToSaveList(
                                    viewModel.recipeList[index],
                                  );
                                },
                                icon: isRecipeSaved
                                    ? Icon(
                                        Icons.bookmark,
                                        color: kcBlackColor.withOpacity(0.6),
                                        size: 20.dg,
                                      )
                                    : Icon(
                                        Icons.bookmark_border,
                                        color: kcBlackColor.withOpacity(0.6),
                                        size: 20.dg,
                                      )),
                          ],
                        ),
                      ]),
                ),
              );
            }));
  }
}
