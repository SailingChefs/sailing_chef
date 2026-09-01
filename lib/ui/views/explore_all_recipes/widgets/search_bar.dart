// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/explore_all_recipes_viewmodel.dart';

class SearchBarAllRecipesScreen
    extends ViewModelWidget<ExploreAllRecipesViewModel> {
  final List<RecipeModel> recipes;
  const SearchBarAllRecipesScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context, ExploreAllRecipesViewModel viewModel) {
    return FittedBox(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.75,
            height: 40.dg,
            child: TextField(
              onEditingComplete: () => viewModel.rebuildUi(),
              onChanged: (value) {
                viewModel.rebuildUi();
              },
              onSubmitted: (value) => viewModel.searchRecipes(recipes),
              controller: viewModel.searchController,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: kcBlackColor.withOpacity(0.6),
                  fontSize: 12.sp,
                ),
                filled: true,
                fillColor: kcPrimaryColor.withOpacity(0.09),
                labelStyle: TextStyle(
                    fontSize: 12.sp, color: kcBlackColor.withOpacity(0.6)),
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: BorderSide(
                      color: kcWhiteColor
                          .withOpacity(0.2)), // Unfocused border color
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: const BorderSide(
                    color: kcErrorColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                  borderSide: const BorderSide(
                    color: kcErrorColor,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                prefixIcon: Icon(
                  FlutterRemix.search_line,
                  color: kcBlackColor.withOpacity(0.6),
                  size: 20,
                ),
              ),
            ),
          ),
          horizontalSpaceSmall,
          IconButton(
            onPressed: viewModel.toFilterView,
            icon: SvgPicture.asset(
              'assets/images/misc/equilizer.svg',
              color: kcPrimaryColorDark,
              width: 30.dg,
              height: 30.dg,
            ),
            color: kcPrimaryColor,
            iconSize: 30.dg,
          ),
        ],
      ),
    );
  }
}
