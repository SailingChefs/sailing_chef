import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:video_player/video_player.dart';

class RecipeViewViewModel extends BaseViewModel {
  PageController pageController = PageController(viewportFraction: 1.0);
  late final PlayerController playerController;
  late VideoPlayerController controller;
  final navigationService = locator<NavigationService>();
  final _recipeService = locator<RecipeService>();
  String selectedTab = 'Ingredients';
  bool isIngredientsSelected = true;
  bool isMethodsSelected = false;
  bool isclicked = false;
  bool isPlaying = false;
  final List<String> prevImageUrls;
  final List<XFile> newImageUrls;
  final RecipeModel? recipe;

  List<dynamic> get selectedImages => [...prevImageUrls, ...newImageUrls];

  Timer? _timer;
  List<double>? waveFormData;
  String? path;
  int? duration;
  List<RecipeModel>? myRecipes;
  RecipeViewViewModel(
    this.prevImageUrls,
    this.newImageUrls,
    this.recipe, {
    this.waveFormData,
    this.path,
  });

  void onViewModelReady() async {
    isclicked = false;
    servings = recipe!.servingSize;
    setBusy(true);
    playerController = PlayerController();
    myRecipes = await _recipeService.fetchRecipesByUID(userDetails!.uid!);

    await playerController.preparePlayer(
      path: path!,
      volume: 100,
    );

    // duration = await playerController.getDuration(DurationType.values[0]);

    setBusy(false);
  }

  int servings = 0;

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

  void durationStop() {
    playerController.onCompletion.listen((event) {
      stopListening();
    });
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
    durationStop();
  }

  void stopListening() async {
    log("stop Listening ${isPlaying.toString()}");
    await playerController.pausePlayer();
    isPlaying = false;
    log(isPlaying.toString());
    rebuildUi();
    log("stop Listening ends ${isPlaying.toString()}");
  }

  void myIngredientsSelected() {
    isIngredientsSelected = true;
    isMethodsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void methodsSelected() {
    isMethodsSelected = true;
    isIngredientsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void moveBack() {
    navigationService.back();
  }

  void saveRecipe(RecipeModel recipe, List<XFile?> selectedImages) async {
    List<String> imageUrls = await _recipeService.uploadMediaToFirebase(
        selectedImages, recipe.docId!);
    final String chefNote =
        await _recipeService.uploadChefNoteToFirebaseStorage(path!);
    try {
      log("id${recipe.docId!}");
      await _recipeService
          .addRecipeToFirestore(RecipeModel(
            visibility: recipe.visibility,
            chefNote: chefNote,
            coverImage: recipe.coverImage + imageUrls,
            createdTime: Timestamp.now(),
            ingredients: recipe.ingredients,
            methods: recipe.methods,
            prepTime: recipe.prepTime,
            servingSize: servings,
            status: 'published',
            title: recipe.title,
            tags: recipe.tags,
            uid: recipe.uid,
            docId: recipe.docId,
            waveForm: waveFormData!,
          ))
          .then((value) => navigationService.replaceWithRecipeListPageView(
              isFromProfileView: false));
    } catch (e) {
      showToast(message: 'Something went wrong');
      log(e.toString());
    }
  }

  void saveRecipeToPrivate(
      RecipeModel recipe, List<XFile?> selectedImages) async {
    List<String> imageUrls = await _recipeService.uploadMediaToFirebase(
        selectedImages, recipe.docId!);
    final String chefNote =
        await _recipeService.uploadChefNoteToFirebaseStorage(path!);
    try {
      await _recipeService
          .addRecipeToFirestore(RecipeModel(
            visibility: 'private',
            chefNote: chefNote,
            coverImage: recipe.coverImage + imageUrls,
            createdTime: Timestamp.now(),
            ingredients: recipe.ingredients,
            methods: recipe.methods,
            prepTime: recipe.prepTime,
            servingSize: servings,
            status: 'published',
            title: recipe.title,
            uid: recipe.uid,
            docId: '',
            waveForm: waveFormData!,
          ))
          .then((value) => navigationService.replaceWithRecipeListPageView(
              isFromProfileView: false));
    } catch (e) {
      showToast(message: 'Something went wrong');
      log(e.toString());
    }
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

  void addServes(value) {
    value++;
    rebuildUi();
    notifyListeners();
  }

  void removeServes(value) {
    if (value == 0) {
      value = 0;
      rebuildUi();
    } else {
      value--;
      rebuildUi();
    }

    rebuildUi();
    notifyListeners();
  }

  void startAutoScroll(int length) {
    const duration = Duration(seconds: 3);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (pageController.hasClients) {
        int nextPage = pageController.page!.toInt() + 1;
        if (nextPage >= length) {
          nextPage = 0;
        }
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void updateVideoSource(File value) {
    if (value.isVideo) {
      controller = VideoPlayerController.file(value);
      controller.play();
      notifyListeners();
    } else {}
  }

  void stopAutoScroll() {
    _timer?.cancel();
  }

  void showNextImage(int length) {
    if (pageController.hasClients) {
      int nextPage = (pageController.page!.toInt() + 1) % length;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void showPreviousImage(int length) {
    if (pageController.hasClients) {
      int previousPage = pageController.page!.toInt() - 1;
      if (previousPage < 0) {
        previousPage = length - 1;
      }
      pageController.animateToPage(
        previousPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
