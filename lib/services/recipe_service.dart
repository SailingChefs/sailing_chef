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
    if (isInitialized) return;
    recipes = await fetchAllRecipes();

    isInitialized = true;

    notifyListeners();
  }

  Future<void> initializeddraft() async {
    drafts.clear();
    drafts = await fetchDraftRecipes(userDetails!.uid!);
    notifyListeners();
  }

  Future<bool> doesDraftExist(String uid) async {
    log(uid.toString());
    try {
      DocumentSnapshot snapshot =
          await firebasestore.collection('recipes').doc(uid).get();
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
      DocumentSnapshot docSnapshot =
          await firebasestore.collection('recipes').doc(docId).get();

      if (docSnapshot.exists) {
        RecipeModel recipe = RecipeModel.fromSnapshot(docSnapshot);

        QuerySnapshot commentsSnapshot =
            await docSnapshot.reference.collection('comments').get();
        List<CommentModel> comments = commentsSnapshot.docs
            .map((commentDoc) => CommentModel.fromSnapshot(commentDoc))
            .toList();
        recipe.comment = comments;

        UserModel? user = await _userService.fetchUserByUID(recipe.uid);
        recipe.user = user;

        return recipe;
      } else {
        log('Recipe with docId $docId does not exist.');
        return null;
      }
    } catch (e) {
      log('Error fetching recipe by ID: $e');
      return null;
    }
  }

  Stream<List<RecipeModel>> fetchRecipesAsStream() {
    return firebasestore
        .collection('recipes')
        .where('visibility', isEqualTo: 'Public')
        .where('status', isEqualTo: 'published')
        .snapshots()
        .asyncMap((snapshot) async {
      List<RecipeModel> recipes = [];
      for (var doc in snapshot.docs) {
        RecipeModel recipe = RecipeModel.fromSnapshot(doc);

        if (userCache.containsKey(recipe.uid)) {
          recipe.user = userCache[recipe.uid];
        } else {
          UserModel? user = await _userService.fetchUserByUID(recipe.uid);
          recipe.user = user;
          userCache[recipe.uid] = user;
        }

        QuerySnapshot commentsSnapshot =
            await doc.reference.collection('comments').get();
        List<CommentModel> comments = commentsSnapshot.docs
            .map((commentDoc) => CommentModel.fromSnapshot(commentDoc))
            .toList();
        recipe.comment = comments;

        recipes.add(recipe);
      }
      return recipes;
    });
  }

  Future<void> deleteIndexImageFromDocument(String id, String link) async {
    try {
      CollectionReference collection = firebasestore.collection('recipes');
      DocumentReference documentReference = collection.doc(id);

      await documentReference.update({
        'cover_image': FieldValue.arrayRemove([link]),
      });
    } catch (e) {
      log(e.toString());
      showToast(message: 'Error deleting image from document: $e');
    }
  }

  Future<bool> addOrUpdateDraft(RecipeModel recipe) async {
    log("addOrUpdateDraft ${recipe.docId.toString()}");
    try {
      bool draftExists = await doesDraftExist(recipe.docId!);

      log(draftExists.toString());
      if (draftExists) {
        DocumentReference docRef =
            firebasestore.collection('recipes').doc(recipe.docId);

        await docRef.update(recipe.toMap());

        showToast(message: 'Draft updated successfully');
      } else {
        DocumentReference docRef =
            await firebasestore.collection('recipes').add(recipe.toMap());

        String docId = docRef.id;

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
    log("addRecipeToFirestore ${recipe.docId.toString()}");
    EasyLoading.show();
    try {
      QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('doc_id', isEqualTo: recipe.docId)
          .get();

      if (snapshot.docs.isNotEmpty && recipe.docId != null) {
        DocumentReference docRef =
            FirebaseFirestore.instance.collection('recipes').doc(recipe.docId);

        await docRef.update(recipe.toMap());
        String docId = docRef.id;

        await docRef.update({
          'doc_id': docId,
        });
        await firebasestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .update({
          'recipes': FieldValue.arrayUnion([docId])
        });
        userDetails!.recipes!.add(recipe.docId!);
        recipe.user = userDetails;
        if (recipe.visibility != 'private') {
          recipes.add(recipe);
        }
        showToast(message: 'Recipe updated successfully');
      } else {
        DocumentReference docRef =
            await firebasestore.collection('recipes').add(recipe.toMap());

        String docId = docRef.id;

        await docRef.update({'doc_id': docId});
        await firebasestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .update({
          'recipes': FieldValue.arrayUnion([docId])
        });
        userDetails!.recipes!.add(docId);
        recipe.user = userDetails;
        if (recipe.visibility != 'private') {
          recipes.add(recipe);
        }
        showToast(message: 'Recipe added successfully');
      }
      EasyLoading.dismiss();
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      log(error.toString());
      return false;
    }
  }

  Future<String> uploadChefNoteToFirebaseStorage(String filePath) async {
    try {
      File file = File(filePath);
      EasyLoading.show();
      Reference storageReference =
          firebaseStorage.ref().child('audio/${DateTime.now()}.mpeg4');
      UploadTask uploadTask = storageReference.putFile(file);
      // ignore: avoid_print
      await uploadTask.whenComplete(() => print('File Uploaded'));
      EasyLoading.dismiss();
      return await storageReference.getDownloadURL();
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: 'Error uploading audio files to Firebase Storage: $e');
      log('Error uploading audio to Firebase Storage: $e');
      return '';
    }
  }

  Future<List<String>> uploadMediaToFirebase(
    List<XFile?> mediaFiles,
    String id,
  ) async {
    List<String> mediaUrls = [];
    try {
      EasyLoading.show();
      for (var media in mediaFiles) {
        String fileName;
        String fileExtension;

        if (media!.isVideo) {
          fileExtension = '.mp4';
          fileName =
              DateTime.now().millisecondsSinceEpoch.toString() + fileExtension;
        } else {
          fileExtension = '.jpg';
          fileName =
              DateTime.now().millisecondsSinceEpoch.toString() + fileExtension;
        }

        Reference ref = firebaseStorage.ref().child('images/recipes/$fileName');
        UploadTask uploadTask = ref.putFile(File(media.path));
        TaskSnapshot taskSnapshot = await uploadTask;
        String mediaUrl = await taskSnapshot.ref.getDownloadURL();

        mediaUrls.add(mediaUrl);
        log(mediaUrls.toString());
      }
      EasyLoading.dismiss();
      return mediaUrls;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(
          message: 'Error uploading media files to Firebase Storage: $error');
      log('Error uploading media files to Firebase Storage: $error');

      return [];
    }
  }

  Future<void> deleteAudioFromDocument(String id, String url) async {
    try {
      CollectionReference collection = firebasestore.collection('recipes');
      DocumentReference documentReference = collection.doc(id);
      EasyLoading.show();
      String filePath = Uri.decodeFull(Uri.parse(url).path);

      filePath = filePath.substring(38);
      log(filePath);

      Reference storageRef = firebaseStorage.ref().child(filePath);

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
    List<String> imageUrls = [];

    try {
      for (var image in images) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = firebaseStorage.ref().child('images/$fileName');
        UploadTask uploadTask = ref.putFile(File(image!.path));
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
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
      QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('status', isNotEqualTo: 'draft')
          // .where('visibility', isEqualTo: 'public')
          .where('uid', isEqualTo: uid)
          .get();

      List<RecipeModel> recipes = [];
      for (var doc in snapshot.docs) {
        RecipeModel recipe = RecipeModel.fromSnapshot(doc);

        // Fetch comments for the current recipe
        QuerySnapshot commentsSnapshot =
            await doc.reference.collection('comments').get();
        List<CommentModel> comments = commentsSnapshot.docs
            .map((commentDoc) => CommentModel.fromSnapshot(commentDoc))
            .toList();
        recipe.comment = comments;

        // Fetch user details by UID and assign it to the recipe
        UserModel? user = await _userService.fetchUserByUID(recipe.uid);
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
      List<RecipeModel> allRecipes = [];

      for (String uId in userDetails!.following!) {
        QuerySnapshot snapshot = await firebasestore
            .collection('recipes')
            .where('uid', isEqualTo: uId)
            .where('status', isEqualTo: 'published')
            .where('visibility', isEqualTo: 'Public')
            .get();

        List<RecipeModel> recipes = [];
        for (var doc in snapshot.docs) {
          RecipeModel recipe = RecipeModel.fromSnapshot(doc);

          // Fetch comments for the current recipe
          QuerySnapshot commentsSnapshot =
              await doc.reference.collection('comments').get();
          List<CommentModel> comments = commentsSnapshot.docs
              .map((commentDoc) => CommentModel.fromSnapshot(commentDoc))
              .toList();
          recipe.comment = comments;

          // Fetch user details by UID and assign it to the recipe
          UserModel? user = await _userService.fetchUserByUID(recipe.uid);
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

  Future<List<RecipeModel>> fetchAllRecipes() async {
    try {
      // Fetches all documents from the 'recipes' collection
      QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('visibility', isEqualTo: 'Public')
          .where('status', isEqualTo: 'published')
          .get();

      // Maps each DocumentSnapshot to a RecipeModel
      List<RecipeModel> recipes = [];
      for (var doc in snapshot.docs) {
        RecipeModel recipe = RecipeModel.fromSnapshot(doc);

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
      log("Error fetching recipes: $e");
      return []; // Return an empty list on error
    }
  }

  List<RecipeModel> drafts = [];
  Future<List<RecipeModel>> fetchDraftRecipes(String uid) async {
    try {
      QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('uid', isEqualTo: uid)
          .where('visibility', isEqualTo: 'private')
          .where('status', isEqualTo: 'draft')
          .get();

      List<RecipeModel> draftRecipes = [];
      for (var doc in snapshot.docs) {
        RecipeModel draftRecipe = RecipeModel.fromSnapshot(doc);

        QuerySnapshot commentsSnapshot =
            await doc.reference.collection('comments').get();
        List<CommentModel> comments = commentsSnapshot.docs
            .map((commentDoc) => CommentModel.fromSnapshot(commentDoc))
            .toList();
        draftRecipe.comment = comments;

        UserModel? user = await _userService.fetchUserByUID(draftRecipe.uid);
        draftRecipe.user = user;

        if (drafts.any((element) => element.docId == doc.id)) {
          await firebasestore
              .collection('recipes')
              .doc(doc.id)
              .update(draftRecipe.toMap());
        } else {
          draftRecipe.docId = doc.id;
          draftRecipes.add(draftRecipe);
        }
      }

      return draftRecipes;
    } catch (e) {
      log("Error fetching draft recipes: $e");
      return [];
    }
  }

  Future<bool> updatePrivateRecipe(RecipeModel recipe) async {
    try {
      bool draftExists = await doesDraftExist(recipe.docId!);
      log("draft exits $draftExists");
      EasyLoading.show();
      if (draftExists) {
        DocumentReference docRef =
            firebasestore.collection('recipes').doc(recipe.docId);

        await docRef.update({'visibility': 'Public'});

        showToast(message: 'Saved Recipe Publically');
      }
      EasyLoading.dismiss();
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error Saving Recipe Publically: $error');
      return false;
    }
  }

  Future<List<RecipeModel>> fetchPrivateRecipes(String uid) async {
    try {
      QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('uid', isEqualTo: uid)
          .where('visibility', isEqualTo: 'private')
          .where('status', isEqualTo: 'published')
          .get();

      List<RecipeModel> privateRecipes = [];
      for (var doc in snapshot.docs) {
        RecipeModel privatetRecipe = RecipeModel.fromSnapshot(doc);

        privatetRecipe.user = userDetails;

        privateRecipes.add(privatetRecipe);
      }

      return privateRecipes;
    } catch (e) {
      log("Error fetching private recipes: $e");
      return [];
    }
  }


}
