import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_form.dart';

import 'add_recipe_viewmodel.dart';

class AddRecipeView extends StackedView<AddRecipeViewModel> {
  final RecipeModel? drafts;
  const AddRecipeView({
    this.drafts,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddRecipeViewModel viewModel,
    Widget? child,
  ) {
    final stepTitles = ['Basics', 'Ingredients', 'Method & Notes'];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: viewModel.wizardStep > 0
                        ? viewModel.goToPreviousStep
                        : viewModel.popBack,
                    child: Icon(
                      viewModel.wizardStep > 0
                          ? Icons.arrow_back_ios_new
                          : Icons.close,
                      size: 22,
                      color: kcBlackColor,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Create Recipe',
                        style: globalTextStyle(
                          fontSize: 16.0.dg,
                          color: kcBlackColor,
                          letterSpacing: -0.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Step ${viewModel.wizardStep + 1} of 3 — ${stepTitles[viewModel.wizardStep]}',
                        style: globalTextStyle(
                          fontSize: 12.sp,
                          color: kcBlackColor.withOpacity(0.5),
                          letterSpacing: -0.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: viewModel.showDraftDialog,
                    child: Icon(
                      Icons.file_copy_outlined,
                      color: kcPrimaryColor,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // ── Progress bar ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: List.generate(3, (i) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                      decoration: BoxDecoration(
                        color: i <= viewModel.wizardStep
                            ? kcPrimaryColor
                            : kcVeryLightGrey,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 8),

            // ── Step content ────────────────────────────────────────────────
            Expanded(
              child: viewModel.isBusy && drafts != null
                  ? const Center(
                      child: CircularProgressIndicator(color: kcPrimaryColor),
                    )
                  : GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: IndexedStack(
                        index: viewModel.wizardStep,
                        children: [
                          AddRecipeStep1(drafts),
                          AddRecipeStep2(drafts),
                          AddRecipeStep3(drafts),
                        ],
                      ),
                    ),
            ),

            // ── Navigation buttons ───────────────────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
              child: Row(
                children: [
                  if (viewModel.wizardStep > 0) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: viewModel.goToPreviousStep,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: kcPrimaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          'Back',
                          style: globalTextStyle(
                            fontSize: 14.sp,
                            color: kcPrimaryColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: viewModel.wizardStep == 2
                          ? viewModel.previewRecipe
                          : viewModel.goToNextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            viewModel.wizardStep == 2 ? 'Publish' : 'Next',
                            style: globalTextStyle(
                              fontSize: 14.sp,
                              color: kcWhiteColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.3,
                            ),
                          ),
                          if (viewModel.wizardStep == 2) ...[
                            const SizedBox(width: 6),
                            const Icon(Icons.check_circle_outline,
                                color: kcWhiteColor, size: 18),
                          ] else ...[
                            const SizedBox(width: 6),
                            const Icon(Icons.arrow_forward_ios,
                                color: kcWhiteColor, size: 14),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
  AddRecipeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddRecipeViewModel(recipeModel: drafts);
}
