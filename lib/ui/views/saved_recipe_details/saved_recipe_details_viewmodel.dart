import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
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

import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';

import 'package:sailing_chefs/services/shopping_list_service.dart';

import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

import '../../../core/imports/core_imports.dart';

class SavedRecipeDetailsViewModel extends ReactiveViewModel {
  final RecipeModel recipeModel;

  SavedRecipeDetailsViewModel({required this.recipeModel});

  final _navigationService = locator<NavigationService>();

  final CommentService commentService = CommentService();
  final RecipeService recipeService = RecipeService();
  final SavedRecipeService _savedRecipeService = SavedRecipeService();
  final ShoppingListService _shoppingListService = ShoppingListService();

  String selectedTab = 'Ingredients';
  bool isIngredientsSelected = true;
  final TextEditingController commentController = TextEditingController();
  bool isMethodsSelected = false;
  final PageController pageController = PageController();
  final ImagePicker _picker = ImagePicker();
  final _serviceConversations = locator<ConversationService>();
  final TextEditingController notesController = TextEditingController();
  List<ShoppingList> get shoppingList => _shoppingListService.shoppingList;
  bool isRecipeSaved = false;
  List<RecipeModel> myRecipes = [];
  double volume = 0;
  bool isMute = false;
  List<File> images = [];
  double rating = 3.0;
  List<RecipeModel> recipeList = [];
  late final PlayerController playerController;
  late List<double>? waveFormData;
  bool isPlaying = false;
  bool seeComments = false;
  bool isRecipeSave = false;

  List<CommentModel> get commentsList => commentService.comments;

  List<RecipeModel> get savedRecipeList => _savedRecipeService.savedRecipes;

  void thisRecipeSaved(RecipeModel recipe) {
    _savedRecipeService.addSavedRecipe(recipe);
    isRecipeSave = !isRecipeSave;
    notifyListeners();
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
    for (RecipeModel savedRecipe in savedRecipeList) {
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
        _shoppingListService,
      ];

  void pickImage() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

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

    double totalRating = 0.0;

    for (var comment in comments) {
      if (comment.rating != null) {
        totalRating += comment.rating!;
      }
    }

    double averageRating = totalRating / comments.length;

    return averageRating.toStringAsFixed(1);
  }

  Future<void> moveToChatScreen(
    UserModel chef,
  ) async {
    var conversationModel = ConversationModel(
      latestMessage: '',
      users: [
        FirebaseAuth.instance.currentUser!.uid,
        chef.uid!,
      ],
      latestMessageType: 'text',
      latestMessageTime: DateTime.now(),
      lastActive: DateTime.now(),
      uid: "",
    );
    String conversationId = await _serviceConversations
        .createOrUpdateConversation(conversationModel);
    log('conversationId: $conversationId');
    _navigationService.navigateToChatView(
        receiver: chef, conversationId: conversationId);
  }

  void removeImage(int index) {
    images.removeAt(index);
    rebuildUi();
  }

  void addRating(double ratings) {
    log("Rating $ratings");
    rating = ratings;
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
      RecipeService.recipes
          .where((element) => element.docId == recipeId)
          .first
          .rating = calculateAverageRating(commentService.comments) as double;
      rebuildUi();

      showToast(message: 'Comment Added');
    }
  }

  void addOneItemToCart(Ingredient ingredient) {
    _shoppingListService.addOrRemoveFromShoppingList(ShoppingList(
        ingredientName: ingredient.name,
        quantity: ingredient.quantity,
        unit: ingredient.unit,
        id: '',
        recipeId: recipeModel.docId!,
        ingredientId: ingredient.id!));
    rebuildUi();
  }

  void addAllItemsToCart(RecipeModel recipe) async {
   

     List<ShoppingList> shoppingList = [];
    for (var ingredient in recipe.ingredients) {
      shoppingList.add(ShoppingList(
          ingredientName: ingredient.name,
          quantity: ingredient.quantity,
          unit: ingredient.unit,
          id: '',
          recipeId: recipe.docId!,
          ingredientId: ingredient.id!));
    }
    _shoppingListService.addOrRemoveAllFromShoppingList(shoppingList, recipe);

    rebuildUi();
  }

  bool checkShoppingList(Ingredient ingredient) {
    if (shoppingList.any((element) => element.ingredientId == ingredient.id)) {
      return true;
    }
    return false;
  }

  bool checkShoppingListAll(RecipeModel recipeModel) {
    
    return shoppingList.where((element) => element.recipeId == recipeModel.docId).length == recipeModel.ingredients.length;
    
  }

  void toRecipeDetails(RecipeModel recipe) {
    _navigationService.replaceWithTransition(
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
        break;
      case 1:
        selectedTab = 'Method';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  String formattedDuration = "";
  Future<void> durationCalculate(File path) async {
    if (path.path.isNotEmpty && waveFormData != null) {
      Duration duration = Duration(milliseconds: playerController.maxDuration);
      int minutes = duration.inMinutes;
      int seconds = duration.inSeconds % 60;
      formattedDuration = "$minutes:${seconds.toString().padLeft(2, '0')}";
      notifyListeners();
    }
  }

  Future<void> downloadAudio() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final response = await http.get(Uri.parse(recipeModel.chefNote));
    File audioFile = File("$tempPath/audio.mpeg4");
    if (response.statusCode == 200) {
      await audioFile.writeAsBytes(response.bodyBytes);

      log("Download Complete");
      await playerController
          .preparePlayer(
        path: audioFile.path,
        volume: 100,
      )
          .then((_) {
        durationCalculate(audioFile);
      });

      log("Player Ready");
    }
    durationCalculate(audioFile);
  }

  void durationStop() {
    playerController.onCompletion.listen((event) {
      stopListening();
    });
  }

  void startListening() async {
    log("start Listening ${isPlaying.toString()}");
    isPlaying = true;
    rebuildUi();
    playerController.onCurrentDurationChanged.listen((positionData) {
      Duration position = Duration(milliseconds: positionData);
      updateDuration(position);
    });

    await playerController.startPlayer(finishMode: FinishMode.pause);

    log("start Listening ends ${isPlaying.toString()}");

    durationStop();
  }

  void updateDuration(Duration position) async {
    if (position > Duration.zero) {
      formattedDuration =
          "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}";
      notifyListeners();
    }
  }

  void stopListening() async {
    log("stop Listening ${isPlaying.toString()}");
    await playerController.pausePlayer();
    isPlaying = false;
    log(isPlaying.toString());
    rebuildUi();
    log("stop Listening ends ${isPlaying.toString()}");
  }

  void onViewModelReady(String recipeId) async {
    setBusy(true);

    waveFormData = recipeModel.waveForm;
    await commentService.getComments(recipeId);
    playerController = PlayerController();
    await _shoppingListService.getShoppingList();

    await downloadAudio();

    servings = recipeModel.servingSize;


    checkSave(recipeId);
    setBusy(false);
  }

  int servings = 0;
  int updatedQuantity = 0;

  List<Ingredient> getUpdatedIngredients() {
    if (recipeModel == null) return [];
    return recipeModel.ingredients.map((ingredient) {
      int baseQuantity = int.parse(ingredient.quantity);
      updatedQuantity = baseQuantity * servings;
      return Ingredient(
        name: ingredient.name,
        quantity: updatedQuantity.toStringAsFixed(0),
        unit: ingredient.unit,
      );
    }).toList();
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
    bool saved = await recipeService.updatePrivateRecipe(recipe);
    if (saved == true) {
      _navigationService.replaceWithIndexView();
    } else {
      showToast(message: 'Error saving recipe publically');
    }
  }
}
