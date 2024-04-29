import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class RecipeService {
  final _userService = locator<UserServices>();
  final List<XFile?> media = List.empty();
  Future<bool> addRecipeToFirestore(RecipeModel recipe) async {
    try {
      EasyLoading.show();
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('recipes')
          .add(recipe.toMap());

      // Get the document ID assigned by Firestore
      String docId = docRef.id;

      // Update the document with the document ID
      await docRef.update({'doc_id': docId});
      log(docId.toString());

      EasyLoading.dismiss();

      showToast(message: 'Recipe added successfully');
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error adding recipe to Firestore: $error');
      return false;
    }
  }

  Future<String> uploadChefNoteToFirebaseStorage(String filePath) async {
    File file = File(filePath);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('audio/${DateTime.now()}.mpeg4');
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => print('File Uploaded'));
    return await storageReference.getDownloadURL();
  }

//   Future<List<String>> uploadImagesToFirebase(List<XFile?> images) async {
//     List<String> imageUrls = [];

  // Future<List<String>> uploadImagesToFirebase(List<XFile?> images) async {
  //   List<String> imageUrls = [];

  //   try {
  //     EasyLoading.show();
  //     for (var image in images) {
  //       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //       Reference ref = firebaseStorage.ref().child('images/recipes/$fileName');
  //       UploadTask uploadTask = ref.putFile(File(image!.path));
  //       TaskSnapshot taskSnapshot = await uploadTask;
  //       String imageUrl = await taskSnapshot.ref.getDownloadURL();
  //       imageUrls.add(imageUrl);
  //     }

  //     EasyLoading.dismiss();
  //     showToast(message: 'Images uploaded successfully');

  //     return imageUrls;
  //   } catch (error) {
  //     EasyLoading.dismiss();
  //     showToast(message: 'Error uploading images to Firebase Storage: $error');
  //     return [];
  //   }
  // }

  Future<List<String>> uploadMediaToFirebase(
    List<XFile?> mediaFiles,
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
      //    await FirebaseFirestore.instance.collection('recipes').doc(id).update({
      //   'cover_image': mediaUrls,
      // });

      return mediaUrls;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(
          message: 'Error uploading media files to Firebase Storage: $error');
      log('Error uploading media files to Firebase Storage: $error');
      return [];
    }
  }

  // Future<List<String>> uploadMediaToFirebase(List<XFile?> mediaFiles,String id) async {
  //   List<String> mediaUrls = [];

  //   try {
  //     EasyLoading.show();
  //     for (var media in mediaFiles) {
  //       String fileName;
  //       String fileExtension;

  //       if (media!.isVideo) {
  //         fileExtension = '.mp4';
  //         fileName =
  //             DateTime.now().millisecondsSinceEpoch.toString() + fileExtension;
  //       } else {
  //         fileExtension = '.jpg';
  //         fileName =
  //             DateTime.now().millisecondsSinceEpoch.toString() + fileExtension;
  //       }

  //       Reference ref = firebaseStorage.ref().child('images/recipes/$fileName');
  //       UploadTask uploadTask = ref.putFile(File(media.path));
  //       TaskSnapshot taskSnapshot = await uploadTask;
  //       String mediaUrl = await taskSnapshot.ref.getDownloadURL();
  //       log(mediaUrl);
  //       mediaUrls.add(mediaUrl);
  //     }

  //     EasyLoading.dismiss();
  //     // showToast(message: 'Media files uploaded successfully');
  //     //  await FirebaseFirestore.instance.collection('recipes').doc(id).update({
  //     // 'cover_image': mediaUrls,
  //   // });

  //     return mediaUrls;
  //   } catch (error) {
  //     EasyLoading.dismiss();
  //     showToast(
  //         message: 'Error uploading media files to Firebase Storage: $error');
  //      log( 'Error uploading media files to Firebase Storage: $error');
  //     return [];
  //   }
  // }

  Future<List<String>> uploadImagesToFirebase(List<XFile?> images) async {
    List<String> imageUrls = [];

    try {
      EasyLoading.show();
      for (var image in images) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = firebaseStorage.ref().child('images/$fileName');
        UploadTask uploadTask = ref.putFile(File(image!.path));
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      EasyLoading.dismiss();
      showToast(message: 'Images uploaded successfully');

      return imageUrls;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error uploading images to Firebase Storage: $error');
      return [];
    }
  }

  Future<List<RecipeModel>> fetchRecipesByUID(String uid) async {
    EasyLoading.show();
    try {
      // Fetch recipes
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .where('uid', isEqualTo: uid)
          .get();

      // Fetch user details by UID only once
      UserModel? user = await _userService.fetchUserByUID(uid);

      // Map each document to a RecipeModel and include user data
      List<RecipeModel> recipes = snapshot.docs.map((doc) {
        RecipeModel recipe = RecipeModel.fromSnapshot(doc);
        recipe.user = user; // Assuming RecipeModel has a field for UserModel
        return recipe;
      }).toList();
      // Map each document to a RecipeModel and include user data

      EasyLoading.dismiss();
      return recipes;
    } catch (e) {
      EasyLoading.dismiss();
      log('Error fetching recipes: $e');
      return [];
    }
  }

  Future<List<RecipeModel>> fetchAllRecipes() async {
    try {
      EasyLoading.show();

      QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('uid', isNotEqualTo: '123456')
          .get();

      List<RecipeModel> recipes = [];
      for (var doc in snapshot.docs) {
        RecipeModel recipe = RecipeModel.fromSnapshot(doc);

        UserModel? user = await _userService.fetchUserByUID(recipe.uid);
        recipe.user = user;
        recipes.add(recipe);
      }

      EasyLoading.dismiss();

      return recipes;
    } catch (e) {
      EasyLoading.dismiss();
      log("Error fetching recipes: $e");
      return [];
    }
  }

  Future<List<RecipeModel>> fetchRandomRecipes(int count) async {
    try {
      EasyLoading.show();

      // Attempt to fetch more than you need to improve randomness
      QuerySnapshot snapshot = await firebasestore
          .collection('recipes')
          .where('uid', isNotEqualTo: '123456')
          .limit(10) // Adjust number based on expected collection size
          .get();

      List<RecipeModel> allRecipes = [];
      for (var doc in snapshot.docs) {
        allRecipes.add(RecipeModel.fromSnapshot(doc));
      }

      // Shuffle the list to randomize and then take the first 5
      allRecipes.shuffle();
      List<RecipeModel> randomRecipes = allRecipes.take(count).toList();

      // Optionally fetch associated user data if needed
      for (RecipeModel recipe in randomRecipes) {
        UserModel? user = await _userService.fetchUserByUID(recipe.uid);
        recipe.user = user;
      }

      EasyLoading.dismiss();

      return randomRecipes;
    } catch (e) {
      EasyLoading.dismiss();
      log("Error fetching random recipes: $e");
      return [];
    }
  }
}
