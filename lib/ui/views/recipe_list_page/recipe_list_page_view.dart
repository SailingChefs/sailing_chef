// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/ui/views/recipe_list_page/recipe_list_page_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:sailing_chefs/ui/widgets/empty_state.dart';
import 'package:shimmer/shimmer.dart';

class RecipeListPageView extends StackedView<RecipeListPageViewModel> {
  final bool isFromDraft;
  const RecipeListPageView({
    required this.isFromDraft,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    RecipeListPageViewModel viewModel,
    Widget? child,
  ) {
    return PopScope(
      canPop: false,
      onPopInvoked: viewModel.onPopInvoked,
      child: Scaffold(
          backgroundColor: kcwhitecolor,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BackArrowWidget(
                onTap: viewModel.toHomeView,
              ),
            ),
            title: Text(
              'Recipes',
              style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                letterSpacing: -0.3,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          body: viewModel.isBusy
              ? const _ShimmerRecipeList()
              : RefreshIndicator(
                  color: kcPrimaryColor,
                  onRefresh: viewModel.onRefresh,
                  child: viewModel.recipes.isEmpty
                      ? const _EmptyRecipes()
                      : ListView.builder(
                  itemCount: viewModel.recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final recipe = viewModel.recipes[index];
                    return GestureDetector(
                      onTap: () => viewModel.toDishDetailsScreen(recipe),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 225.0.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: ImageUtils.safeNetworkImage(
                                        recipe.coverImage
                                                .where((element) =>
                                                    element.isFirebaseImageUrl)
                                                .isNotEmpty
                                            ? recipe.coverImage
                                                .where((element) =>
                                                    element.isFirebaseImageUrl)
                                                .first
                                            : '',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10.dg,
                                  left: 10.dg,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(30.0.r),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0.w, vertical: 8.h),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/misc/clock.svg',
                                            color: kcWhiteColor,
                                            height: 15.h,
                                            width: 15.w,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            recipe.prepTime,
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                color: kcWhiteColor),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            // const SizedBox(width: 16.0),
                            verticalSpaceSmall,
                            SizedBox(
                              width: screenWidth(context) * 0.8.w,
                              // height: recipe.title.length > 20 ? 40.h : 50.h,
                              child: Text(
                                capitalizeEachWord(recipe.title),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: globalTextStyle(
                                  letterSpacing: -0.5,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kcBlackColor,
                                ),
                              ),
                            ),
                            // const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Container(
                                  height: 35.h,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                    color: kcVeryLightGrey,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: ImageUtils.safeNetworkImage(
                                        userDetails!.displayPicture,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  userDetails!.displayName!,
                                  style: globalTextStyle(
                                    letterSpacing: -0.5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    color: kcBlackColor.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ),
    );
  }

  @override
  void onViewModelReady(RecipeListPageViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  RecipeListPageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeListPageViewModel(isFromDraft: isFromDraft);
}

class _ShimmerRecipeList extends StatelessWidget {
  const _ShimmerRecipeList();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 225,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                  width: 180, height: 18, color: Colors.white),
              const SizedBox(height: 6),
              Container(
                  width: 120, height: 14, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyRecipes extends StatelessWidget {
  const _EmptyRecipes();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: const EmptyStateWidget(
        icon: Icons.menu_book_outlined,
        title: 'No recipes yet',
        subtitle: 'Pull down to refresh, or add your first recipe',
      ),
    );
  }
}
