// import 'dart:developer';
// import 'dart:io';

// import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sailing_chefs/app/app.bottomsheets.dart';
// import 'package:sailing_chefs/app/app.dialogs.dart';
// import 'package:sailing_chefs/app/extenstions.dart';
// import 'package:sailing_chefs/core/imports/core_imports.dart';
// import 'package:sailing_chefs/core/instances.dart';
// import 'package:sailing_chefs/core/theme/text_styles.dart';
// import 'package:sailing_chefs/model/recipe_model.dart';
// import 'package:sailing_chefs/services/recipe_service.dart';
// import 'package:sailing_chefs/services/userdata_service_service.dart';
// import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';
// import 'package:sailing_chefs/model/ingredients_model.dart';
// import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet.dart';
// import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet.dart';
// import 'package:sailing_chefs/ui/common/show_toast.dart';
// import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:http/http.dart' as http;

// class AddRecipeViewModel extends BaseViewModel {
//   final RecipeModel? recipeModel;
//   AddRecipeViewModel({this.recipeModel});
//   PageController pageController = PageController(viewportFraction: 1.0);
//   late final RecorderController recorderController;
//   late final PlayerController playerController;
//   late VideoPlayerController controller;
//   final _bottomSheetService = locator<BottomSheetService>();
//   final _navigationService = locator<NavigationService>();
//   final _dialogService = locator<DialogService>();
//   final _recipeService = locator<RecipeService>();
//   final _userSerice = locator<UserdataServiceService>();
//   late Directory directory;
//   late String path;
//   String selectedValue = 'Public';
//   TextEditingController servingSize = TextEditingController();
//   List<XFile> selectedImages = [];
//   String? prepreationTime;
//   List<XFile> thumbnails = [];
//   List<String> alreadySelectedImages = [];
//   TextEditingController titleController = TextEditingController();
//   List<String> values = ['Public', 'Private'];

//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   List<Ingredient> ingredientsList = [];
//   List<Ingredient> updatedIngredientsList = [];
//   List<String> methodsList = [];
//   List<String> updatedMethodsList = [];
//   List<String> tagsList = [];
//   TimeOfDay? selectedTime;

//   String formattedDuration = '';

//   bool isPlaying = false;

//   List<double>? waveFormData;

//   bool get isRecording => recorderController.isRecording;

//   bool get shouldShowHint {
//     return !hasRecordedAudio && !isRecording;
//   }

//   bool get isWaveformAndChefNoteEmpty {
//     return (waveFormData?.length ?? 0) == 0 &&
//         (recipeModel?.chefNote ?? '').isEmpty;
//   }

//   bool hasRecordedAudio = false;

//   /// Shows a custom bottom sheet to select tags and updates the `tagsList` with the selected tags.
//   ///
//   /// The function takes a `BuildContext` object as a parameter and returns a `Future<void>`.
//   /// It uses the `_bottomSheetService` to show a custom bottom sheet with the variant `BottomSheetType.tags`.
//   /// If the user selects tags, the `tagsList` is updated with the selected tags.
//   /// After updating the `tagsList`, the UI is rebuilt and the listeners are notified.
//   Future<void> showTagsSheet(BuildContext context) async {
//     final result =
//         await _bottomSheetService.showCustomSheet<dynamic, TagsSheetResponse>(
//       variant: BottomSheetType.tags,
//     );
//     if (result == null) return;
//     tagsList = result.data.tags;
//     log("tagsList: $tagsList");
//     rebuildUi();
//     notifyListeners();
//   }

//   /// Shows an image cropper for the given [value] file.
//   ///
//   /// The [value] parameter is the file to be cropped.
//   /// The [context] parameter is the build context.
//   /// The [index] parameter is the index of the file in the [selectedImages] list.
//   ///
//   /// Returns a [Future] that completes when the cropping is done.
//   Future<void> showCroppper(File value, context, index) async {
//     // Calculate the file size in bytes
//     int fileSizeInBytes = await File(value.path).length();

//     // Convert bytes to kilobytes
//     double fileSizeInKB = fileSizeInBytes / 1024;

//     // Print the file size in kilobytes
//     log(' File size is : $fileSizeInKB KB');

//     // Show the image cropper
//     CroppedFile? croppedImage = await ImageCropper().cropImage(
//       sourcePath: value.path,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9
//       ],
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: '',
//           toolbarColor: kcBlackColor,
//           toolbarWidgetColor: kcWhiteColor,
//           activeControlsWidgetColor: kcPrimaryColor,
//           cropFrameColor: kcWhiteColor,
//           cropGridColor: kcWhiteColor,
//           dimmedLayerColor: kcBlackColor,
//           initAspectRatio: CropAspectRatioPreset.ratio16x9,
//         ),
//         IOSUiSettings(
//           title: '',
//         ),
//       ],
//     );

//     if (croppedImage != null) {
//       // Convert the cropped image to a File type
//       final XFile croppedFile = XFile(
//         croppedImage.path,
//       );

//       // Update the selected image at the given index
//       selectedImages[index] = croppedFile;

//       // Rebuild the UI and notify listeners
//       rebuildUi();
//       notifyListeners();

