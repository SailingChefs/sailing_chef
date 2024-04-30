import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/extenstions.dart';
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

  Timer? _timer;
  List<double>? waveFormData;
  String? path;

  RecipeViewViewModel({this.waveFormData, this.path});

  void onViewModelReady() async {
    isclicked = false;
    setBusy(true);
    playerController = PlayerController();
    log("WaveForm=> $waveFormData \n Path=> $path");
    await playerController.preparePlayer(
      path: path!,
      volume: 100,
    );
    setBusy(false);
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
        selectedImages, recipe.docId);
    final String chefNote =
        await _recipeService.uploadChefNoteToFirebaseStorage(path!);
    try {
      await _recipeService
          .addRecipeToFirestore(RecipeModel(
            visibility: recipe.visibility,
            chefNote: chefNote,
            coverImage: imageUrls,
            createdTime: Timestamp.now(),
            ingredients: recipe.ingredients,
            methods: recipe.methods,
            prepTime: recipe.prepTime,
            servingSize: recipe.servingSize,
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
