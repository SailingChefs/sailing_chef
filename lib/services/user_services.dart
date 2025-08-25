import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/shopping_list_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class UserServices with ListenableServiceMixin {
  UserModel? currentUserDetails;

  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future<ShoppingListModel> fetchShoppingList() async {
    final userDoc =
        firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid);

    final querySnapshot = await userDoc.collection('shopping_list').get();

    if (querySnapshot.docs.isNotEmpty) {
      // for (var doc in querySnapshot.docs) {
      //   shoppingList.add(ShoppingListModel.fromJson(doc.data()));
      // }
      return ShoppingListModel.fromJson(querySnapshot.docs.first.data());
    }

    return ShoppingListModel.empty();
  }

  Future<void> updateShoppingList() async {
    try {
      // Initialize userShoppingList if it's null
      userShoppingList ??= await fetchShoppingList();

      firebasestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('shopping_list')
          .doc(firebaseAuth.currentUser!.uid)
          .set(userShoppingList!.toJson());
    } catch (e, stackTrace) {
      log('StackTrace: $stackTrace');
    }
  }

  static Future<bool> storeUserRoleAndName({
    required UserModel userModel,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      // User not signed in or created
      throw Exception('User not signed in or created');
    }

    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    final userSnapshot = await usersCollection.doc(user.uid).get();
    userModel.userDocId = userSnapshot.id;

    if (!userSnapshot.exists) {
      await usersCollection.doc(user.uid).set(
            userModel.toJson(),
          );

      return true;
    }
    return false;
  }

  Future<void> storeUserRole(UserModel userModel, String role) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      // User not signed in or created
      throw Exception('User not signed in or created');
    }

    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    await usersCollection.doc(userDetails!.uid).update({'user_role': role});

    final querySnapshot =
        await usersCollection.where('email', isEqualTo: userModel.email).get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot userSnapshot = querySnapshot.docs.first;
      userModel.userDocId = userSnapshot.id;
      userModel.userRole = userSnapshot.get('user_role');

      if (userModel.userRole == 'guest') {
        _navigationService.replaceWithBottomBarGuestView();
      } else {
        _navigationService.replaceWithBottomNavBarView();
      }
    } else {
      _dialogService.showCustomDialog(
        variant: DialogType.roleDialog,
      );
    }
  }

  Future<UserModel> getUserDetails() async {
    try {
      final CollectionReference usersCollection =
          firebasestore.collection('users');

      final userSnapshot = await usersCollection
          .where('uid', isEqualTo: firebaseAuth.currentUser!.uid)
          .get();

      log(userSnapshot.docs.toString());

      if (userSnapshot.docs.isNotEmpty) {
        final DocumentSnapshot userDoc = userSnapshot.docs.first;

        // showToast(message: 'User Data fetched successfully');

        // UserModel.fromSnapshot(userDoc);

        // return  UserModel();
        return UserModel.fromSnapshot(userDoc);
      }
      throw Exception('User not found in Firestore');
    } catch (e) {
      showToast(message: e.toString());
      // Handle errors as needed
      throw Exception(e.toString());
    }
  }

  Future<bool> storeUserDetails(
      Map<String, dynamic> userModel, String uid) async {
    try {
      // Validate that uid is not empty
      if (uid.isEmpty) {
        EasyLoading.dismiss();
        showToast(message: 'Invalid user ID');
        return false;
      }

      EasyLoading.show();
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      final userSnapshot = await usersCollection.doc(uid).get();
      log(userSnapshot.exists.toString());
      if (userSnapshot.exists) {
        await usersCollection.doc(uid).update(userModel);
        EasyLoading.dismiss();
        showToast(message: 'User Data Uploaded successfully');
        return true;
      }
      EasyLoading.dismiss();
      await usersCollection.doc(uid).set(userModel);
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: e.toString());

      rethrow;
    }
  }

  Future<String> uploadImage(File imageFile, String fileName) async {
    try {
      EasyLoading.show();
      // Create a reference to the location you want to upload the file
      final ref = firebaseStorage.ref().child('images/usersDp/$fileName');

      // Upload the file to Firebase Storage
      final uploadTask = ref.putFile(imageFile);

      // Get the download URL of the uploaded file
      final taskSnapshot = await uploadTask;
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the download URL
      EasyLoading.dismiss();
      log(downloadUrl);
      return downloadUrl;
    } catch (e) {
      // Handle errors
      EasyLoading.dismiss();
      showToast(message: 'Error uploading image: $e');
      return '';
    }
  }

  Future<UserModel> fetchUserByUID(String uid) async {
    try {
      final DocumentSnapshot snapshot =
          await firebasestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      }
      log('No user found with uid: $uid');
      return UserModel();
    } catch (e) {
      log('Error fetching user: $e');
      return UserModel();
    }
  }

  Future<bool> doesUserExist(String uid) async {
    try {
      final userSnapshot =
          await firebasestore.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        return true;
      }
      return false;
    } catch (e) {
      log('Error fetching user: $e');
      return false;
    }
  }

  Future<void> clickOnForgetPassword({required String email}) async {
    try {
      EasyLoading.show();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      EasyLoading.dismiss();
      showToast(message: 'Forgot password link sent to $email');
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: e.toString());
    }
  }

  Future<bool> checkPassword(String password) async {
    try {
      // Get the current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return false;
      }

      // Create credentials with the provided email and password
      final credential =
          EmailAuthProvider.credential(email: user.email!, password: password);

      // Re-authenticate the user with the provided credentials
      await user.reauthenticateWithCredential(credential);
      log('User re-authenticated successfully : ${user.email}');
      // If re-authentication is successful, the password is correct
      return true;
    } catch (e) {
      log(e.toString());
      // If an error occurs, the password is incorrect
      return false;
    }
  }

  Future<bool> deleteUserAndDocument(String passworde) async {
    try {
      EasyLoading.show();

      // Re-authenticate the user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        EasyLoading.dismiss();
        return false;
      }

      // Assuming you have a way to get the user's email and password, prompt the user for these credentials.
      final email = userDetails!.email!; // Get the user's email
      final password = passworde; // Get the user's password

      final credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential);
      // Proceed with the deletion after re-authentication

      final QuerySnapshot followingSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('following', arrayContains: user.uid)
          .get();
      for (final doc in followingSnapshot.docs) {
        await doc.reference.update({
          'following': FieldValue.arrayRemove([user.uid])
        });
      }

      // Find all documents where the user UID is in the followers array
      final QuerySnapshot followersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('followers', arrayContains: user.uid)
          .get();
      for (final doc in followersSnapshot.docs) {
        await doc.reference.update({
          'followers': FieldValue.arrayRemove([user.uid])
        });
      }
      await FirebaseFirestore.instance
          .collection('conversations')
          .where('users', arrayContains: user.uid)
          .get()
          .then((querySnapshot) {
        for (final doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });

      await FirebaseFirestore.instance
          .collection('recipes')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((querySnapshot) {
        for (final doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
      final QuerySnapshot shopping = await FirebaseFirestore.instance
          .collection('shopping_list')
          .where('user_id', isEqualTo: user.uid)
          .get();
      for (final doc in shopping.docs) {
        await doc.reference.delete();
      }

      await FirebaseFirestore.instance
          .collection('recipes')
          .get()
          .then((recipesSnapshot) async {
        for (final recipeDoc in recipesSnapshot.docs) {
          await FirebaseFirestore.instance
              .collection('recipes')
              .doc(recipeDoc.id)
              .collection('comments')
              .where('uid', isEqualTo: user.uid)
              .get()
              .then((querySnapshot) {
            for (final commentDoc in querySnapshot.docs) {
              commentDoc.reference.delete();
            }
          });
        }
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();

      // if (userDetails!.userRole == 'culinarySchool') {
      //   for (var courseId in userDetails!.schoolCourses!) {
      //     await FirebaseFirestore.instance
      //         .collection('courses')
      //         .doc(courseId)
      //         .delete();
      //   }
      // }

      // Delete user from Firebase Authentication
      await user.delete();
      userDetails = null;
      savedRecipesGlobal = [];

      EasyLoading.dismiss();
      log('User account and document deleted successfully');
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      log('Error deleting user and document: $e');
      return false;
    }
  }

  Future<void> deleteGoogleUserDocument() async {
    final user = FirebaseAuth.instance.currentUser!;
    final QuerySnapshot followingSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('following', arrayContains: user.uid)
        .get();
    for (final doc in followingSnapshot.docs) {
      await doc.reference.update({
        'following': FieldValue.arrayRemove([user.uid])
      });
    }

    // Find all documents where the user UID is in the followers array
    final QuerySnapshot followersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('followers', arrayContains: user.uid)
        .get();
    for (final doc in followersSnapshot.docs) {
      await doc.reference.update({
        'followers': FieldValue.arrayRemove([user.uid])
      });
    }
    await FirebaseFirestore.instance
        .collection('conversations')
        .where('users', arrayContains: user.uid)
        .get()
        .then((querySnapshot) {
      for (final doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });

    await FirebaseFirestore.instance
        .collection('recipes')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((querySnapshot) {
      for (final doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
    final QuerySnapshot shopping = await FirebaseFirestore.instance
        .collection('shopping_list')
        .where('user_id', isEqualTo: user.uid)
        .get();
    for (final doc in shopping.docs) {
      await doc.reference.delete();
    }

    await FirebaseFirestore.instance
        .collection('recipes')
        .get()
        .then((recipesSnapshot) async {
      for (final recipeDoc in recipesSnapshot.docs) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeDoc.id)
            .collection('comments')
            .where('uid', isEqualTo: user.uid)
            .get()
            .then((querySnapshot) {
          for (final commentDoc in querySnapshot.docs) {
            commentDoc.reference.delete();
          }
        });
      }
    });
    await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
  }
}
