import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

import 'package:sailing_chefs/ui/common/show_toast.dart';

class CommentService with ListenableServiceMixin {
  final UserServices userService = UserServices();

  List<CommentModel> comments = [];
  Future<void> getComments(String recipeId) async {
    comments = await fetchCommentsByRecipeId(recipeId);

    notifyListeners();
  }

  void clearComments() {
    comments.clear();
  }

  Future<bool> deleteComment(CommentModel comment) async {
    final deleted = await deleteCommentToFirestore(comment);
    return deleted;
  }

  Future<bool> deleteCommentToFirestore(CommentModel comment) async {
    try {
      EasyLoading.show();

      // Get a reference to the comments subcollection of the specified recipe ID
      final CollectionReference commentsCollection = firebasestore
          .collection('recipes')
          .doc(comment.recipeId)
          .collection('comments');

      await commentsCollection.doc(comment.id).delete();

      EasyLoading.dismiss();
      showToast(message: 'Comment deleted successfully');
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error deleteing comment : $error');
      return false;
    }
  }

  Future<bool> addComment(CommentModel comment) async {
    final uploaded = await addCommentToFirestore(comment);
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
      final CollectionReference commentsCollection = firebasestore
          .collection('recipes')
          .doc(comment.recipeId)
          .collection('comments');

      // Add the new comment to the comments subcollection
      final docRef = await commentsCollection.add(comment.toJson());
      final commentId = docRef.id; // Get the docId
      comment.id = commentId; // Update the commentId

      await docRef.update(
          {'commentId': commentId}); // Update the commentId in Firestore

      EasyLoading.dismiss();
      showToast(message: 'Comment added successfully');
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error adding comment to Firestore: $error');
      return false;
    }
  }

  Future<bool> updateCommentInFirestore(CommentModel comment) async {
    try {
      EasyLoading.show();

      final DocumentReference commentDocRef = firebasestore
          .collection('recipes')
          .doc(comment.recipeId)
          .collection('comments')
          .doc(comment.id);

      await commentDocRef.update(comment.toJson());

      EasyLoading.dismiss();
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error updating comment in Firestore: $error');
      return false;
    }
  }

  Future<List<CommentModel>> fetchCommentsByRecipeId(String recipeId) async {
    try {
      // Access the subcollection 'comments' within the specific 'recipe' document
      final QuerySnapshot querySnapshot = await firebasestore
          .collection('recipes')
          .doc(recipeId)
          .collection('comments')
          .orderBy('timestamp', descending: true)
          .get();

      // Convert the querySnapshot documents to a list of CommentModel
      final comments = querySnapshot.docs
          .map(CommentModel.fromSnapshot)
          .toList();

      return comments;
    } catch (e) {
      // Handle errors and return an empty list
      return [];
    }
  }

  Future<List<String>> uploadImagesToFirebase(List<File> images) async {
    final imageUrls = <String>[];

    try {
      EasyLoading.show();
      for (final image in images) {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final ref =
            firebaseStorage.ref().child('images/comments/$fileName');
        final uploadTask = ref.putFile(File(image.path));
        final taskSnapshot = await uploadTask;
        final imageUrl = await taskSnapshot.ref.getDownloadURL();
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
