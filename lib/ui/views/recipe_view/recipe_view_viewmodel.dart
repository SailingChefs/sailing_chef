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
  final _navigationService = locator<NavigationService>();
  final _recipeService = locator<RecipeService>();
  String selectedTab = 'Ingredients';
  bool isIngredientsSelected = true;
  bool isMethodsSelected = false;

  // late final PlayerController playerController;
  // final PageController pageController = PageController();

  Timer? _timer;
  List<double>? waveFormData;
  String? path;

  RecipeViewViewModel({this.waveFormData, this.path});

  void onViewModelReady() async {
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
    await playerController.startPlayer(finishMode: FinishMode.loop);
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
    _navigationService.back();
  }

  void saveRecipe(RecipeModel recipe, List<XFile?> selectedImages) async {
    log(recipe.docId.toString());
    List<String> imageUrls =await _recipeService.uploadMediaToFirebase(selectedImages,recipe.docId);

    final String chefNote =
        await _recipeService.uploadChefNoteToFirebaseStorage(path!);


    final check = await _recipeService.addRecipeToFirestore(RecipeModel(
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


      waveForm: waveFormData!,

      docId: recipe.docId,

    ));
    if (check) {
      _navigationService.replaceWithRecipeListPageView(
          isFromProfileView: false);
    } else {
      showToast(message: 'Something went wrong');
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
        previousPage = length - 1; // Loop to last image
      }
      pageController.animateToPage(
        previousPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
