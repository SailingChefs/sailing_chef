// ignore_for_file: prefer_const_constructors


import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/container_top.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/maincontainer.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'recipe_view_viewmodel.dart';

class RecipeViewView extends StackedView<RecipeViewViewModel> {
  final RecipeModel recipeModel;

  final List<XFile> selectedImages;
  final List<String> draftUrls;
  final List<double>? waveFormData;
  final String? path;

  const RecipeViewView(this.recipeModel, this.selectedImages, this.draftUrls,
      {Key? key, this.waveFormData, this.path})
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
            top: 40,
            left: 10,
            child: BackArrowWidget(onTap: () {
              viewModel.moveBack();
            }),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.39,
            right: 30,
            child: Container(
            height: 70.h,
            width: 70.w,
            decoration: BoxDecoration(
              color: kcVeryLightGrey,
              shape: BoxShape.circle,
              border: Border.all(
                color: kcsgreycolor,
                width: 4.5,
              )
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: userDetails!.displayPicture == ''
                  ? Image.asset(
                      'assets/images/misc/blank_image.png',
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      userDetails!.displayPicture!,
                      fit: BoxFit.cover,
                      height: 90,
                      width: 90,
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
      );

  @override
  void onViewModelReady(RecipeViewViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }
}
