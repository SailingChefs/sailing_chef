import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fraction/fraction.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/shopping_list.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/comment_service.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/services/shopping_list_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class SavedRecipeDetailsViewModel extends ReactiveViewModel {
  final RecipeModel recipeModel;

  final _bottomSheetService = locator<BottomSheetService>();
  final shoppingListService = locator<ShoppingListService>();
  final userService = locator<UserServices>();

  SavedRecipeDetailsViewModel({required this.recipeModel});

  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final CommentService commentService = CommentService();
  final RecipeService recipeService = RecipeService();
  final SavedRecipeService _savedRecipeService = SavedRecipeService();

  String selectedTab = 'Ingredients';
  bool isIngredientsSelected = true;
  final TextEditingController commentController = TextEditingController();
  bool isMethodsSelected = false;
  final PageController pageController = PageController();
  final ImagePicker _picker = ImagePicker();
  final _serviceConversations = locator<ConversationService>();
  final TextEditingController notesController = TextEditingController();
  List<ShoppingItem> get shoppingList => shoppingListService.shoppingList;
  bool isRecipeSaved = false;
  List<RecipeModel> myRecipes = [];
  double volume = 0;
  bool isMute = false;
  List<File> images = [];
  double rating = 0.0;
  List<RecipeModel> recipeList = [];
  late final PlayerController playerController;
  late List<double>? waveFormData;
  bool isPlaying = false;
  bool seeComments = false;
  bool isRecipeSave = false;
  CommentModel? currentEditingComment;
  bool isEditingComment = false;

  List<CommentModel> get commentsList => commentService.comments;

  List<RecipeModel> get savedRecipeList => _savedRecipeService.savedRecipes;

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  String parseQuantity(String quantity, int serving) {
    try {
      if (quantity.contains('/')) {
        // If the quantity contains a fraction, convert it to a Fraction object
        final fraction = Fraction.fromString(quantity);
        final result =
            fraction * Fraction(serving); // Convert int serving to Fraction
        return result.toString();
      } // If it's a whole number, just multiply it as an integer
      final parsedQuantity = int.parse(quantity);
      return (parsedQuantity * serving).toString();
    } catch (e) {
      // Handle parsing error, if any
      print('Error parsing quantity: $e');
      return quantity;
    }
  }

  Future<void> updateShoppingList() async {
    try {
      await userService.updateShoppingList();
    } catch (e, stackTrace) {
      log('Failed to update shopping list in view model: $e');
      log('StackTrace: $stackTrace');
    }
  }

  void addorRemoveAllIIngredients(
      {required RecipeModel recipee, required int servings}) {
    shoppingListService.addAllItemstoShoppingList(
        recipee: recipee, servings: servings);
    rebuildUi();

    log(shoppingRecipeeIngredient.toString());
  }

  bool checkkAllIngredients({required RecipeModel recipee}) {
    final check =
        shoppingListService.checkAllSelectedIngredients(recipee: recipee);
    // rebuildUi();
    return check;
  }
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  void thisRecipeSaved(RecipeModel recipe) {
    _savedRecipeService.addSavedRecipe(recipe);
    isRecipeSave = !isRecipeSave;
    notifyListeners();
  }

  // **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
  Future<void> onLongPressComment(CommentModel comment) async {
    if (comment.userId != FirebaseAuth.instance.currentUser!.uid) return;

    final res = await _dialogService.showCustomDialog(
        variant: DialogType.longPressComment);
    log(res!.data.toString());

    if (res.data == null) return;
    if (res.data == true) onCommentLongPress(comment);
    if (res.data == false) deleteComment(comment);
  }

  void onCommentLongPress(CommentModel comment) {
    currentEditingComment = comment;
    isEditingComment = true;
    commentController.text = comment.content ?? '';

    rating = comment.rating ?? 0;
    notifyListeners();
  }

  Future<void> deleteComment(CommentModel comment) async {
    final res = await commentService.deleteComment(comment);

    if (res) {
      commentsList.remove(comment);
    }

    notifyListeners();
  }

  // **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************
// **********************************************************

  Future<void> updateComment() async {
    if (currentEditingComment != null) {
      currentEditingComment!.content = commentController.text;
      currentEditingComment!.rating = rating;

      final success =
          await commentService.updateCommentInFirestore(currentEditingComment!);
      if (success) {
        showToast(message: 'Comment updated successfully');
        isEditingComment = false;
        commentController.clear();
        currentEditingComment = null;
        notifyListeners();
      } else {
        showToast(message: 'Error updating comment');
      }
    }
  }

  void addToSaveList(RecipeModel recipe) {
    _savedRecipeService.addSavedRecipe(recipe);
    isRecipeSaved = !isRecipeSaved;
    notifyListeners();
  }

  void onVolumeUpIconPressed() {
    isMute = !isMute;
    if (isMute) {
      volume = 0;
    } else {
      volume = 100;
    }
    playerController.setVolume(volume);
    notifyListeners();
  }

  void incrementServings() {
    servings += 1;
    rebuildUi();
    notifyListeners();
  }

  void decrementServings() {
    if (servings <= 1) {
      servings = 1;
      showToast(message: 'Minimum servings are 1');
      rebuildUi();
    } else {
      servings--;
      rebuildUi();
    }
  }

  void checkSave(String recipeId) {
    for (final savedRecipe in savedRecipeList) {
      if (savedRecipe.docId == recipeId) {
        isRecipeSaved = !isRecipeSaved;
        break;
      }
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        commentService,
        _savedRecipeService,
        shoppingListService,
      ];

  Future<void> pickImage() async {
    final selectedImages = await _picker.pickMultiImage();

    images.addAll(selectedImages.map((xFile) => File(xFile.path)));
    rebuildUi();
  }

  void seeCommentsAll() {
    seeComments = !seeComments;
    notifyListeners();
    rebuildUi();
  }

  String calculateAverageRating(List<CommentModel> comments) {
    if (comments.isEmpty) {
      return '0.0';
    }

    var totalRating = 0.0;

    for (final comment in comments) {
      if (comment.rating != null) {
        totalRating += comment.rating!;
      }
    }

    final averageRating = totalRating / comments.length;

    return averageRating.toStringAsFixed(1);
  }

  Future<void> moveToChatScreen(
    UserModel chef,
  ) async {
    final conversationModel = ConversationModel(
      latestMessage: '',
      users: [
        FirebaseAuth.instance.currentUser!.uid,
        chef.uid!,
      ],
      latestMessageType: 'text',
      latestMessageTime: DateTime.now(),
      lastActive: DateTime.now(),
      uid: '',
    );
    final conversationId = await _serviceConversations
        .createOrUpdateConversation(conversationModel);
    log('conversationId: $conversationId');
    _navigationService.navigateToChatView(
        messageFromCource: '', receiver: chef, conversationId: conversationId);
  }

  void removeImage(int index) {
    images.removeAt(index);
    rebuildUi();
  }

  void addRating(double ratings) {
    log('Rating $ratings');
    rating = ratings;
    rebuildUi();
    notifyListeners();
  }

  void myIngredientsSelected() {
    isIngredientsSelected = true;
    isMethodsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  // void addComment(String recipeId) async {
  //   bool uploaded;
  //   List<String>? imageUrls;
  //   if (images != []) {
  //     imageUrls = await commentService.uploadImagesToFirebase(images);
  //   }
  //   uploaded = await commentService.addComment(CommentModel(
  //       userId: userDetails!.uid!,
  //       recipeId: recipeId,
  //       content: commentController.text.isNotEmpty ? commentController.text : '',
  //       timestamp: Timestamp.now(),
  //       rating: rating,
  //       userName: userDetails!.displayName!,
  //       userImageUrl: userDetails!.displayPicture!,
  //       imageUrl: imageUrls));

  //   if (uploaded) {
  //     commentController.clear();
  //     images.clear();
  //     rating = rating;
  //     RecipeService.recipes
  //         .where((element) => element.docId == recipeId)
  //         .first
  //         .rating = calculateAverageRating(commentService.comments) as double;
  //     rebuildUi();

  //     showToast(message: 'Comment Added');
  //   }
  // }
  Future<void> addComment(String recipeId) async {
    bool uploaded;
    List<String>? imageUrls;

    // Check if rating is a valid double, otherwise set it to null or a default value
    double? validRating;
    try {
      validRating = double.parse(rating.toString());
    } catch (e) {
      validRating = null;
    }

    if (images.isNotEmpty) {
      imageUrls = await commentService.uploadImagesToFirebase(images);
    }

    // Make sure there's at least a rating or content
    if (validRating == null &&
        (commentController.text.isEmpty ||
            commentController.text.trim().isEmpty)) {
      showToast(message: 'Please provide a rating or comment');
      return;
    }

    final newComment = CommentModel(
      userId: userDetails!.uid!,
      recipeId: recipeId,
      content: commentController.text,
      timestamp: Timestamp.now(),
      rating: validRating,
      userName: userDetails!.displayName!,
      userImageUrl: userDetails!.displayPicture!,
      imageUrl: imageUrls,
    );

    uploaded = await commentService.addComment(newComment);

    if (uploaded) {
      commentController.clear();
      images.clear();
      rating = 0;
      RecipeService.recipes
          .where((element) => element.docId == recipeId)
          .first
          .rating = calculateAverageRating(commentService.comments);
      rebuildUi();
      showToast(message: 'Comment Added');
    }
  }

  void addOneItemToCart(
      {required RecipeModel recipee, required Ingredient ingredient}) {
    shoppingListService.addNewIngredienttoSHoppingList(
        ingredient: ingredient, recipee: recipee);

    // log(shoppingListService.shoppingRecipeeIngredient.toString());
    // log("\n\n");
    // log("selected recipees : ${shoppingListService.selectedRecipees.toString()}");

    // _shoppingListService.addOrRemoveFromShoppingList(
    //   ShoppingItem(
    //     ingredients: recipeModel.ingredients,
    //     recipeName: recipeModel.title,
    //     ingredientName: ingredient.name,
    //     quantity: ingredient.quantity,
    //     unit: ingredient.unit,
    //     id: '',
    //     recipeId: recipeModel.docId!,
    //     ingredientId: ingredient.id!,
    //   ),
    // );
    rebuildUi();
  }

  bool checkSelected(
      {required RecipeModel recipee, required Ingredient ingredient}) {
    return shoppingListService.checkSelectedIngredient(
        recipee: recipee, ingredient: ingredient);
  }

  void addAllItemsToCart(RecipeModel recipe) {
    final shoppingList = <ShoppingItem>[];
    for (final ingredient in recipe.ingredients) {
      shoppingList.add(ShoppingItem(
          recipeName: recipe.title,
          ingredientName: ingredient.name,
          quantity: ingredient.quantity,
          unit: ingredient.unit,
          id: '',
          recipeId: recipe.docId!,
          ingredientId: ingredient.id));
    }
    shoppingListService.addOrRemoveAllFromShoppingList(shoppingList, recipe);

    rebuildUi();
  }

  bool checkShoppingList(Ingredient ingredient) {
    if (shoppingList.any((element) => element.ingredientId == ingredient.id)) {
      return true;
    }
    return false;
  }

  bool checkShoppingListAll(RecipeModel recipeModel) {
    return shoppingList
            .where((element) => element.recipeId == recipeModel.docId)
            .length ==
        recipeModel.ingredients.length;
  }

  void toRecipeDetails(RecipeModel recipe) {
    _navigationService.replaceWithTransition(
        opaque: true,
        SavedRecipeDetailsView(
          isFromPrivateProfile: false,
          recipeModel: recipe,
          randomRecipeList:
              IndexViewModel.getRandomDishes(recipe, RecipeService.recipes),
        ),
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
      case 1:
        selectedTab = 'Method';

      default:
        break;
    }

    rebuildUi();
  }

  String formattedDuration = '';
  void durationCalculate(File path) {
    if (path.path.isNotEmpty && waveFormData != null) {
      final duration = Duration(milliseconds: playerController.maxDuration);
      final minutes = duration.inMinutes;
      final seconds = duration.inSeconds % 60;
      formattedDuration = "$minutes:${seconds.toString().padLeft(2, '0')}";
      notifyListeners();
    }
  }

  Future<void> downloadAudio() async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final response = await http.get(Uri.parse(recipeModel.chefNote));
    final audioFile = File('$tempPath/audio.mpeg4');
    if (response.statusCode == 200) {
      await audioFile.writeAsBytes(response.bodyBytes);

      log('Download Complete');
      await playerController
          .preparePlayer(
        path: audioFile.path,
        volume: 100,
      )
          .then((_) {
        durationCalculate(audioFile);
      });

      log('Player Ready');
    }
    durationCalculate(audioFile);
  }

  void durationStop() {
    playerController.onCompletion.listen((event) {
      stopListening();
    });
  }

  Future<void> startListening() async {
    log('start Listening $isPlaying');
    isPlaying = true;
    rebuildUi();
    playerController.onCurrentDurationChanged.listen((positionData) {
      final position = Duration(milliseconds: positionData);
      updateDuration(position);
    });

    await playerController.setFinishMode(finishMode: FinishMode.pause);

    log('start Listening ends $isPlaying');

    durationStop();
  }

  void updateDuration(Duration position) {
    if (position > Duration.zero) {
      formattedDuration =
          "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}";
      notifyListeners();
    }
  }

  Future<void> stopListening() async {
    log('stop Listening $isPlaying');
    await playerController.pausePlayer();
    isPlaying = false;
    log(isPlaying.toString());
    rebuildUi();
    log('stop Listening ends $isPlaying');
  }

  Future<void> onViewModelReady(String recipeId) async {
    setBusy(true);
    EasyLoading.show();

    // waveFormData = recipeModel.waveForm;
    await commentService.getComments(recipeId);
    playerController = PlayerController();
    await shoppingListService.getShoppingList();

    // await downloadAudio();

    servings = recipeModel.servingSize;

    checkSave(recipeId);
    EasyLoading.dismiss();

    log('\n\n\n\n\t\t\t\tShopping List : $shoppingRecipeeIngredient');

    setBusy(false);
  }

  int servings = 1;
  Fraction updatedQuantity = Fraction(1);

  Fraction parseInput(String input) {
    if (input.contains('/')) {
      return Fraction.fromString(input);
    }
    return Fraction(int.tryParse(input) ?? 0);
  }

  // List<Ingredient> getUpdatedIngredients() {
  //   return recipeModel.ingredients.map((ingredient) {
  //     int baseQuantity = int.parse(ingredient.quantity);
  //     updatedQuantity = baseQuantity * servings;
  //     return Ingredient(
  //       name: ingredient.name,
  //       quantity: updatedQuantity.toStringAsFixed(0),
  //       unit: ingredient.unit,
  //       id: ingredient.id,
  //     );
  //   }).toList();
  // }

  // List<Ingredient> getUpdatedIngredients() {
  //   return recipeModel.ingredients.map((ingredient) {
  //     Fraction baseQuantity;

  //     // Parse the base quantity as a Fraction
  //     if (ingredient.quantity.contains('/')) {
  //       baseQuantity = Fraction.fromString(ingredient.quantity);
  //     } else {
  //       baseQuantity = Fraction(int.tryParse(ingredient.quantity) ?? 0);
  //     }

  //     // Increment the quantity by itself
  //     updatedQuantity = baseQuantity * Fraction(servings);

  //     // updatedQuantity = baseQuantity + Fraction.fromString(ingredient.quantity);

  //     return Ingredient(
  //       name: ingredient.name,
  //       quantity: updatedQuantity.toString(),
  //       unit: ingredient.unit,
  //       id: ingredient.id,
  //     );
  //   }).toList();
  // }

  List<Ingredient> getUpdatedIngredients(int servings) {
    return recipeModel.ingredients.map((ingredient) {
      Fraction baseQuantity;

      // Parse the base quantity as a Fraction
      if (ingredient.quantity.contains('/')) {
        baseQuantity = Fraction.fromString(ingredient.quantity);
      } else {
        baseQuantity = Fraction(int.tryParse(ingredient.quantity) ?? 0);
      }

      // // Calculate the updated quantity
      // Fraction updatedQuantity =
      //     baseQuantity + (baseQuantity * Fraction(servings));

      // // Simplify the fraction if possible
      // updatedQuantity = updatedQuantity.reduce();

      // Convert the fraction to a string
      final updatedQuantityString = baseQuantity.toString();

      return Ingredient(
        serving: servings,
        name: ingredient.name,
        quantity: updatedQuantityString,
        unit: ingredient.unit,
        id: ingredient.id,
      );
    }).toList();
  }

  bool isOwnRecipe(RecipeModel recipe) {
    // log("The Recipe Owner UID is         :    ${recipe.uid}");
    // log("Current user      UID is         :    ${FirebaseAuth.instance.currentUser!.uid}");
    return recipe.uid == FirebaseAuth.instance.currentUser!.uid;
  }

  bool checkHasReviewed(List<CommentModel> comments) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return comments.any((comment) => comment.userId == userId);
  }

  @override
  void dispose() {
    pageController.dispose();
    playerController.dispose();
    commentController.dispose();
    stopListening();

    super.dispose();
  }

  Future<void> publicRecipe(RecipeModel recipe) async {
    final saved = await recipeService.updatePrivateRecipe(recipe);
    if (saved) {
      RecipeService.recipes.add(recipe);
      _navigationService.replaceWithBottomNavBarView();
    } else {
      showToast(message: 'Error saving recipe publicly');
    }
  }

  void showSocialIconsBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.socialIcons,
      data: recipeModel,
    );
  }

  void viewChefProfile(UserModel user) {
    if (user.uid != FirebaseAuth.instance.currentUser!.uid) {
      _navigationService.navigateToChefProfileView(user: user);
    }
  }
}