//       // Calculate the file size in bytes
//       int fileSizeInBytes = await File(croppedFile.path).length();

//       // Convert bytes to kilobytes
//       double fileSizeInKB = fileSizeInBytes / 1024;

//       // Print the file size in kilobytes
//       log('after Cropper File size is : $fileSizeInKB KB');
//     } else {
//       log("cropped image is null");
//     }
//   }

//   String? validatePrepTime(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter some time';
//     }
//     if (value.length > 3) {
//       return 'Please enter only 3 or fewer characters';
//     }
//     return null;
//   }

//   String? validateTitle(String? value) {
//     if (value!.isEmpty) {
//       return 'Please enter your name';
//     }
//     return value.length >= 3
//         ? null
//         : 'Title must be at least 3 characters long';
//   }

//   void onViewModelReady() async {
//     setBusy(true);
//     _initialiseController();
//     // recorderController = RecorderController();
//     playerController = PlayerController();
//     directory = await getApplicationDocumentsDirectory();
//     if (recipeModel != null) {
//       titleController.text = recipeModel!.title;
//       ingredientsList = recipeModel!.ingredients;
//       methodsList = recipeModel!.methods;
//       if (recipeModel!.coverImage.isNotEmpty) {
//         alreadySelectedImages = recipeModel!.coverImage;
//       }
//       // selectedTime = recipeModel!.prepTime as TimeOfDay?;
//       tagsList = recipeModel!.tags!;
//       if (recipeModel!.chefNote.isNotEmpty &&
//           recipeModel!.waveForm.isNotEmpty) {
//         waveFormData = recipeModel!.waveForm;
//         await downloadAudio();
//       }

//       if (recipeModel!.prepTime.isNotEmpty) {
//         prepreationTime = recipeModel!.prepTime;
//       }

//       servingSize.text = recipeModel!.servingSize.toString();

//       // selectedImages = recipeModel!.coverImage;
//     }

//     path = '${directory.path}/recording.mpeg4';
//     setBusy(false);
//   }

//   void onVolumeUpIconPressed() {
//     isMute = !isMute;
//     if (isMute) {
//       volume = 0;
//     } else {
//       volume = 100;
//     }
//     playerController.setVolume(volume);
//     notifyListeners();
//   }

//   double volume = 0;
//   bool isMute = false;
//   Future<void> downloadAudio() async {
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;
//     final response = await http.get(Uri.parse(recipeModel!.chefNote));
//     File audioFile = File("$tempPath/audio.mpeg4");
//     if (response.statusCode == 200) {
//       await audioFile.writeAsBytes(response.bodyBytes);
//       log("Download Complete");
//       playerController.preparePlayer(
//         path: audioFile.path,
//         volume: 100,
//       );
//       log("Player Ready");
//       // Calculate duration here
//       Duration duration = Duration(
//           milliseconds: await playerController.getDuration(DurationType.max));
//       int minutes = duration.inMinutes;
//       int seconds = duration.inSeconds % 60;
//       formattedDuration = "$minutes:${seconds.toString().padLeft(2, '0')}";
//       notifyListeners();
//     }
//   }

//   // Future<void> downloadAudio() async {
//   //   Directory tempDir = await getTemporaryDirectory();
//   //   String tempPath = tempDir.path;
//   //   final response = await http.get(Uri.parse(recipeModel!.chefNote));
//   //   File audioFile = File("$tempPath/audio.mpeg4");
//   //   if (response.statusCode == 200) {
//   //     await audioFile.writeAsBytes(response.bodyBytes);
//   //     log("Download Complete");
//   //      playerController.preparePlayer(
//   //       path: audioFile.path,
//   //       volume: 100,
//   //     );

//   //     log("Player Ready");
//   //   }
//   //   durationCalculate(audioFile);
//   // }

//   void durationStop() {
//     playerController.onCompletion.listen((event) {
//       stopListening();
//     });
//   }

//   void startListening() async {
//     log("start Listening ${isPlaying.toString()}");
//     isPlaying = true;
//     rebuildUi();

//     playerController.onCurrentDurationChanged.listen((positionData) {
//       Duration position = Duration(milliseconds: positionData);
//       updateDuration(position);
//     });

//     await playerController.startPlayer(finishMode: FinishMode.pause);

//     log("start Listening ends ${isPlaying.toString()}");
//     durationStop();
//   }

//   void updateDuration(Duration position) async {
//     if (position > Duration.zero) {
//       formattedDuration =
//           "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}";
//       notifyListeners();
//     }
//   }

//   void stopListening() async {
//     log("stop Listening ${isPlaying.toString()}");
//     await playerController.pausePlayer();
//     isPlaying = false;
//     log(isPlaying.toString());
//     notifyListeners();
//     rebuildUi();
//     log("stop Listening ends ${isPlaying.toString()}");
//   }

//   void _initialiseController() {
//     recorderController = RecorderController()
//       ..androidEncoder = AndroidEncoder.aac
//       ..androidOutputFormat = AndroidOutputFormat.mpeg4
//       ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
//       ..sampleRate = 16000;
//   }

