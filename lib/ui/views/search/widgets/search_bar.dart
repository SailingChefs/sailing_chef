import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/search/search_viewmodel.dart';

class SearchBarSearchScreen
    extends ViewModelWidget<SearchViewModel> {
      final List<RecipeModel> recipes;

      
  const SearchBarSearchScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: 40.dg,
          child: TextField(
            textAlign: TextAlign.start,
            controller: viewModel.isRecipeSelected ?  viewModel.searchControllerRecipe : viewModel.searchControllerChef,
            onEditingComplete: () => viewModel.rebuildUi(),
            onChanged: (value) => viewModel.rebuildUi(),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: kcBlackColor.withOpacity(0.6),
                fontSize: 12.sp,
              ),
              filled: true,
              fillColor: kcWhiteColor,
              labelStyle: TextStyle(
                  fontSize: 12.sp, color: kcBlackColor.withOpacity(0.6)),
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
                borderSide: BorderSide(color: kcBlackColor.withOpacity(0.2)), // Unfocused border color
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
          onPressed:()=> viewModel.toFilterScreen(recipes),
          icon: const Icon(FlutterRemix.equalizer_line),
          color: kcPrimaryColor,
          iconSize: 30.dg,
        ),
      ],
    );
  }
}
