// ignore_for_file: prefer_const_constructors

import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/container_top.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/maincontainer.dart';

import 'recipe_view_viewmodel.dart';

class RecipeViewView extends StackedView<RecipeViewViewModel> {
  final RecipeModel recipeModel;
  final bool isFromDraft;
  final List<XFile> selectedImages;
  final List<String> draftUrls;
  final List<double>? waveFormData;
  final String? path;

  const RecipeViewView(this.recipeModel, this.selectedImages, this.draftUrls,
      {Key? key, this.waveFormData, this.path,required this.isFromDraft})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RecipeViewViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          TopBarRecipeView(selectedImages, draftUrls),
          MainRecipeViewContainer(recipeModel, selectedImages),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right: 30,
            child: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: kcVeryLightGrey,
                border: Border.all(
                  color: kcWhiteColor,
                  width: 3.0,
                ),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: userDetails!.displayPicture == null
                      ? const AssetImage('assets/images/misc/blank_image.png')
                      : NetworkImage(userDetails!.displayPicture!)
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () => viewModel.moveBack(),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8.0.dg),
                height: 36.h,
                width: 36.w,
                decoration: const BoxDecoration(
                  color: kcVeryLightGrey,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: kcBlackColor,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  RecipeViewViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeViewViewModel(
        draftUrls,
        selectedImages,
        waveFormData: waveFormData,
        path: path,
        recipeModel,
        isFromDraft: isFromDraft,
      );

  @override
  void onViewModelReady(RecipeViewViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }
}