//   void addIngredients(List<Ingredient> newIngredients) async {
//     final result = await _bottomSheetService
//         .showCustomSheet<dynamic, AddIngredientsSheetResponse>(
//       variant: BottomSheetType.addIngredients,
//     );
//     if (result == null) return;
//     updatedIngredientsList = result.data.ingredientsList;
//     updatedIngredientsList.addAll(newIngredients);
//     ingredientsList = updatedIngredientsList;
//     notifyListeners();
//   }

//   void addMethods(List<String> newMethods) async {
//     final method = await _bottomSheetService
//         .showCustomSheet<dynamic, CookingInstructionsSheetResponse>(
//       variant: BottomSheetType.cookingInstructions,
//     );
//     updatedMethodsList = method!.data.instructionsListResponse.toList();
//     updatedMethodsList.addAll(newMethods);
//     methodsList = updatedMethodsList;
//     notifyListeners();

//     rebuildUi();
//     notifyListeners();
//   }

//   void startRecording() async {
//     await recorderController.record(
//       path: path,
//       androidOutputFormat: AndroidOutputFormat.mpeg4,
//     );
//     rebuildUi();
//   }

//   void stopRecording() async {
//     await recorderController.stop();
//     log("Path=> $path");

//     waveFormData = await playerController.extractWaveformData(path: path);
//     hasRecordedAudio = true;
//     rebuildUi();

//     await playerController.preparePlayer(
//       path: path,
//       volume: 100,
//     );
//     playerController.onCurrentDurationChanged.listen((positionData) {
//       Duration position = Duration(milliseconds: positionData);
//       updateDuration(position);
//     });
//     rebuildUi();
//   }

//   void deleteaddrecipeCurrentRecording() {
//     formattedDuration = "0:00";
//     hasRecordedAudio = false;
//     recorderController.reset();
//     playerController.release();
//     rebuildUi();
//   }

//   void deleteCurrentRecording() {
//     hasRecordedAudio = false;
//     if (recipeModel!.chefNote.isNotEmpty) {
//       _recipeService.deleteAudioFromDocument(
//           recipeModel!.docId!, recipeModel!.chefNote);
//       formattedDuration = "0:00";
//       recipeModel!.chefNote = "";
//       recipeModel!.waveForm.clear();
//       rebuildUi();
//     }
//     recorderController.reset();
//     playerController.release();
//     rebuildUi();
//   }

//   void deleteCurrentImage(index) {
//     selectedImages.remove(index);
//     thumbnails.remove(index);
//     rebuildUi();
//   }

//   void fireBaseImage(String recipeId, index) {
//     alreadySelectedImages.removeAt(index);
//     _recipeService.deleteIndexImageFromDocument(
//         recipeId, alreadySelectedImages[index]);
//     _userSerice.deleteFileFromStorage(alreadySelectedImages[index]);
//     notifyListeners();
//     rebuildUi();
//   }

// Future<void> showCustomTimePickerDialog(BuildContext context) async {
//   selectedTime = null;

//   final TextEditingController _hourController = TextEditingController();
//   final TextEditingController _minuteController = TextEditingController();

//   _hourController.addListener(() {
//     if (_hourController.text == '00') {
//       _hourController.clear();
//     }
//   });

//   _minuteController.addListener(() {
//     if (_minuteController.text == '00') {
//       _minuteController.clear();
//     }
//   });

