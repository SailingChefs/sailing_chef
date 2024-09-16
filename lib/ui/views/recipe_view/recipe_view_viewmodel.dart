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
  final bool isFromDraft;

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
  double volume = 0;
  bool isMute = false;
  List<dynamic> get selectedImages => [...prevImageUrls, ...newImageUrls];

  Timer? _timer;
  List<double>? waveFormData;
  String? path;
  int? duration;
  RecipeViewViewModel(
    this.prevImageUrls,
    this.newImageUrls,
    this.recipe, {
    this.waveFormData,
    this.path,
    required this.isFromDraft,
  });

  String formattedDuration = '';
  void onViewModelReady() async {
    isclicked = false;
    servings = recipe!.servingSize;
    setBusy(true);
    playerController = PlayerController();

    await playerController.preparePlayer(
      path: path!,
      volume: 100,
    );

    await durationCalculate(File(path!));

    setBusy(false);
  }

  int servings = 0;
  int updatedQuantity = 0;

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

  @override
  void dispose() {
    playerController.dispose();
    stopListening();
    _timer?.cancel();
    pageController.dispose();
    formattedDuration = '';
    super.dispose();
  }

  Future<void> durationCalculate(File path) async {
    if (path.path.isNotEmpty && waveFormData != null) {
      waveFormData =
          await playerController.extractWaveformData(path: path.path);
      if (waveFormData!.isNotEmpty) {
        Duration duration = Duration(
            milliseconds: await playerController.getDuration(DurationType.max));
        int minutes = duration.inMinutes;
        int seconds = duration.inSeconds % 60;
        formattedDuration = "$minutes:${seconds.toString().padLeft(2, '0')}";
      }
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
    log("to Recipe List");
    List<String> imageUrls = await _recipeService.uploadMediaToFirebase(
        selectedImages, recipe.docId!);
    // String chefNote = '';
    // if (path!.isNotEmpty) {
    //   chefNote = await _recipeService.uploadChefNoteToFirebaseStorage(path!);
    // }

    try {
      log("serving size ${recipe.servingSize.toString()}");
      await _recipeService
          .addRecipeToFirestore(
        RecipeModel(
          visibility: recipe.visibility,
          chefNote: '',
          coverImage: recipe.coverImage + imageUrls,
          createdTime: Timestamp.now(),
          ingredients: recipe.ingredients,
          methods: recipe.methods,
          prepTime: recipe.prepTime,
          servingSize: recipe.servingSize,
          status: 'published',
          title: recipe.title,
          tags: recipe.tags,
          uid: recipe.uid,
          docId: recipe.docId,
          waveForm: waveFormData == null ? [] : waveFormData!,
        ),
      )
          .then((value) async {
        final result =
            await navigationService.replaceWithBottomNavBarView(index: 4
                // isFromDraft: isFromDraft,
                );
        log("result: $result");
      });
    } catch (e) {
      showToast(message: 'Something went wrong');
      log(
        e.toString(),
      );
    }
  }

  void saveRecipeToPrivate(
      RecipeModel recipe, List<XFile?> selectedImages) async {
    List<String> imageUrls = await _recipeService.uploadMediaToFirebase(
        selectedImages, recipe.docId!);
    String chefNote = '';
    if (path!.isNotEmpty) {
      chefNote = await _recipeService.uploadChefNoteToFirebaseStorage(path!);
    }
    try {
      log(recipe.ingredients.length.toString());
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
            tags: recipe.tags,
            uid: recipe.uid,
            docId: recipe.docId,
            waveForm: waveFormData == null ? [] : waveFormData!,
          ))
          .then((value) => navigationService.navigateToPrivateRecipesView());
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
}
