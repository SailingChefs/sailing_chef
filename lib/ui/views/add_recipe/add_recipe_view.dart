import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/cooking_instructions.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/cover_picture.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/ingredients.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/prep_time.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/recipe_title.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/serving_quantity_dropdown.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/tags.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/topbar.dart';

class AddRecipeView extends StackedView<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const AddRecipeView({this.drafts, super.key});

  @override
  Widget builder(
    BuildContext context,
    AddRecipeViewModel viewModel,
    Widget? child,
  ) {
    List<Ingredient>? ingredientsList;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: TopBarAddRecipeScreen(isDraft: drafts != null),
        body: viewModel.isBusy && drafts != null
            ? const Center(
                child: CircularProgressIndicator(color: kcPrimaryColor),
              )
            : GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      verticalSpaceMedium,
                      _WizardProgressBar(step: viewModel.currentStep),
                      verticalSpaceSmall,
                      _StepLabel(step: viewModel.currentStep),
                      verticalSpaceSmall,
                      Expanded(
                        child: PageView(
                          controller: viewModel.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: viewModel.onStepPageChanged,
                          children: [
                            _Step1(drafts),
                            _Step2(drafts, ingredientsList),
                            _Step3(drafts),
                          ],
                        ),
                      ),
                      _WizardNavBar(drafts: drafts),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void onViewModelReady(AddRecipeViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  AddRecipeViewModel viewModelBuilder(BuildContext context) =>
      AddRecipeViewModel(recipeModel: drafts);
}

// ─── Progress bar ─────────────────────────────────────────────────────────────

class _WizardProgressBar extends StatelessWidget {
  final int step;
  const _WizardProgressBar({required this.step});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _pill(filled: true),
        const SizedBox(width: 6),
        _pill(filled: step >= 1),
        const SizedBox(width: 6),
        _pill(filled: step >= 2),
      ],
    );
  }

  Widget _pill({required bool filled}) => Expanded(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 4,
          decoration: BoxDecoration(
            color: filled ? kcPrimaryColor : kcVeryLightGrey,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
}

class _StepLabel extends StatelessWidget {
  final int step;
  const _StepLabel({required this.step});

  static const _labels = [
    'Step 1 of 3 — Basics',
    'Step 2 of 3 — Ingredients',
    'Step 3 of 3 — Method & Publish',
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _labels[step],
        style: globalTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: kcBlackColor.withOpacity(0.4),
        ),
      ),
    );
  }
}

// ─── Step 1: Basics ───────────────────────────────────────────────────────────

class _Step1 extends ViewModelWidget<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const _Step1(this.drafts);

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return SingleChildScrollView(
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceSmall,
            RecipeTitle(drafts),
            verticalSpace(20),
            CoverPictureSelector(drafts),
            verticalSpace(20),
            ServingQuantity(drafts),
            verticalSpace(20),
            PrepTime(drafts),
            verticalSpace(20),
            AddFilters(drafts),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}

// ─── Step 2: Ingredients ──────────────────────────────────────────────────────

class _Step2 extends ViewModelWidget<AddRecipeViewModel> {
  final RecipeModel? drafts;
  final List<Ingredient>? ingredientsList;
  const _Step2(this.drafts, this.ingredientsList);

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          Ingredients(drafts),
          verticalSpace(20),
        ],
      ),
    );
  }
}

// ─── Step 3: Method & Publish ─────────────────────────────────────────────────

class _Step3 extends ViewModelWidget<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const _Step3(this.drafts);

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          CookingInstructions(drafts),
          verticalSpace(20),
        ],
      ),
    );
  }
}

// ─── Navigation buttons ───────────────────────────────────────────────────────

class _WizardNavBar extends ViewModelWidget<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const _WizardNavBar({required this.drafts});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    final isLast = viewModel.currentStep == 2;
    final isFirst = viewModel.currentStep == 0;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          if (!isFirst) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: viewModel.previousStep,
                style: OutlinedButton.styleFrom(
                  foregroundColor: kcPrimaryColor,
                  side: const BorderSide(color: kcPrimaryColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: ElevatedButton(
              onPressed: isLast
                  ? () => viewModel.previewRecipe()
                  : viewModel.nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: kcPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: Text(isLast ? 'Preview & Publish' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
}
