import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/cooking_instructions.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/cover_picture.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/ingredients.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/prep_time.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/recipe_title.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/serving_quantity_dropdown.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/tags.dart';

// ── Step 1: Basics ──────────────────────────────────────────────────────────
class AddRecipeStep1 extends ViewModelWidget<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const AddRecipeStep1(this.drafts, {super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(8.h),
            RecipeTitle(drafts),
            verticalSpace(20.h),
            CoverPictureSelector(drafts),
            verticalSpace(20.h),
            PrepTime(drafts),
            verticalSpace(20.h),
            ServingQuantity(drafts),
            verticalSpace(20.h),
            _DifficultySelector(),
            verticalSpace(20.h),
            AddFilters(drafts),
            verticalSpace(20.h),
          ],
        ),
      ),
    );
  }
}

// ── Step 2: Ingredients ─────────────────────────────────────────────────────
class AddRecipeStep2 extends ViewModelWidget<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const AddRecipeStep2(this.drafts, {super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(8.h),
          Text(
            'Build your ingredient list',
            style: globalTextStyle(
              fontSize: 13.sp,
              color: kcBlackColor.withOpacity(0.5),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.3,
            ),
          ),
          verticalSpace(16.h),
          Ingredients(drafts),
          verticalSpace(20.h),
        ],
      ),
    );
  }
}

// ── Step 3: Method & Notes ──────────────────────────────────────────────────
class AddRecipeStep3 extends ViewModelWidget<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const AddRecipeStep3(this.drafts, {super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(8.h),
          Text(
            'Add your cooking steps in order',
            style: globalTextStyle(
              fontSize: 13.sp,
              color: kcBlackColor.withOpacity(0.5),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.3,
            ),
          ),
          verticalSpace(16.h),
          CookingInstructions(drafts),
          verticalSpace(24.h),
          _ChefsNotesField(),
          verticalSpace(20.h),
        ],
      ),
    );
  }
}

// ── Difficulty chip selector ─────────────────────────────────────────────────
class _DifficultySelector extends ViewModelWidget<AddRecipeViewModel> {
  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficulty',
          style: globalTextStyle(
            fontSize: 14.sp,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w600,
            color: kcBlackColor,
          ),
        ),
        verticalSpaceSmall,
        Wrap(
          spacing: 8,
          children: AddRecipeViewModel.difficultyOptions.map((option) {
            final selected = viewModel.selectedDifficulty == option;
            return GestureDetector(
              onTap: () => viewModel.selectDifficulty(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? kcPrimaryColor
                      : kcPrimaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  option,
                  style: globalTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                    color:
                        selected ? kcWhiteColor : kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ── Chef's notes text field ──────────────────────────────────────────────────
class _ChefsNotesField extends ViewModelWidget<AddRecipeViewModel> {
  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Chef's Notes",
          style: globalTextStyle(
            fontSize: 14.sp,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w600,
            color: kcBlackColor,
          ),
        ),
        verticalSpaceSmall,
        Container(
          decoration: BoxDecoration(
            color: kcPrimaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: viewModel.chefNotesController,
            maxLines: 4,
            minLines: 3,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            style: globalTextStyle(
              fontSize: 13.sp,
              color: kcBlackColor.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.3,
            ),
            decoration: InputDecoration(
              hintText: 'Share any tips, tricks, or personal touches…',
              hintStyle: globalTextStyle(
                fontSize: 12.sp,
                color: kcBlackColor.withOpacity(0.35),
                fontWeight: FontWeight.w400,
                letterSpacing: -0.3,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}
