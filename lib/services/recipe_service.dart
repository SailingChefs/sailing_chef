import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class RecipeService with ListenableServiceMixin {
  static List<RecipeModel> recipes = [];
  final _userService = locator<UserServices>();
  final List<XFile?> media = List.empty();
  bool isInitialized = false;
  Map<String, UserModel> userCache = {};
  Future<void> initialized() async {
    recipes = await fetchAllPublicRecipes();

    notifyListeners();
  }

  Future<void> initializeddraft() async {
    drafts.clear();
    drafts = await fetchDraftRecipes(userDetails!.uid!);
    notifyListeners();
  }

  Future<bool> doesDraftExist(String uid) async {
    log(uid);
    try {
      final DocumentSnapshot snapshot = await firebasestore.collection('recipes').doc(uid).get();
      if (snapshot.exists) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<RecipeModel?> fetchRecipeById(String docId) async {
    try {
      final DocumentSnapshot docSnapshot =
          await firebasestore.collection('recipes').doc(docId).get();

      if (docSnapshot.exists) {
        final recipe = RecipeModel.fromSnapshot(docSnapshot);

        final QuerySnapshot commentsSnapshot =
            await docSnapshot.reference.collection('comments').get();
        final comments = commentsSnapshot.docs.map(CommentModel.fromSnapshot).toList();
        recipe.comment = comments;

        final user = await _userService.fetchUserByUID(recipe.uid);
        recipe.user = user;

        return recipe;
      }
      log('Recipe with docId $docId does not exist.');
      return null;
    } catch (e) {
      log('Error fetching recipe by ID: $e');
      return null;
    }
  }

  Stream<List<RecipeModel>> fetchPublishedRecipesAsStream() {
    return firebasestore
        .collection('recipes')
        .where('visibility', isEqualTo: 'Public')
        .where('status', isEqualTo: 'published')
        .snapshots()
        .asyncMap((snapshot) async {
      final recipes = <RecipeModel>[];
      for (final doc in snapshot.docs) {
        final recipe = RecipeModel.fromSnapshot(doc);

        if (userCache.containsKey(recipe.uid)) {
          recipe.user = userCache[recipe.uid];
        } else {
          final user = await _userService.fetchUserByUID(recipe.uid);
          recipe.user = user;
          userCache[recipe.uid] = user;
        }

        final QuerySnapshot commentsSnapshot = await doc.reference.collection('comments').get();
        final comments = commentsSnapshot.docs.map(CommentModel.fromSnapshot).toList();
        recipe.comment = comments;

        recipes.add(recipe);
      }
      return recipes;
    });
  }

  Stream<List<RecipeModel>> fetchPublicRecipesAsStream() {
    return firebasestore
        .collection('recipes')
        .where('visibility', isEqualTo: 'Public')
        .snapshots()
        .asyncMap((snapshot) async {
      final recipes = <RecipeModel>[];
      for (final doc in snapshot.docs) {
        final recipe = RecipeModel.fromSnapshot(doc);

        if (userCache.containsKey(recipe.uid)) {
          recipe.user = userCache[recipe.uid];
        } else {
          final user = await _userService.fetchUserByUID(recipe.uid);
          recipe.user = user;
          userCache[recipe.uid] = user;
        }

        // final QuerySnapshot commentsSnapshot = await doc.reference.collection('comments').get();
        // final comments = commentsSnapshot.docs.map(CommentModel.fromSnapshot).toList();
        // recipe.comment = comments;

        recipes.add(recipe);
      }
      return recipes;
    });
  }

  Future<void> deleteIndexImageFromDocument(String id, String link) async {
    try {
      final CollectionReference collection = firebasestore.collection('recipes');
      final documentReference = collection.doc(id);

      await documentReference.update({
        'cover_image': FieldValue.arrayRemove([link]),
      });
    } catch (e) {
      log(e.toString());
      showToast(message: 'Error deleting image from document: $e');
    }
  }

  Future<bool> addOrUpdateDraft(RecipeModel recipe) async {
    log('addOrUpdateDraft ${recipe.docId}');
    try {
      final draftExists = await doesDraftExist(recipe.docId!);

      log(draftExists.toString());
      if (draftExists) {
        final DocumentReference docRef = firebasestore.collection('recipes').doc(recipe.docId);

        await docRef.update(recipe.toMap());

        showToast(message: 'Draft updated successfully');
      } else {
        final DocumentReference docRef =
            await firebasestore.collection('recipes').add(recipe.toMap());

        final docId = docRef.id;

        await docRef.update({'doc_id': docId});

        showToast(message: 'Draft saved successfully');
      }

      return true;
    } catch (error) {
      // Handle error
      showToast(message: 'Error saving or updating draft: $error');
      return false;
    }
  }

  Future<bool> addRecipeToFirestore(RecipeModel recipe) async {
    log('addRecipeToFirestore ${recipe.docId}');
    EasyLoading.show();
    try {
      final QuerySnapshot snapshot =
          await firebasestore.collection('recipes').where('doc_id', isEqualTo: recipe.docId).get();

      if (snapshot.docs.isNotEmpty && recipe.docId != null) {
        final DocumentReference docRef =
            FirebaseFirestore.instance.collection('recipes').doc(recipe.docId);

        await docRef.update(recipe.toMap());
        final docId = docRef.id;

        await docRef.update({
          'doc_id': docId,
        });
        await firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
          'recipes': FieldValue.arrayUnion([docId])
        });
        userDetails!.recipes!.add(recipe.docId!);
        recipe.user = userDetails;
        if (recipe.visibility != 'private') {
          recipes.add(recipe);
        }
        showToast(message: 'Recipe updated successfully');
      } else {
        final DocumentReference docRef =
            await firebasestore.collection('recipes').add(recipe.toMap());

        final docId = docRef.id;

        await docRef.update({'doc_id': docId});
        await firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
          'recipes': FieldValue.arrayUnion([docId])
        });
        userDetails!.recipes!.add(docId);
        recipe.user = userDetails;
        if (recipe.visibility != 'private') {
          recipes.add(recipe);
        }
        showToast(message: 'Recipe added successfully');
      }

      return true;
    } catch (error) {
      EasyLoading.dismiss();
      log(error.toString());
      return false;
    }
  }

  Future<String> uploadChefNoteToFirebaseStorage(String filePath) async {
    try {
      final file = File(filePath);
      if (!file.existsSync() || file.lengthSync() == 0) {
        return '';
      }
      EasyLoading.show();
      final storageReference = firebaseStorage.ref().child('audio/${DateTime.now()}.mpeg4');
      final uploadTask = storageReference.putFile(file);
      // ignore: avoid_print
      await uploadTask.whenComplete(() => print('File Uploaded'));
      EasyLoading.dismiss();
      return await storageReference.getDownloadURL();
    } catch (e) {
      EasyLoading.dismiss();
      // showToast(message: 'Error uploading audio files to Firebase Storage: $e');
      log('Error uploading audio to Firebase Storage: $e');
      return '';
    }
  }

  Future<List<String>> uploadMediaToFirebase(
    List<XFile?> mediaFiles,
    String id,
  ) async {
    // Returns list of download URLs for successfully uploaded media files (images/videos).
    // Null entries in mediaFiles are skipped. Errors on individual files are logged but don't fail the entire batch.
    if (mediaFiles.isEmpty) return [];

    final uploadedUrls = <String>[];
    EasyLoading.show(status: 'Uploading media...');
    try {
      for (final media in mediaFiles) {
        if (media == null) continue; // Skip null safely
        final url = await _uploadSingleMedia(media, id);
        if (url != null) {
          uploadedUrls.add(url);
        }
      }
      return uploadedUrls;
    } catch (e, st) {
      log('Batch media upload failed: $e\n$st');
      showToast(message: 'Media upload failed: $e');
      return uploadedUrls; // Return any partial successes
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Upload a single media file (image or video) with proper extension & metadata.
  Future<String?> _uploadSingleMedia(XFile media, String recipeId) async {
    try {
      final file = File(media.path);
      if (!await file.exists()) {
        log('File does not exist: ${media.path}');
        return null;
      }

      final originalExt = _extractFileExtension(media.path); // e.g. jpg / mp4
      final isVideo = media.isVideo;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      // Namespace by recipe id to avoid collisions & allow easier cleanup.
      final folder = isVideo ? 'videos' : 'images';
      final fileName = '${recipeId}_$timestamp.$originalExt';
      final storagePath = 'recipes/$recipeId/$folder/$fileName';

      final metadata = SettableMetadata(
        contentType: _guessContentType(originalExt, isVideo),
        customMetadata: {
          'recipe_id': recipeId,
          'original_name': media.name,
          'uploaded_at': DateTime.now().toIso8601String(),
          'type': isVideo ? 'video' : 'image',
        },
      );

      final ref = firebaseStorage.ref().child(storagePath);
      final uploadTask = ref.putFile(file, metadata);
      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      log('Uploaded $storagePath => $url');
      return url;
    } catch (e, st) {
      log('Error uploading single media ${media.path}: $e\n$st');
      return null;
    }
  }

  String _extractFileExtension(String path) {
    final parts = path.split('.');
    if (parts.length < 2) return 'jpg'; // default fallback
    return parts.last.toLowerCase();
  }

  String _guessContentType(String ext, bool isVideo) {
    final lower = ext.toLowerCase();
    if (isVideo) {
      const mp4Group = {'mp4', 'm4v', '3gp', '3g2', 'mpg', 'mpeg', 'ts', 'mts', 'm2ts'};
      if (mp4Group.contains(lower)) return 'video/mp4';
      if (lower == 'mov') return 'video/quicktime';
      if (lower == 'webm') return 'video/webm';
      if (lower == 'mkv') return 'video/x-matroska';
      if (lower == 'avi') return 'video/x-msvideo';
      if (lower == 'wmv') return 'video/x-ms-wmv';
      return 'video/mp4'; // fallback
    }
    const jpegGroup = {'jpg', 'jpeg'};
    if (jpegGroup.contains(lower)) return 'image/jpeg';
    if (lower == 'png') return 'image/png';
    if (lower == 'gif') return 'image/gif';
    if (lower == 'webp') return 'image/webp';
    if (lower == 'heic' || lower == 'heif') return 'image/heic';
    if (lower == 'svg') return 'image/svg+xml';
    if (lower == 'bmp') return 'image/bmp';
    return 'image/jpeg'; // fallback
  }

  Future<void> deleteAudioFromDocument(String id, String url) async {
    try {
      final CollectionReference collection = firebasestore.collection('recipes');
      final documentReference = collection.doc(id);
      EasyLoading.show();
      var filePath = Uri.decodeFull(Uri.parse(url).path);

      filePath = filePath.substring(38);
      log(filePath);

      final storageRef = firebaseStorage.ref().child(filePath);

      await storageRef.delete();

      await documentReference.update({
        'chef_note': FieldValue.delete(),
        'waveForm': FieldValue.delete(),
      });
      EasyLoading.dismiss();
      showToast(message: 'Audio file deleted successfully');
    } catch (error) {
      showToast(message: 'Error deleting audio file from document: $error');
      log('Error deleting audio file from document: $error');
    }
  }

  Future<List<String>> uploadImagesToFirebase(List<XFile?> images) async {
    final imageUrls = <String>[];

    try {
      for (final image in images) {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final ref = firebaseStorage.ref().child('images/$fileName');
        final uploadTask = ref.putFile(File(image!.path));
        final taskSnapshot = await uploadTask;
        final imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      showToast(message: 'Images uploaded successfully');

      return imageUrls;
    } catch (error) {
      showToast(message: 'Error uploading images to Firebase Storage: $error');
      return [];
    }
  }

  Future<List<RecipeModel>> fetchRecipesByUID(String uid) async {
    try {
      // DocumentSnapshot document = await firebasestore.collection('recipes').doc('v46B0TZgmcqSragcJRMK').get();
      final QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('status', isNotEqualTo: 'draft')
          .where('visibility', isNotEqualTo: 'private')
          // .where('visibility', isEqualTo: 'public')
          .where('uid', isEqualTo: uid)
          .get();

      final recipes = <RecipeModel>[];
      for (final doc in snapshot.docs) {
        final recipe = RecipeModel.fromSnapshot(doc);

        // Fetch comments for the current recipe
        final QuerySnapshot commentsSnapshot = await doc.reference.collection('comments').get();
        final comments = commentsSnapshot.docs.map(CommentModel.fromSnapshot).toList();
        recipe.comment = comments;

        // Fetch user details by UID and assign it to the recipe
        final user = await _userService.fetchUserByUID(recipe.uid);
        recipe.user = user;

        recipes.add(recipe);
      }
      return recipes;
    } catch (e) {
      log('Error fetching recipes: $e');
      return [];
    }
  }

  Future<List<RecipeModel>> fetchFollowingRecipesByUID() async {
    try {
      final allRecipes = <RecipeModel>[];

      for (final uId in userDetails!.following!) {
        final QuerySnapshot snapshot = await firebasestore
            .collection('recipes')
            .where('uid', isEqualTo: uId)
            .where('status', isEqualTo: 'published')
            .where('visibility', isEqualTo: 'Public')
            .get();

        final recipes = <RecipeModel>[];
        for (final doc in snapshot.docs) {
          final recipe = RecipeModel.fromSnapshot(doc);

          // Fetch comments for the current recipe
          final QuerySnapshot commentsSnapshot = await doc.reference.collection('comments').get();
          final comments = commentsSnapshot.docs.map(CommentModel.fromSnapshot).toList();
          recipe.comment = comments;

          // Fetch user details by UID and assign it to the recipe
          final user = await _userService.fetchUserByUID(recipe.uid);
          recipe.user = user;

          recipes.add(recipe);
        }

        allRecipes.addAll(recipes);
      }

      return allRecipes;
    } catch (e) {
      log('Error fetching recipes: $e');
      return [];
    }
  }

  Future<List<RecipeModel>> fetchAllPublicRecipes() async {
    try {
      // Fetches all documents from the 'recipes' collection
      final QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('visibility', isEqualTo: 'Public')
          .where('status', isEqualTo: 'published')
          .get();

      // Maps each DocumentSnapshot to a RecipeModel
      final recipes = <RecipeModel>[];
      for (final doc in snapshot.docs) {
        final recipe = RecipeModel.fromSnapshot(doc);

        if (!userDetails!.blockedAccounts!.contains(recipe.uid)) {
          // UserModel? user = await _userService.fetchUserByUID(recipe.uid);
          // recipe.user = user;

          // recipes.add(recipe);
          recipes.add(recipe);
          // break;
        }
      }

      return recipes;
    } catch (e) {
      log('Error fetching recipes: $e');
      return []; // Return an empty list on error
    }
  }

  Future<List<RecipeModel>> fetchAllMyRecipes() async {
    try {
      // Fetches all documents from the 'recipes' collection
      final QuerySnapshot snapshot =
          await firebasestore.collection('recipes').where('uid', isEqualTo: userDetails!.uid).get();

      // Maps each DocumentSnapshot to a RecipeModel
      return snapshot.docs.map(RecipeModel.fromSnapshot).toList();
    } catch (e) {
      log('Error fetching recipes: $e');
      return []; // Return an empty list on error
    }
  }

  List<RecipeModel> drafts = [];
  Future<List<RecipeModel>> fetchDraftRecipes(String uid) async {
    try {
      final QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('uid', isEqualTo: uid)
          .where('visibility', isEqualTo: 'private')
          .where('status', isEqualTo: 'draft')
          .get();

      final draftRecipes = <RecipeModel>[];
      for (final doc in snapshot.docs) {
        final draftRecipe = RecipeModel.fromSnapshot(doc);

        final QuerySnapshot commentsSnapshot = await doc.reference.collection('comments').get();
        final comments = commentsSnapshot.docs.map(CommentModel.fromSnapshot).toList();
        draftRecipe.comment = comments;

        final user = await _userService.fetchUserByUID(draftRecipe.uid);
        draftRecipe.user = user;

        if (drafts.any((element) => element.docId == doc.id)) {
          await firebasestore.collection('recipes').doc(doc.id).update(draftRecipe.toMap());
        } else {
          draftRecipe.docId = doc.id;
          draftRecipes.add(draftRecipe);
        }
      }

      drafts = draftRecipes;

      return draftRecipes;
    } catch (e) {
      log('Error fetching draft recipes: $e');
      return [];
    }
  }

  Future<bool> updatePrivateRecipe(RecipeModel recipe) async {
    try {
      final draftExists = await doesDraftExist(recipe.docId!);
      log('draft exits $draftExists');
      EasyLoading.show();
      if (draftExists) {
        final DocumentReference docRef = firebasestore.collection('recipes').doc(recipe.docId);

        await docRef.update({'visibility': 'Public', 'status': 'pending'});

        showToast(message: 'Saved Recipe Publicly');
      }
      EasyLoading.dismiss();
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error saving recipe publicly: $error');
      return false;
    }
  }

  Future<List<RecipeModel>> fetchPrivateRecipes(String uid) async {
    try {
      final QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('uid', isEqualTo: uid)
          .where('visibility', isEqualTo: 'private')
          .where('status', isEqualTo: 'published')
          .get();

      final privateRecipes = <RecipeModel>[];
      for (final doc in snapshot.docs) {
        final privatetRecipe = RecipeModel.fromSnapshot(doc);

        privatetRecipe.user = userDetails;

        privateRecipes.add(privatetRecipe);
      }

      return privateRecipes;
    } catch (e) {
      log('Error fetching private recipes: $e');
      return [];
    }
  }

  Future<void> updateRecipeStatus(String recipeId, Map<String, String> value) async {
    try {
      EasyLoading.show();
      await firebasestore.collection('recipes').doc(recipeId).update(value);
      EasyLoading.dismiss();
      showToast(message: 'Recipe set to review successfully');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error setting recipe as review: $e');
      showToast(message: 'Error setting recipe as review: $e');
    }
  }
}
