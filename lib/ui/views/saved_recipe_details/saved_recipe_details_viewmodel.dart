import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/comment_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

import '../../../core/imports/core_imports.dart';

class SavedRecipeDetailsViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  // final PageController pageController = PageController();
  final CommentService commentService = CommentService();
  final RecipeService recipeService = RecipeService();
  final SavedRecipeService _savedRecipeService = SavedRecipeService();
  String selectedTab = 'Ingredients';
  bool isIngredientsSelected = true;
  final TextEditingController commentController = TextEditingController();
  bool isMethodsSelected = false;
  final PageController pageController = PageController();
  Timer? _timer;
  final ImagePicker _picker = ImagePicker();
  List<File> images = [];
  double rating = 3.0;
  List<RecipeModel> recipeList = [];
  List<SavedRecipeModel> get savedRecipeList =>
      _savedRecipeService.savedRecipes;

  void addToSaveList(RecipeModel recipe) {
    _savedRecipeService.addSavedRecipe(SavedRecipeModel(
      recipeId: recipe.docId,
      userId: userDetails!.uid!,
    ));
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        commentService,
        _savedRecipeService,
      ];

  List<CommentModel> get fetchComment {
    return commentService.comments;
  }

  void pickImage() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    images.addAll(selectedImages.map((xFile) => File(xFile.path)));
    rebuildUi();
  }

  void removeImage(int index) {
    images.removeAt(index);
    rebuildUi();
  }




  void addRating(double rating) {
    this.rating = rating;
    rebuildUi();
  }

  void myIngredientsSelected() {
    isIngredientsSelected = true;
    isMethodsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void addComment(String recipeId) async {
    bool uploaded;
    List<String>? imageUrls;
    if (images != []) {
      imageUrls = await commentService.uploadImagesToFirebase(images);
    }
    uploaded = await commentService.addComment(CommentModel(
        userId: userDetails!.uid!,
        recipeId: recipeId,
        content: commentController.text,
        timestamp: Timestamp.now(),
        rating: rating,
        userName: userDetails!.displayName!,
        userImageUrl: userDetails!.displayPicture!,
        imageUrl: imageUrls));

    if (uploaded) {
      commentController.clear();
      images.clear();
      rating = rating;
      rebuildUi();
      showToast(message: 'Comment Added');
    }
  }

  void toRecipeDetails(RecipeModel recipe) {
    _navigationService.replaceWithTransition(
        SavedRecipeDetailsView(recipeModel: recipe),
        transitionStyle: Transition.fade,
        preventDuplicates: false);
  }

  void methodsSelected() {
    isMethodsSelected = true;
    isIngredientsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void moveBack() {
    _navigationService.back();
  }

  void moveToChefProfileView(UserModel user) {
    _navigationService.navigateToChefProfileView(user: user);
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Ingredients';
        break;
      case 1:
        selectedTab = 'Method';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void onViewModelReady(int length, String recipeId) async {
    setBusy(true);

    await commentService.clearComments();
    await _savedRecipeService.init();
    await commentService.getComments(recipeId);
    recipeList = await recipeService.fetchRandomRecipes(5);
    setBusy(false);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
