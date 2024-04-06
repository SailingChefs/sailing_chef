import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class RecipeService {
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

      EasyLoading.dismiss();

      showToast(message: 'Recipe added successfully');
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error adding recipe to Firestore: $error');
      return false;
    }
  }

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
}
