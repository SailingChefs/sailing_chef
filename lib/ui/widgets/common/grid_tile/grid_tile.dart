import 'dart:developer';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';

import 'grid_tile_model.dart';

class PrimaryGridTile extends StackedView<GridTileModel> {
  final String foodImagePath;
  final String chefImagePath;
  final String dishName;
  final String duration;
  final void Function() onTap;
  final String recipeId;
  final double? rating;
  final List<SavedRecipeModel> savedRecipeList;
  final String chefId;

  const PrimaryGridTile({
    super.key,
    required this.foodImagePath,
    required this.chefId,
    required this.savedRecipeList,
    required this.chefImagePath,
    this.rating,
    required this.dishName,
    required this.duration,
    required this.onTap,
    required this.recipeId,
  });

  @override
  Widget builder(
    BuildContext context,
    GridTileModel viewModel,
    Widget? child,
  ) {
    bool isRecipeSaved = false;
    for (SavedRecipeModel savedRecipe in savedRecipeList) {
      if (savedRecipe.recipeId == recipeId) {
        isRecipeSaved = !isRecipeSaved;
        break;
      }
    }
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(bottom: 15.0.dg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0.r),
            color: kcWhiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0.r),
                        topRight: Radius.circular(15.0.r),
                      ),
                      child: Image.network(
                        foodImagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                ),
                verticalSpaceTiny,
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        rating: rating!,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      Text(
                        capitalizeEachWord(dishName),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: globalTextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: kcBlackColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            chefId == userDetails!.uid!
                ? Container()
                : Positioned(
                    top: 5.dg,
                    right: 10.dg,
                    child: GestureDetector(
                      onTap: () => viewModel.onBookmarkTap(recipeId),
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kcBlackColor.withOpacity(0.6),
                        ),
                        child: isRecipeSaved
                            ? Icon(
                                Icons.bookmark,
                                size: 18.dg,
                                color: kcWhiteColor,
                              )
                            : Icon(
                                Icons.bookmark_outline,
                                size: 18.dg,
                                color: kcWhiteColor,
                              ),
                      ),
                    ),
                  ),
            Positioned(
              left: 5.dg,
              bottom: 30.dg + 25.dg,
              child: Container(
                // width: 90.w,
                height: 25.h,
                padding: EdgeInsets.only(left: 10.dg, right: 10.dg),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: kcBlackColor.withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FlutterRemix.time_line,
                      size: 12.dg,
                      color: kcWhiteColor,
                    ),
                    horizontalSpaceTiny,
                    Text(
                      duration.trimRight().trimLeft(),
                      maxLines: 1,
                      style: globalTextStyle(fontSize: 10.sp),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30.dg,
              right: 10.dg,
              child: Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                  color: kcVeryLightGrey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kcWhiteColor,
                    width: 2.w,
                  ),
                  image: DecorationImage(
                    image: userDetails!.displayPicture!.isEmpty
                        ? const AssetImage('assets/images/misc/blank_image.png')
                        : NetworkImage(userDetails!.displayPicture!)
                            as ImageProvider,
                    fit: BoxFit.cover,  
                  ),
                ),
              ),
            )
          ]),
        ));
  }

  @override
  GridTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      GridTileModel();
}
