import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/comments.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/leave_comment_bottom.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/methods.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/tab_bars_recipe.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/view_profile_row.dart';
import '../saved_recipe_details_viewmodel.dart';

class MainRecipeViewContainer
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  const MainRecipeViewContainer({Key? key, required this.recipeModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kcwhitecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.r),
                    topRight: Radius.circular(35.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            capitalizeEachWord(recipeModel.title),
                            style: globalTextStyle(
                              fontSize: 26.45.sp,
                              fontWeight: FontWeight.w500,
                              color: kcBlackColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                FlutterRemix.time_line,
                                size: 12,
                                color: kcBlackColor.withOpacity(0.5),
                              ),
                              horizontalSpaceTiny,
                              Text(
                                recipeModel.prepTime,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: kcBlackColor,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      verticalSpaceSmall,

                      ViewProfileRow(
                        user: recipeModel.user!,
                      ),
                      verticalSpaceMedium,
                      const TabBarWidgets(),
                      verticalSpaceSmall,
                      viewModel.isIngredientsSelected
                          ? IngredientsClass(
                              recipeModel: recipeModel,
                            )
                          : Methods(
                              recipe: recipeModel,
                            ),
                      verticalSpaceSmall,
                      verticalSpaceMedium,
                      const Text("Chef Notes",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      verticalSpaceMedium,
                      Container(
                        height: 48,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: kcMediumGrey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: const CircleBorder(),
                                backgroundColor: kcPrimaryColor,
                              ),
                              onPressed: () {},
                              child: const Icon(
                                Icons.play_arrow,
                                color: kcwhitecolor,
                              ),
                            ),
                            horizontalSpaceTiny,
                            const Icon(Icons.multitrack_audio, opticalSize: 25),
                            const Spacer(),
                            const Text("0:05",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                            horizontalSpaceTiny,
                            Icon(Icons.volume_up,
                                size: 24, color: Colors.black.withOpacity(0.5)),
                            horizontalSpaceSmall,
                          ],
                        ),
                      ),
                      const CommentsDetailsScreen(),
                      const LeaveComment(),
                      horizontalSpaceSmall,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
