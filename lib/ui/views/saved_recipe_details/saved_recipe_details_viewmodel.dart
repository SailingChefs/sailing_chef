import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_cache/just_audio_cache.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/comment_service.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

import '../../../core/imports/core_imports.dart';
// import 'package:just_audio_cache/just_audio_cache.dart';

class SavedRecipeDetailsViewModel extends ReactiveViewModel {
  final RecipeModel recipeModel;

  SavedRecipeDetailsViewModel({required this.recipeModel});

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
  final ImagePicker _picker = ImagePicker();
  final _serviceConversations = locator<ConversationService>();

  List<File> images = [];
  double rating = 3.0;
  List<RecipeModel> recipeList = [];
  late final PlayerController playerController;
  late List<double>? waveFormData;
  bool isPlaying = false;
  bool seeComments = false;

  List<SavedRecipeModel> get savedRecipeList =>
      _savedRecipeService.savedRecipes;

  void addToSaveList(RecipeModel recipe) {
    _savedRecipeService.addSavedRecipe(SavedRecipeModel(
      recipeId: recipe.docId!,
    ));
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        commentService,
        _savedRecipeService,
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
      return '0.0'; // Return 0 if there are no comments
    }

    double totalRating = 0.0;

    // Calculate the total rating
    for (var comment in comments) {
      if (comment.rating != null) {
        totalRating += comment.rating!;
      }
    }

    // Calculate the average rating
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
      rebuildUi();
      notifyListeners();
      showToast(message: 'Comment Added');
    }
  }

  void toRecipeDetails(RecipeModel recipe) {
    _navigationService.replaceWithTransition(
        SavedRecipeDetailsView(
          recipeModel: recipe,
          randomRecipeList: IndexViewModel.getRandomDishes(recipe, []),
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

  Future<void> downloadAudio() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final response = await http.get(Uri.parse(recipeModel.chefNote));
    File audioFile = File("$tempPath/audio.mpeg4");
    if (response.statusCode == 200) {
      await audioFile.writeAsBytes(response.bodyBytes);
      log("Download Complete");
      await playerController.preparePlayer(
        path: audioFile.path,
        volume: 100,
      );
      log("Player Ready");
    }
  }

  void startListening() async {
    log("start Listening ${isPlaying.toString()}");
    isPlaying = true;
    rebuildUi();
    await playerController
        .startPlayer(finishMode: FinishMode.pause)
        .then((value) {
      // isPlaying = false;
      // rebuildUi();
    });
    log("start Listening ends ${isPlaying.toString()}");
  }

  void stopListening() async {
    log("stop Listening ${isPlaying.toString()}");
    await playerController.pausePlayer();
    isPlaying = false;
    log(isPlaying.toString());
    rebuildUi();
    log("stop Listening ends ${isPlaying.toString()}");
  }

  void onViewModelReady(int length, String recipeId) async {
    setBusy(true);

    waveFormData = recipeModel.waveForm;
    await _savedRecipeService.init();
    playerController = PlayerController();
    downloadAudio();
    // recipeList = await recipeService.fetchRandomRecipes(5, recipeId);

    setBusy(false);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