//   await showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Select Time',
//             style: globalTextStyle(color: Colors.black, fontSize: 20)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             RoundedTransparentTextField(
//               controller: _hourController,
//               keyboardType: TextInputType.number,
//               labelText: 'Hours',
//               fillColor: kcSurfaceColor.withOpacity(0.1),
//               borderColor: kcPrimaryColor,
//               textColor: Colors.black,
//             ),
//             verticalSpaceSmall,
//             RoundedTransparentTextField(
//               controller: _minuteController,
//               keyboardType: TextInputType.number,
//               labelText: 'Minutes',
//               fillColor: kcSurfaceColor.withOpacity(0.1),
//               borderColor: kcPrimaryColor,
//               textColor: Colors.black,
//             ),
//           ],
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(
//                 style: TextButton.styleFrom(backgroundColor: kcPrimaryColor),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15.0,
//                   ),
//                   child: Text('Cancel',
//                       style:
//                           globalTextStyle(color: kcWhiteColor, fontSize: 15)),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   rebuildUi();
//                 },
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: kcPrimaryColor,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10.0,
//                   ),
//                   child: Text('Set Time',
//                       style:
//                           globalTextStyle(color: kcWhiteColor, fontSize: 15)),
//                 ),
//                 onPressed: () {
//                   int hour = int.parse(_hourController.text);
//                   int minute = int.parse(_minuteController.text);
//                   selectedTime = TimeOfDay(hour: hour, minute: minute);
//                   Navigator.of(context).pop();
//                   rebuildUi();
//                 },
//               ),
//             ],
//           ),
//         ],
//       );
//     },
//   );
// }

//   String formatDuration([TimeOfDay? time]) {
//     prepreationTime = '';
//     int minutes = selectedTime!.minute;
//     int hours = selectedTime!.hour;

//     int remainingMinutes = minutes % 60;
//     if (remainingMinutes == 0) {
//       return '${hours}h';
//     } else if (hours == 0) {
//       return '$remainingMinutes mins';
//     } else {
//       return '$hours h $remainingMinutes mins';
//     }
//   }

//   void pickImages() async {
//     List<XFile>? images = await ImagePicker().pickMultipleMedia(
//       imageQuality: 100,
//       maxHeight: 1000,
//       maxWidth: 1000,
//     );
//     if (images.isNotEmpty) {
//       log(images.length.toString());
//       for (var image in images) {
//         if (File(image.path).isImage) {
//           thumbnails.add(XFile(image.path));
//           log("added image thumbnail");
//         } else {
//           controller = VideoPlayerController.file(images
//               .where((element) => File(element.path).isVideo)
//               .first
//               .toFile);
//           controller.play();
//           final thumbnailss = await VideoThumbnail.thumbnailFile(
//             video: image.path,
//             thumbnailPath: (await getTemporaryDirectory()).path,
//             imageFormat: ImageFormat.PNG,
//             maxHeight: 50,
//             quality: 100,
//           );
//           thumbnails.add(XFile(thumbnailss!));
//           log("added video thumbnail");
//         }
//         selectedImages.add(XFile(image.path));
//       }
//       log("selected images: ${selectedImages.length} ,${thumbnails.length}");
//       notifyListeners();
//       rebuildUi();
//     }
//   }

//   void showDraftDialog() async {
//     if (isPlaying) {
//       stopListening();
//     }
//     if (titleController.text.trim().isEmpty) {
//       showToast(message: 'Title cannot be empty');
//       return;
//     } else if (ingredientsList.isEmpty) {
//       showToast(message: 'Please add ingredients');
//       return;
//     } else if (methodsList.isEmpty) {
//       showToast(message: 'Please add cooking instructions');
//       return;
//     } else if (prepreationTime == null) {
//       showToast(message: 'Please add cooking time');
//       return;
//     } else if (servingSize.text.isEmpty) {
//       showToast(message: 'Please add Seving Size');
//       return;
//     } else {
//       recipeModel == null
//           ? await _dialogService
//               .showCustomDialog(variant: DialogType.saveDraftAlertbox, data: {
//               'model': RecipeModel(
//                 visibility: 'private',
//                 chefNote: 'recorderController',
//                 coverImage: alreadySelectedImages,
//                 createdTime: Timestamp.now(),
//                 ingredients: ingredientsList,
//                 tags: tagsList,
//                 methods: methodsList,
//                 prepTime:
//                     prepreationTime == '' ? formatDuration() : prepreationTime!,
//                 servingSize: int.parse(servingSize.text),
//                 status: 'draft',
//                 title: titleController.text.trim().toLowerCase(),
//                 uid: firebaseAuth.currentUser!.uid,
//                 docId: '',
//                 waveForm: waveFormData == null ? [] : waveFormData!,
//               ),
//               'images': selectedImages,
//               'path': path,
//             })
//           : await _dialogService
//               .showCustomDialog(variant: DialogType.saveDraftAlertbox, data: {
//               'model': RecipeModel(
//                 visibility: 'private',
//                 chefNote: 'recorderController',
//                 coverImage: alreadySelectedImages.isNotEmpty
//                     ? alreadySelectedImages
//                     : [],
//                 createdTime: Timestamp.now(),
//                 ingredients: ingredientsList,
//                 tags: tagsList,
//                 methods: methodsList,
//                 prepTime:
//                     prepreationTime == '' ? formatDuration() : prepreationTime!,
//                 servingSize: int.parse(servingSize.text),
//                 status: 'draft',
//                 title: titleController.text.trim().toLowerCase(),
//                 uid: firebaseAuth.currentUser!.uid,
//                 docId: recipeModel!.docId,
//                 waveForm: waveFormData == null ? [] : waveFormData!,
//               ),
//               'images': selectedImages,
//               'path': path,
//             });

//       alreadySelectedImages = [];
//       selectedImages = [];
//       ingredientsList = [];
//       methodsList = [];
//       waveFormData = [];
//       path = '';
//       prepreationTime = '';
//       servingSize.clear();
//       formattedDuration = '';
//       titleController.clear();
//       hasRecordedAudio = false;
//       playerController.dispose();
//       tagsList = [];
//       notifyListeners();
//     }
//   }

//   void callIngredientsBottomSheet() async {
//     final result = await _bottomSheetService
//         .showCustomSheet<dynamic, AddIngredientsSheetResponse>(
//       variant: BottomSheetType.addIngredients,
//     );
//     if (result == null) return;
//     ingredientsList = result.data.ingredientsList;
//     rebuildUi();
//     notifyListeners();
//   }

//   void popBack() {
//     _navigationService.back();
//   }

//   void callCookingInstructionBottomSheet() async {
//     final method = await _bottomSheetService
//         .showCustomSheet<dynamic, CookingInstructionsSheetResponse>(
//       variant: BottomSheetType.cookingInstructions,
//     );
//     log(method.runtimeType.toString());

//     if (method == null) return;
//     methodsList = method.data.instructionsListResponse.toList();

//     rebuildUi();
//     notifyListeners();
//   }

//   String mergeStrings(String time, String method) {
//     return '$time $method';
//   }

//   void previewRecipe() async {
//     if (isPlaying) {
//       stopListening();
//     }
//     if (titleController.text.trim().isNotEmpty &&
//         // ignore: unrelated_type_equality_checks

//         (prepreationTime != null) &&
//         hasRecordedAudio &&
//         methodsList.isNotEmpty &&
//         ingredientsList.isNotEmpty) {
//       bool hasImage = selectedImages.any((image) => image.isImage);
//       bool hasAlreadySelectedImages =
//           alreadySelectedImages.any((image) => image.isNotEmpty);

//       if (!hasImage && !hasAlreadySelectedImages) {
//         showToast(message: 'Please add at least one image');
//         return;
//       } else {
//         if (recipeModel != null) {
//           final shouldClear = await _navigationService.navigateToRecipeViewView(
//             isFromDraft: true,
//             recipeModel: RecipeModel(
//               visibility: selectedValue,
//               chefNote: '',
//               coverImage:
//                   alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
//               createdTime: Timestamp.now(),
//               ingredients: ingredientsList,
//               methods: methodsList,
//               tags: tagsList,
//               prepTime:
//                   prepreationTime == '' ? formatDuration() : prepreationTime!,
//               servingSize: int.parse(servingSize.text),
//               status: 'published',
//               title: titleController.text.trim().toLowerCase(),
//               uid: firebaseAuth.currentUser!.uid,
//               docId: recipeModel!.docId,
//               waveForm: waveFormData == null ? [] : waveFormData!,
//             ),
//             selectedImages: selectedImages,
//             path: path,
//             waveFormData: waveFormData,
//             draftUrls: alreadySelectedImages,
//           );
//           if (shouldClear == true) {
//             recorderController.dispose();
//             playerController.dispose();
//             titleController.dispose();
//             alreadySelectedImages.clear();
//             hasRecordedAudio = false;

//             formattedDuration = '';
//             selectedImages.clear();
//             ingredientsList.clear();
//             thumbnails.clear();
//             methodsList.clear();
//             selectedValue = 'public';
//             waveFormData!.clear();
//             prepreationTime = '';
//             tagsList.clear();

//             rebuildUi();
//             titleController = TextEditingController();
//             recorderController = RecorderController();
//             servingSize = TextEditingController();
//             playerController = PlayerController();
//             _initialiseController();

//             rebuildUi();
//           }
//         } else {
//           final shouldClear = await _navigationService.navigateToRecipeViewView(
//             isFromDraft: false,
//             recipeModel: RecipeModel(
//               visibility: selectedValue,
//               chefNote: '',
//               coverImage:
//                   alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
//               createdTime: Timestamp.now(),
//               ingredients: ingredientsList,
//               methods: methodsList,
//               tags: tagsList,
//               prepTime:
//                   prepreationTime == '' ? formatDuration() : prepreationTime!,
//               servingSize:
//                   servingSize.text.isNotEmpty ? int.parse(servingSize.text) : 0,
//               status: '',
//               title: titleController.text.trim().toLowerCase(),
//               uid: firebaseAuth.currentUser!.uid,
//               docId: '',
//               waveForm: waveFormData == null ? [] : waveFormData!,
//             ),
//             selectedImages: selectedImages,
//             path: path,
//             waveFormData: waveFormData,
//             draftUrls: alreadySelectedImages,
//           );

//           if (shouldClear == true) {
//             log(" Clearing");
//             recorderController.dispose();
//             playerController.dispose();
//             titleController.dispose();
//             alreadySelectedImages.clear();
//             hasRecordedAudio = false;

//             formattedDuration = '';
//             selectedImages.clear();
//             ingredientsList.clear();
//             thumbnails.clear();
//             methodsList.clear();
//             selectedValue = 'public';

//             waveFormData!.clear();
//             prepreationTime = '';
//             tagsList.clear();

//             rebuildUi();
//             titleController = TextEditingController();
//             recorderController = RecorderController();
//             servingSize = TextEditingController();
//             playerController = PlayerController();
//             _initialiseController();

//             rebuildUi();
//           }
//         }
//       }
//     } else {
//       showToast(message: 'Please fill all fields');
//     }
//   }

//   void deleteMethod(int index) {
//     methodsList.removeAt(index);
//     rebuildUi();
//     notifyListeners();
//   }

//   void deleteIngredient(int index) {
//     ingredientsList.removeAt(index);
//     rebuildUi();
//   }

//   @override
//   void dispose() {
//     recorderController.dispose();
//     playerController.dispose();
//     titleController.dispose();

//     alreadySelectedImages = [];
//     hasRecordedAudio = false;
//     formattedDuration = '';

//     selectedImages = [];
//     ingredientsList = [];
//     thumbnails = [];
//     methodsList = [];

//     selectedValue = 'public';

//     waveFormData = [];
//     prepreationTime = '';

//     tagsList = [];
//     servingSize.dispose();

//     selectedImages = [];
//     ingredientsList = [];
//     methodsList = [];

//     selectedValue = 'public';

//     path = '';
//     waveFormData = [];
//     super.dispose();
//   }

//   void updateVideoSource(File value) {
//     if (value.isVideo) {
//       controller = VideoPlayerController.file(value);
//       controller.play();
//     } else {}
//   }

//   void back() {
//     _navigationService.back();
//   }
// }

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
import 'package:sailing_chefs/ui/bottom_sheets/tags/tags_sheet.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;

class AddRecipeViewModel extends BaseViewModel {
  final RecipeModel? recipeModel;

  AddRecipeViewModel({this.recipeModel});

  PageController pageController = PageController(viewportFraction: 1.0);
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

  editIngredient(Ingredient ingredient, int listIndex) {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.editIngredient,
        data: {'ingredient': ingredient, 'listIndex': listIndex});
  }

  bool hasRecordedAudio = false;

  Future<void> showTagsSheet(context) async {
    final result =
        await _bottomSheetService.showCustomSheet<dynamic, TagsSheetResponse>(
      barrierDismissible: false,
      isScrollControlled: true,
      variant: BottomSheetType.tags,
    );
    if (result == null) return;
    tagsList = result.data.tags;

    log("tagsList: $tagsList");
    rebuildUi();
    notifyListeners();
  }

  Future<void> showCroppper(File value, context, index) async {
    int fileSizeInBytes = await File(value.path).length();

    double fileSizeInKB = fileSizeInBytes / 1024;

    log(' File size is : $fileSizeInKB KB');
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: value.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
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
        ),
        IOSUiSettings(
          title: '',
        ),
      ],
    );
    if (croppedImage != null) {
      // ! we need "a value of File Type" so here we are converting the from CropperdFile to File
      final XFile croppedFile = XFile(
        croppedImage.path,
      );

      selectedImages[index] = croppedFile;

      rebuildUi();
      notifyListeners();
      int fileSizeInBytes = await File(croppedFile.path).length();

      // Convert bytes to kilobytes
      double fileSizeInKB = fileSizeInBytes / 1024;

      // Print the file size in kilobytes
      log('after Cropper File size is : $fileSizeInKB KB');
    } else {
      log("cropped image is null");
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

  void onViewModelReady() async {
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
      if (recipeModel!.chefNote.isNotEmpty) {
        chefNotesController.text = recipeModel!.chefNote;
      }
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

  // Future<void> downloadAudio() async {
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   final response = await http.get(Uri.parse(recipeModel!.chefNote));
  //   File audioFile = File("$tempPath/audio.mpeg4");
  //   if (response.statusCode == 200) {
  //     await audioFile.writeAsBytes(response.bodyBytes);
  //     log("Download Complete");
  //     playerController.preparePlayer(
  //       path: audioFile.path,
  //       volume: 100,
  //     );
  //     log("Player Ready");
  //     // Calculate duration here
  //     Duration duration = Duration(
  //         milliseconds: await playerController.getDuration(DurationType.max));
  //     int minutes = duration.inMinutes;
  //     int seconds = duration.inSeconds % 60;
  //     formattedDuration = "$minutes:${seconds.toString().padLeft(2, '0')}";
  //     notifyListeners();
  //   }
  // }

  // Future<void> downloadAudio() async {
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   final response = await http.get(Uri.parse(recipeModel!.chefNote));
  //   File audioFile = File("$tempPath/audio.mpeg4");
  //   if (response.statusCode == 200) {
  //     await audioFile.writeAsBytes(response.bodyBytes);
  //     log("Download Complete");
  //      playerController.preparePlayer(
  //       path: audioFile.path,
  //       volume: 100,
  //     );

  //     log("Player Ready");
  //   }
  //   durationCalculate(audioFile);
  // }

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
    notifyListeners();
    rebuildUi();
    log("stop Listening ends ${isPlaying.toString()}");
  }

  void _initialiseController() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4;
  }

  void addIngredients(List<Ingredient> newIngredients) async {
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

  void addMethods(List<String> newMethods) async {
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

  void startRecording() async {
    await recorderController.record(
      path: path,
      androidOutputFormat: AndroidOutputFormat.mpeg4,
    );
    rebuildUi();
  }

  void stopRecording() async {
    await recorderController.stop();
    log("Path=> $path");
    waveFormData = await playerController.extractWaveformData(path: path);
    hasRecordedAudio = true;
    rebuildUi();

    await playerController.preparePlayer(
      path: path,
      volume: 100,
    );
    playerController.onCurrentDurationChanged.listen((positionData) {
      Duration position = Duration(milliseconds: positionData);
      updateDuration(position);
    });
    rebuildUi();
  }

  void deleteaddrecipeCurrentRecording() {
    formattedDuration = "0:00";
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
      formattedDuration = "0:00";
      recipeModel!.chefNote = "";
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

    final TextEditingController _hourController =
        TextEditingController(/*text: 0.toString()*/);
    final TextEditingController _minuteController = TextEditingController();

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
                fillColor: kcSurfaceColor.withOpacity(0.1),
                borderColor: kcPrimaryColor,
                textColor: kcBlackColor.withOpacity(0.5),
              ),
              verticalSpaceSmall,
              RoundedTransparentTextField(
                controller: _minuteController,
                keyboardType: TextInputType.number,
                labelText: 'Minutes',
                fillColor: kcSurfaceColor.withOpacity(0.1),
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
                            globalTextStyle(color: kcWhiteColor, fontSize: 15)),
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
                            globalTextStyle(color: kcWhiteColor, fontSize: 15)),
                  ),
                  onPressed: () {
                    log(_hourController.text.toString());
                    int hour = _hourController.text.isEmpty
                        ? 0
                        : int.parse(_hourController.text);

                    int minute = _minuteController.text.isEmpty
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

  // Future<void> showCustomTimePickerDialog(BuildContext context) async {
  //   // Set the initial time to 00:00 (midnight)
  //   TimeOfDay initialTime = const TimeOfDay(hour: 0, minute: 0);

  //   // Define a custom theme for the time picker dialog
  //   final ThemeData themeData = Theme.of(
  //       context); // Change the text color// Change the color of the dial
  //   // Change the color of the hand // Change the background color

  //   // Show the time picker dialog and wait for user input
  //   selectedTime = await showTimePicker(
  //     context: context,
  //     initialTime: initialTime,
  //     initialEntryMode: TimePickerEntryMode.inputOnly,
  //     builder: (BuildContext context, Widget? child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
  //         child: Theme(
  //           data: ThemeData(
  //             textTheme: themeData.textTheme.copyWith(),
  //             colorScheme: themeData.colorScheme.copyWith(
  //               primary: kcPrimaryColor,
  //               onPrimary: kcWhiteColor,
  //               onBackground: kcPrimaryColor,
  //               // onSurface: kcPrimaryColor,
  //               // surface: kcPrimaryColor,
  //             ),
  //             primaryColor: kcPrimaryColor,
  //             dialogBackgroundColor: kcPrimaryColor,
  //             hoverColor: kcPrimaryColor,
  //             focusColor: kcPrimaryColor,
  //             fontFamily: 'Inter',
  //             dialogTheme: DialogTheme(
  //               backgroundColor: kcWhiteColor,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //             ),
  //           ),
  //           child: child!,
  //         ),
  //       );
  //     },
  //   );

  //   rebuildUi();
  // }

  String formatDuration([TimeOfDay? time]) {
    prepreationTime = '';
    int minutes = selectedTime!.minute;
    int hours = selectedTime!.hour;

    int remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) {
      return '${hours}h'; // If no remaining minutes, only display hours
    } else if (hours == 0) {
      return '$remainingMinutes mins'; // If less than an hour, display only minutes
    } else {
      return '$hours h $remainingMinutes mins'; // Otherwise, display hours and minutes
    }
  }

  void pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultipleMedia(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (images.isNotEmpty) {
      log(images.length.toString());
      for (var image in images) {
        if (File(image.path).isImage) {
          thumbnails.add(XFile(image.path));
          log("added image thumbnail");
        } else {
          controller = VideoPlayerController.file(images
              .where((element) => File(element.path).isVideo)
              .first
              .toFile);
          controller.play();
          final thumbnailss = await VideoThumbnail.thumbnailFile(
            video: image.path,
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            maxHeight: 50,
            quality: 100,
          );
          thumbnails.add(XFile(thumbnailss!));
          log("added video thumbnail");
        }
        selectedImages.add(XFile(image.path));
      }
      log("selected images: ${selectedImages.length} ,${thumbnails.length}");
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
      return;
    } else if (ingredientsList.isEmpty) {
      showToast(message: 'Please add ingredients');
      return;
    } else if (methodsList.isEmpty) {
      showToast(message: 'Please add cooking instructions');
      return;
    } else if (prepreationTime == null) {
      showToast(message: 'Please add cooking time');
      return;
    } else {
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
                coverImage: alreadySelectedImages.isNotEmpty
                    ? alreadySelectedImages
                    : [],
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
  }

  void callIngredientsBottomSheet() async {
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

  void callCookingInstructionBottomSheet() async {
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

  void previewRecipe() async {
    log(prepreationTime.toString());
    log('to Preview');
    // if (isPlaying) {
    //   // stopListening();
    // }
    if (titleController.text.trim().isNotEmpty &&
        // ignore: unrelated_type_equality_checks

        (prepreationTime != null) &&
        methodsList.isNotEmpty &&
        ingredientsList.isNotEmpty) {
      bool hasImage = selectedImages.any((image) => image.isImage);
      bool hasAlreadySelectedImages =
          alreadySelectedImages.any((image) => image.isNotEmpty);

      if (!hasImage && !hasAlreadySelectedImages) {
        showToast(message: 'Please add at least one image');
        return;
      } else {
        if (recipeModel != null) {
          final shouldClear = await _navigationService.navigateToRecipeViewView(
            isFromDraft: true,
            recipeModel: RecipeModel(
              visibility: selectedValue,
              chefNote: chefNotesController.text,
              coverImage:
                  alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
              createdTime: Timestamp.now(),
              ingredients: ingredientsList,
              methods: methodsList,
              tags: [
                ...tagsList,
                if (selectedDifficulty.isNotEmpty &&
                    !tagsList.contains(selectedDifficulty))
                  selectedDifficulty,
              ],
              prepTime: _computePrepTime(),
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
            log(" Clearing");
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
            wizardStep = 0;
            _wizardDraftDocId = null;
            chefNotesController.clear();
            wizardStep = 0;
            _wizardDraftDocId = null;
            chefNotesController.clear();

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
              chefNote: chefNotesController.text,
              coverImage:
                  alreadySelectedImages.isNotEmpty ? alreadySelectedImages : [],
              createdTime: Timestamp.now(),
              ingredients: ingredientsList,
              methods: methodsList,
              tags: [
                ...tagsList,
                if (selectedDifficulty.isNotEmpty &&
                    !tagsList.contains(selectedDifficulty))
                  selectedDifficulty,
              ],
              prepTime: _computePrepTime(),
              servingSize: selectedQuantity,
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
          log("shouldClear $shouldClear");
          if (shouldClear == true) {
            log(" Clearing");
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
            wizardStep = 0;
            _wizardDraftDocId = null;
            chefNotesController.clear();

            rebuildUi();
            titleController = TextEditingController();
            recorderController = RecorderController();
            playerController = PlayerController();
            _initialiseController();

            rebuildUi();
          }
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
    chefNotesController.dispose();

    selectedImages = [];
    ingredientsList = [];
    methodsList = [];
    selectedTimeMethod = '';
    selectedQuantity = 1;
    selectedValue = 'public';
    count = 1;
    path = '';
    waveFormData = [];
    wizardStep = 0;
    _wizardDraftDocId = null;
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

  // ── Wizard state ──────────────────────────────────────────────────────────
  int wizardStep = 0;
  String selectedDifficulty = 'Easy';
  TextEditingController chefNotesController = TextEditingController();
  String? _wizardDraftDocId;

  static const List<String> difficultyOptions = [
    'Easy',
    'Medium',
    'Hard',
    'Expert',
  ];

  void selectDifficulty(String difficulty) {
    selectedDifficulty = difficulty;
    notifyListeners();
  }

  bool _validateStep1() {
    if (titleController.text.trim().isEmpty) {
      showToast(message: 'Please enter a recipe title');
      return false;
    }
    if (selectedImages.isEmpty && alreadySelectedImages.isEmpty) {
      showToast(message: 'Please add at least one cover photo');
      return false;
    }
    return true;
  }

  bool _validateStep2() {
    if (ingredientsList.isEmpty) {
      showToast(message: 'Please add at least one ingredient');
      return false;
    }
    return true;
  }

  void goToNextStep() {
    if (wizardStep == 0 && !_validateStep1()) return;
    if (wizardStep == 1 && !_validateStep2()) return;
    if (wizardStep < 2) {
      wizardStep++;
      notifyListeners();
      autoSaveDraft();
    }
  }

  void goToPreviousStep() {
    if (wizardStep > 0) {
      wizardStep--;
      notifyListeners();
    }
  }

  void autoSaveDraft() {
    if (titleController.text.trim().isEmpty) return;
    final effectiveDocId = recipeModel?.docId ?? _wizardDraftDocId ?? '';
    if (effectiveDocId.isNotEmpty) {
      _recipeService.addOrUpdateDraft(_buildDraftModel(effectiveDocId));
    } else {
      _createNewDraft();
    }
  }

  Future<void> _createNewDraft() async {
    try {
      final model = _buildDraftModel('');
      final docRef =
          await firebasestore.collection('recipes').add(model.toMap());
      _wizardDraftDocId = docRef.id;
      await docRef.update({'doc_id': _wizardDraftDocId});
    } catch (e) {
      log('Auto-save failed: $e');
    }
  }

  RecipeModel _buildDraftModel(String docId) {
    final allTags = [
      ...tagsList,
      if (selectedDifficulty.isNotEmpty &&
          !tagsList.contains(selectedDifficulty))
        selectedDifficulty,
    ];
    return RecipeModel(
      visibility: 'private',
      chefNote: chefNotesController.text,
      coverImage: alreadySelectedImages,
      createdTime: Timestamp.now(),
      ingredients: ingredientsList,
      tags: allTags,
      methods: methodsList,
      prepTime: _computePrepTime(),
      servingSize: selectedQuantity,
      status: 'draft',
      title: titleController.text.trim().toLowerCase(),
      uid: firebaseAuth.currentUser!.uid,
      docId: docId,
      waveForm: waveFormData ?? [],
    );
  }

  String _computePrepTime() {
    if (prepreationTime != null && prepreationTime!.isNotEmpty) {
      return prepreationTime!;
    }
    if (selectedTime == null) return '';
    final h = selectedTime!.hour;
    final m = selectedTime!.minute % 60;
    if (m == 0) return '${h}h';
    if (h == 0) return '$m mins';
    return '$h h $m mins';
  }
}
