import 'package:cached_network_image/cached_network_image.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

import 'grid_tile_model.dart';

// ignore: must_be_immutable
class PrimaryGridTile extends StackedView<GridTileModel> {
  final String foodImagePath;
  final String chefImagePath;
  final String dishName;
  final String duration;
  final void Function() onTap;
  final RecipeModel recipe;
  // ignore: prefer_typing_uninitialized_variables
  var rating;
  final String chefId;

  PrimaryGridTile({
    super.key,
    required this.foodImagePath,
    required this.chefId,
    required this.chefImagePath,
    this.rating,
    required this.dishName,
    required this.duration,
    required this.onTap,
    required this.recipe,
  });

  @override
  Widget builder(
    BuildContext context,
    GridTileModel viewModel,
    Widget? child,
  ) {
    bool isRecipeSaved = false;
    for (String savedRecipe in userDetails!.savedRecipes!) {
      if (savedRecipe == recipe.docId) {
        isRecipeSaved = true;
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
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0.r),
                      topRight: Radius.circular(15.0.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: foodImagePath,
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Container(
                        decoration: const BoxDecoration(
                          color: kcsgreycolor,
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpaceTiny,
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: 120.w,
                    child: Text(
                      capitalizeEachWord(dishName),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: globalTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                        color: kcBlackColor.withOpacity(0.6),
                      ),
                    ),
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
                      onTap: () => viewModel.onBookmarkTap(recipe),
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
              bottom: 30.dg,
              child: Container(
                // width: 90.w,
                height: 25.h,
                padding: EdgeInsets.only(left: 10.dg, right: 10.dg),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: kcBlackColor.withOpacity(0.4),
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
                bottom: 8.dg,
                right: 10.dg,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18.r,
                  child: CircleAvatar(
                      radius: 16.r,
                      backgroundImage: chefImagePath.isEmpty
                          ? const AssetImage(
                              'assets/images/misc/blank_image.png')
                          : NetworkImage(chefImagePath) as ImageProvider
                      // ? ClipRRect(

                      //     borderRadius: BorderRadius.circular(50.r),
                      //     child: const Image(
                      //         image: AssetImage(
                      //             'assets/images/misc/blank_image.png')))
                      // : ClipRRect(
                      //     borderRadius: BorderRadius.circular(50.r),
                      //     child: CachedNetworkImage(
                      //       imageUrl: chefImagePath,
                      //       fit: BoxFit.cover,
                      //       width: double.maxFinite,
                      //       progressIndicatorBuilder: (context, url, progress) =>
                      //           Container(
                      //         decoration: const BoxDecoration(
                      //           color: kcsgreycolor,
                      //         ),
                      //       ),
                      //     ),
                      //   ),,
                      ),
                )
                //  Container(
                //   height: 32.h,
                //   width: 32.w,
                //   decoration: BoxDecoration(
                //     color: kcVeryLightGrey,
                //     shape: BoxShape.circle,
                //     border: Border.all(
                //       color: kcWhiteColor,
                //       width: 2.w,
                //     ),
                //   ),
                //   child: chefImagePath.isEmpty
                //       ? ClipRRect(

                //           borderRadius: BorderRadius.circular(50.r),
                //           child: const Image(
                //               image: AssetImage(
                //                   'assets/images/misc/blank_image.png')))
                //       : ClipRRect(
                //           borderRadius: BorderRadius.circular(50.r),
                //           child: CachedNetworkImage(
                //             imageUrl: chefImagePath,
                //             fit: BoxFit.cover,
                //             width: double.maxFinite,
                //             progressIndicatorBuilder: (context, url, progress) =>
                //                 Container(
                //               decoration: const BoxDecoration(
                //                 color: kcsgreycolor,
                //               ),
                //             ),
                //           ),
                //         ),
                // ),
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
