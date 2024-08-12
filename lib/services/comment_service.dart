import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

import '../ui/common/show_toast.dart';

class CommentService with ListenableServiceMixin {
  final UserServices userService = UserServices();
  
  List<CommentModel> comments = [];
  getComments(String recipeId) async {
    comments = await fetchCommentsByRecipeId(recipeId);

    notifyListeners();
  }

  clearComments() {
    comments.clear();
  }

  Future<bool> addComment(CommentModel comment) async {
    bool uploaded = await addCommentToFirestore(comment);
    if (!uploaded) {
      return false;
    }

    comments.add(comment);
    // RecipeService.recipes.where((recipe) => recipe.docId == comment.recipeId).first.comment!.add(comment);

    notifyListeners();
    return true;
  }

  // Future<bool> addCommentToFirestore(CommentModel comment) async {
  //   try {
  //     EasyLoading.show();
  //     DocumentReference docRef =
  //         await firebasestore.collection('recipes').doc(comment.recipeId).collection('comments').update(comment.toMap());

  //     // Get the document ID assigned by Firestore
  //     String docId = docRef.id;

  //     // Update the document with the document ID
  //     await docRef.update({'doc_id': docId});

  //     EasyLoading.dismiss();
  //     showToast(message: 'Comment added successfully');
  //     return true;
  //   } catch (error) {
  //     EasyLoading.dismiss();
  //     showToast(message: 'Error adding comment to Firestore: $error');
  //     return false;
  //   }
  // }

  Future<bool> addCommentToFirestore(CommentModel comment) async {
    try {
      EasyLoading.show();

      // Get a reference to the comments subcollection of the specified recipe ID
      CollectionReference commentsCollection = firebasestore
          .collection('recipes')
          .doc(comment.recipeId)
          .collection('comments');

      // Add the new comment to the comments subcollection
      await commentsCollection.add(comment.toJson());

      EasyLoading.dismiss();
      showToast(message: 'Comment added successfully');
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error adding comment to Firestore: $error');
      return false;
    }
  }

 Future<List<CommentModel>> fetchCommentsByRecipeId(String recipeId) async {
  try {
    // Access the subcollection 'comments' within the specific 'recipe' document
    QuerySnapshot querySnapshot = await firebasestore
        .collection('recipes')
        .doc(recipeId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .get();

    // Convert the querySnapshot documents to a list of CommentModel
    List<CommentModel> comments = querySnapshot.docs
        .map((doc) => CommentModel.fromSnapshot(doc))
        .toList();

    return comments;
  } catch (e) {
    // Handle errors and return an empty list
    return [];
  }
}


  Future<List<String>> uploadImagesToFirebase(List<File> images) async {
    List<String> imageUrls = [];

    try {
      EasyLoading.show();
      for (var image in images) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref =
            firebaseStorage.ref().child('images/comments/$fileName');
        UploadTask uploadTask = ref.putFile(File(image.path));
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
}
