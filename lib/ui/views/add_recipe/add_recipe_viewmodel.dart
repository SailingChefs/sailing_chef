// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddRecipeViewModel extends BaseViewModel {
  final RecipeModel? recipeModel;

  AddRecipeViewModel({this.recipeModel});

  PageController pageController = PageController();
  late final RecorderController recorderController;
  late final PlayerController playerController;
  late VideoPlayerController controller;
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _recipeService = locator<RecipeService>();
  final _userSerice = locator<UserdataServiceService>();
  late Directory directory;
  late String path;
  String selectedValue = 'Public';
  int selectedQuantity = 1;
  List<XFile> selectedImages = [];
  String? prepreationTime;
  List<XFile> thumbnails = [];
  List<String> alreadySelectedImages = [];
  TextEditingController titleController = TextEditingController();
  int count = 0;
  List<String> values = ['Public', 'Private'];
  List<String> quantity = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List<String> timeMethod = ['secs', 'mins', 'hrs'];
  String selectedTimeMethod = 'secs';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Ingredient> ingredientsList = [];
  List<Ingredient> updatedIngredientsList = [];
  TextEditingController servingSize = TextEditingController();
  List<String> methodsList = [];
  List<String> updatedMethodsList = [];
  List<String> tagsList = [];
  TimeOfDay? selectedTime;

  String formattedDuration = '';

  bool isPlaying = false;

  bool isclicked = false;

  List<double>? waveFormData;

  bool get isRecording => recorderController.isRecording;

  bool get shouldShowHint {
    return !hasRecordedAudio && !isRecording;
  }

  bool get isWaveformAndChefNoteEmpty {
    return (waveFormData?.length ?? 0) == 0 &&
        (recipeModel?.chefNote ?? '').isEmpty;
  }

  Future<void> editIngredient(Ingredient ingredient, int listIndex) async {
    final editedIngredient = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.editIngredient,
        data: {'ingredient': ingredient, 'listIndex': listIndex});
  }

  Future<void> editMethod(String method, int listIndex) async {
    final editedMethod = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.cookingInstructions,
        data: {'method': method, 'listIndex': listIndex});
  }

  // {
  //       final method =
  //       await _bottomSheetService.showCustomSheet<dynamic, CookingInstructionsSheetResponse>(
  //     variant: BottomSheetType.cookingInstructions,
  //   );
  //   updatedMethodsList = method?.data.instructionsListResponse.toList() ?? [];
  //   updatedMethodsList.addAll(newMethods);
  //   methodsList = updatedMethodsList;
  //   notifyListeners();

  //   rebuildUi();
  //   notifyListeners();
  // }

  bool hasRecordedAudio = false;

  Future<void> showTagsSheet(context) async {
    final result = await _bottomSheetService.showCustomSheet(
      barrierDismissible: false,
      isScrollControlled: true,
      variant: BottomSheetType.tags,
      data: {'savedTags': tagsList},
    );
    if (result == null) return;
    tagsList = result.data.tags;

    log('tagsList: $tagsList');
    rebuildUi();
    notifyListeners();
  }

  Future<void> showCroppper(File value, context, index) async {
    final fileSizeInBytes = await File(value.path).length();

    final fileSizeInKB = fileSizeInBytes / 1024;

    log(' File size is : $fileSizeInKB KB');
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: value.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '',
          toolbarColor: kcBlackColor,
          toolbarWidgetColor: kcWhiteColor,
          activeControlsWidgetColor: kcPrimaryColor,
          cropFrameColor: kcWhiteColor,
          cropGridColor: kcWhiteColor,
          dimmedLayerColor: kcBlackColor,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        IOSUiSettings(
          title: '',
        ),
      ],
    );
    if (croppedImage != null) {
      // ! we need "a value of File Type" so here we are converting the from CropperdFile to File
      final croppedFile = XFile(
        croppedImage.path,
      );

      selectedImages[index] = croppedFile;

      rebuildUi();
      notifyListeners();
      final fileSizeInBytes = await File(croppedFile.path).length();

      // Convert bytes to kilobytes
      final fileSizeInKB = fileSizeInBytes / 1024;

      // Print the file size in kilobytes
      log('after Cropper File size is : $fileSizeInKB KB');
    } else {
      log('cropped image is null');
    }
    // = CroppedFile(croppedFile!.path) as XFile;
  }

  String? validatePrepTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some time';
    }
    if (value.length > 3) {
      return 'Please enter only 3 or fewer characters';
    }
    return null;
  }

  String? validateTitle(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    return value.length >= 3
        ? null
        : 'Title must be at least 3 characters long';
  }

  Future<void> onViewModelReady() async {
    setBusy(true);
    _initialiseController();
    // recorderController = RecorderController();
    playerController = PlayerController();
    directory = await getApplicationDocumentsDirectory();
    if (recipeModel != null) {
      titleController.text = recipeModel!.title;
      ingredientsList = recipeModel!.ingredients;
      methodsList = recipeModel!.methods;
      if (recipeModel!.coverImage.isNotEmpty) {
        alreadySelectedImages = recipeModel!.coverImage;
      }
      // selectedTime = recipeModel!.prepTime as TimeOfDay?;
      tagsList = recipeModel!.tags!;
      if (recipeModel!.chefNote.isNotEmpty &&
          recipeModel!.waveForm.isNotEmpty) {
        waveFormData = recipeModel!.waveForm;
        // await downloadAudio();
      }

      if (recipeModel!.prepTime.isNotEmpty) {
        prepreationTime = recipeModel!.prepTime;
      }

      selectedQuantity = recipeModel!.servingSize;
      rebuildUi();
      notifyListeners();

      // selectedImages = recipeModel!.coverImage;
    }

    path = '${directory.path}/recording.mpeg4';
    setBusy(false);
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

  double volume = 0;
  bool isMute = false;

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

    await playerController.startPlayer();

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
    notifyListeners();
    rebuildUi();
    log('stop Listening ends $isPlaying');
  }

  void _initialiseController() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4;
  }

  Future<void> addIngredients(List<Ingredient> newIngredients) async {
    final result = await _bottomSheetService
        .showCustomSheet<dynamic, AddIngredientsSheetResponse>(
      variant: BottomSheetType.addIngredients,
    );
    if (result == null) return;
    updatedIngredientsList = result.data.ingredientsList;
    updatedIngredientsList.addAll(newIngredients);
    ingredientsList = updatedIngredientsList;
    notifyListeners();
  }

  Future<void> addMethods(List<String> newMethods) async {
    final method = await _bottomSheetService
        .showCustomSheet<dynamic, CookingInstructionsSheetResponse>(
      variant: BottomSheetType.cookingInstructions,
    );
    updatedMethodsList = method?.data.instructionsListResponse.toList() ?? [];
    updatedMethodsList.addAll(newMethods);
    methodsList = updatedMethodsList;
    notifyListeners();

    rebuildUi();
    notifyListeners();
  }

  Future<void> startRecording() async {
    await recorderController.record(
      path: path,
      androidOutputFormat: AndroidOutputFormat.mpeg4,
    );
    rebuildUi();
  }

  Future<void> stopRecording() async {
    await recorderController.stop();
    log('Path=> $path');
    waveFormData = await playerController.extractWaveformData(path: path);
    hasRecordedAudio = true;
    rebuildUi();

    await playerController.preparePlayer(
      path: path,
      volume: 100,
    );
    playerController.onCurrentDurationChanged.listen((positionData) {
      final position = Duration(milliseconds: positionData);
      updateDuration(position);
    });
    rebuildUi();
  }

  void deleteaddrecipeCurrentRecording() {
    formattedDuration = '0:00';
    hasRecordedAudio = false;
    recorderController.reset();
    playerController.release();
    rebuildUi();
  }

  void deleteCurrentRecording() {
    hasRecordedAudio = false;
    if (recipeModel!.chefNote.isNotEmpty) {
      _recipeService.deleteAudioFromDocument(
          recipeModel!.docId!, recipeModel!.chefNote);
      formattedDuration = '0:00';
      recipeModel!.chefNote = '';
      recipeModel!.waveForm.clear();
      rebuildUi();
    }
    recorderController.reset();
    playerController.release();
    rebuildUi();
  }

  void deleteCurrentImage(index) {
    selectedImages.remove(index);
    thumbnails.remove(index);
    rebuildUi();
  }

  void fireBaseImage(String recipeId, index) {
    alreadySelectedImages.removeAt(index);
    _recipeService.deleteIndexImageFromDocument(
        recipeId, alreadySelectedImages[index]);
    _userSerice.deleteFileFromStorage(alreadySelectedImages[index]);
    notifyListeners();
    rebuildUi();
  }

  Future<void> showCustomTimePickerDialog(BuildContext context) async {
    selectedTime = null;

    final _hourController = TextEditingController(/*text: 0.toString()*/);
    final _minuteController = TextEditingController();

    _hourController.addListener(() {
      if (_hourController.text == '00') {
        _hourController.clear();
      }
    });

    _minuteController.addListener(() {
      if (_minuteController.text == '00') {
        _minuteController.clear();
      }
    });

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Time',
              style: globalTextStyle(color: Colors.black, fontSize: 20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedTransparentTextField(
                controller: _hourController,
                keyboardType: TextInputType.number,
                labelText: 'Hours',
                fillColor: kcsgreycolor.withOpacity(0.1),
                borderColor: kcPrimaryColor,
                textColor: kcBlackColor.withOpacity(0.5),
              ),
              verticalSpaceSmall,
              RoundedTransparentTextField(
                controller: _minuteController,
                keyboardType: TextInputType.number,
                labelText: 'Minutes',
                fillColor: kcsgreycolor.withOpacity(0.1),
                borderColor: kcPrimaryColor,
                textColor: kcBlackColor.withOpacity(0.5),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: kcPrimaryColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Text('Cancel',
                        style:
                            globalTextStyle(color: kcwhitecolor, fontSize: 15)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    rebuildUi();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kcPrimaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Text('Set Time',
                        style:
                            globalTextStyle(color: kcwhitecolor, fontSize: 15)),
                  ),
                  onPressed: () {
                    log(_hourController.text);
                    final hour = _hourController.text.isEmpty
                        ? 0
                        : int.parse(_hourController.text);

                    final minute = _minuteController.text.isEmpty
                        ? 0
                        : int.parse(_minuteController.text);

                    selectedTime = TimeOfDay(hour: hour, minute: minute);
                    Navigator.of(context).pop();
                    rebuildUi();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String formatDuration([TimeOfDay? time]) {
    prepreationTime = '';
    final minutes = selectedTime!.minute;
    final hours = selectedTime!.hour;

    final remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) {
      return '${hours}h'; // If no remaining minutes, only display hours
    } else if (hours == 0) {
      return '$remainingMinutes mins'; // If less than an hour, display only minutes
    }
    return '$hours h $remainingMinutes mins'; // Otherwise, display hours and minutes
  }

  Future<void> pickImages() async {
    final images = await ImagePicker().pickMultipleMedia(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (images.isNotEmpty) {
      log(images.length.toString());
      for (final image in images) {
        if (File(image.path).isImage) {
          thumbnails.add(XFile(image.path));
          log('added image thumbnail');
        } else {
          controller = VideoPlayerController.file(images
              .where((element) => File(element.path).isVideo)
              .first
              .toFile);
          controller.play();
          final thumbnailss = await VideoThumbnail.thumbnailFile(
            video: image.path,
            thumbnailPath: (await getTemporaryDirectory()).path,
            maxHeight: 50,
            quality: 100,
          );
          thumbnails.add(XFile(thumbnailss!));
          log('added video thumbnail');
        }
        selectedImages.add(XFile(image.path));
      }
      log('selected images: ${selectedImages.length} ,${thumbnails.length}');
      notifyListeners();
      rebuildUi();
    }
  }

  void showDraftDialog() {
    if (isPlaying) {
      stopListening();
    }
    if (titleController.text.trim().isEmpty) {
      showToast(message: 'Title cannot be empty');
    } else if (ingredientsList.isEmpty) {
      showToast(message: 'Please add ingredients');
    } else if (methodsList.isEmpty) {
      showToast(message: 'Please add cooking instructions');
    } else if (prepreationTime == null) {
      showToast(message: 'Please add cooking time');
    }
    recipeModel == null
        ? _dialogService
            .showCustomDialog(variant: DialogType.saveDraftAlertbox, data: {
            'model': RecipeModel(
              visibility: 'private',
              chefNote: 'recorderController',
              coverImage: alreadySelectedImages,
              createdTime: Timestamp.now(),
              ingredients: ingredientsList,
              tags: tagsList,
              methods: methodsList,
              prepTime:
                  prepreationTime == '' ? formatDuration() : prepreationTime!,
              servingSize: selectedQuantity,
              status: 'draft',
              title: titleController.text.trim().toLowerCase(),
              uid: firebaseAuth.currentUser!.uid,
              docId: '',
              waveForm: waveFormData == null ? [] : waveFormData!,
            ),
            'images': selectedImages,
            'path': path,
          })
        : _dialogService
            .showCustomDialog(variant: DialogType.saveDraftAlertbox, data: {
            'model': RecipeModel(
              visibility: 'private',
              chefNote: 'recorderController',
              coverImage:
                  alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
              createdTime: Timestamp.now(),
              ingredients: ingredientsList,
              tags: tagsList,
              methods: methodsList,
              prepTime:
                  prepreationTime == '' ? formatDuration() : prepreationTime!,
              servingSize: selectedQuantity,
              status: 'draft',
              title: titleController.text.trim().toLowerCase(),
              uid: firebaseAuth.currentUser!.uid,
              docId: recipeModel!.docId,
              waveForm: waveFormData == null ? [] : waveFormData!,
            ),
            'images': selectedImages,
            'path': path,
          });
  }

  Future<void> callIngredientsBottomSheet() async {
    final result = await _bottomSheetService
        .showCustomSheet<dynamic, AddIngredientsSheetResponse>(
      barrierDismissible: false,
      isScrollControlled: true,
      variant: BottomSheetType.addIngredients,
    );
    if (result == null) return;
    ingredientsList = result.data.ingredientsList;
    rebuildUi();
    notifyListeners();
  }

  void popBack() {
    _navigationService.back();
  }

  Future<void> callCookingInstructionBottomSheet() async {
    final method = await _bottomSheetService
        .showCustomSheet<dynamic, CookingInstructionsSheetResponse>(
      barrierDismissible: false,
      isScrollControlled: true,
      variant: BottomSheetType.cookingInstructions,
    );
    log(method.runtimeType.toString());

    if (method == null) return;
    methodsList = method.data.instructionsListResponse.toList();

    rebuildUi();
    notifyListeners();
  }

  void updateQuantity(int value) {
    selectedQuantity = value;
    notifyListeners();
    rebuildUi();
  }

  void increment() {
    count++;
    notifyListeners();
    rebuildUi();
  }

  void decrement() {
    if (count > 0) {
      count--;
      notifyListeners();
      rebuildUi();
    }
  }

  String mergeStrings(String time, String method) {
    return '$time $method';
  }

  Future<void> previewRecipe() async {
    log(prepreationTime?.toString() ?? 'prepreationTime is null');
    log('to Preview');
    // if (isPlaying) {
    //   // stopListening();
    // }
    if (titleController.text.trim().isNotEmpty &&
        // ignore: unrelated_type_equality_checks

        (prepreationTime != null) &&
        methodsList.isNotEmpty &&
        ingredientsList.isNotEmpty) {
      final hasImage = selectedImages.any((image) => image.isImage);
      final hasAlreadySelectedImages =
          alreadySelectedImages.any((image) => image.isNotEmpty);

      if (!hasImage && !hasAlreadySelectedImages) {
        showToast(message: 'Please add at least one image');
      }
      if (recipeModel != null) {
        final shouldClear = await _navigationService.navigateToRecipeViewView(
          isFromDraft: true,
          recipeModel: RecipeModel(
            visibility: selectedValue,
            chefNote: '',
            coverImage:
                alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
            createdTime: Timestamp.now(),
            ingredients: ingredientsList,
            methods: methodsList,
            tags: tagsList,
            prepTime:
                prepreationTime == '' ? formatDuration() : prepreationTime!,
            servingSize: selectedQuantity,
            status: 'draft',
            title: titleController.text.trim().toLowerCase(),
            uid: firebaseAuth.currentUser!.uid,
            docId: recipeModel!.docId,
            waveForm: waveFormData == null ? [] : waveFormData!,
          ),
          selectedImages: selectedImages,
          path: path,
          waveFormData: waveFormData,
          draftUrls: alreadySelectedImages,
        );
        if (shouldClear == true) {
          log(' Clearing');
          recorderController.dispose();
          playerController.dispose();
          titleController.dispose();
          alreadySelectedImages.clear();
          hasRecordedAudio = false;

          formattedDuration = '';
          selectedImages.clear();
          ingredientsList.clear();
          thumbnails.clear();
          methodsList.clear();
          selectedTimeMethod = '';
          selectedQuantity = 1;
          selectedValue = 'public';
          count = 0;
          waveFormData!.clear();
          prepreationTime = '';
          tagsList.clear();

          rebuildUi();
          titleController = TextEditingController();
          recorderController = RecorderController();
          playerController = PlayerController();
          _initialiseController();

          rebuildUi();
        }
      } else {
        final shouldClear = await _navigationService.navigateToRecipeViewView(
          isFromDraft: false,
          recipeModel: RecipeModel(
            visibility: selectedValue,
            chefNote: '',
            coverImage:
                alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
            createdTime: Timestamp.now(),
            ingredients: ingredientsList,
            methods: methodsList,
            tags: tagsList,
            prepTime:
                prepreationTime == '' ? formatDuration() : prepreationTime!,
            servingSize: int.parse(servingSize.text),
            status: '',
            title: titleController.text.trim().toLowerCase(),
            uid: firebaseAuth.currentUser!.uid,
            docId: '',
            waveForm: waveFormData == null ? [] : waveFormData!,
          ),
          selectedImages: selectedImages,
          path: path,
          waveFormData: waveFormData,
          draftUrls: alreadySelectedImages,
        );
        log('shouldClear $shouldClear');
        if (shouldClear == true) {
          log(' Clearing');
          recorderController.dispose();
          playerController.dispose();
          titleController.dispose();
          alreadySelectedImages.clear();
          hasRecordedAudio = false;

          formattedDuration = '';
          selectedImages.clear();
          ingredientsList.clear();
          thumbnails.clear();
          methodsList.clear();
          selectedTimeMethod = '';
          selectedQuantity = 1;
          selectedValue = 'public';
          count = 0;
          waveFormData!.clear();
          prepreationTime = '';
          tagsList.clear();

          rebuildUi();
          titleController = TextEditingController();
          recorderController = RecorderController();
          playerController = PlayerController();
          _initialiseController();

          rebuildUi();
        }
      }
    } else {
      showToast(message: 'Please fill all fields');
    }
  }

  void deleteMethod(int index) {
    methodsList.removeAt(index);
    rebuildUi();
    notifyListeners();
  }

  void deleteIngredient(int index) {
    ingredientsList.removeAt(index);
    rebuildUi();
  }

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    titleController.dispose();

    selectedImages = [];
    ingredientsList = [];
    methodsList = [];
    selectedTimeMethod = '';
    selectedQuantity = 1;
    selectedValue = 'public';
    count = 1;
    path = '';
    waveFormData = [];
    super.dispose();
  }

  void deleteInstruction(int index) {}

  void updateVideoSource(File value) {
    if (value.isVideo) {
      controller = VideoPlayerController.file(value);
      controller.play();
    } else {}
  }

  late List<String> imageUrls;
}
