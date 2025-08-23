// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/search/search_viewmodel.dart';

// ignore: must_be_immutable
class SearchBarSearchScreen extends ViewModelWidget<SearchViewModel> {
  final List<RecipeModel> recipes;
  int? selectedTagsCount;
  SearchBarSearchScreen(this.selectedTagsCount, {required this.recipes, super.key});

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.795,
          height: 40.dg,
          child: TextField(
            controller: viewModel.isRecipeSelected
                ? viewModel.searchControllerRecipe
                : viewModel.searchControllerChef,
            onEditingComplete: () => viewModel.rebuildUi(),
            onChanged: (value) => viewModel.rebuildUi(),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: kcBlackColor.withOpacity(0.6),
                fontSize: 12.sp,
              ),
              filled: true,
              fillColor: kcWhiteColor,
              labelStyle: TextStyle(fontSize: 14.sp, color: kcBlackColor.withOpacity(0.6)),
              labelText: viewModel.isRecipeSelected ? 'Find Recipes...' : 'Find Chefs...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0.r),
                borderSide: BorderSide(color: kcBlackColor.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0.r),
                borderSide: BorderSide(color: kcBlackColor.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0.r),
                borderSide:
                    BorderSide(color: kcBlackColor.withOpacity(0.2)), // Unfocused border color
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
                color: kcBlackColor.withOpacity(0.5),
                size: 20,
              ),
            ),
          ),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {
                viewModel.toFilterScreen(recipes);
              },
              icon: SvgPicture.asset(
                'assets/images/misc/equilizer.svg',
                color: filterIconColor,
                width: 30,
                height: 30,
              ),
              color: kcPrimaryColor,
              iconSize: 32.h,
            ),
            Positioned(
              top: 3,
              left: 25,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  color: filterIconColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  selectedTagsCount?.toString() ?? 'No selected tags',
                  style: globalTextStyle(fontSize: 10.sp, color: kcwhitecolor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
