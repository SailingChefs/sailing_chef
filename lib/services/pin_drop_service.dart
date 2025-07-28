import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/reviews.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class PinDropService with ListenableServiceMixin {
  final UserServices userService = UserServices();
  List<ReviewsModel> reviews = [];
  bool isInitialized = false;
  List<PinnedLocation> pins = [];

  Future<void> getReviews(String pinId) async {
    reviews = await fetchReviewsByPinId(pinId);
    notifyListeners();
  }

  Future<bool> deleteReview(ReviewsModel review) async {
    try {
      EasyLoading.show();
      await firebasestore
          .collection('pins')
          .doc(review.pindropId)
          .collection('reviews')
          .doc(review.id)
          .delete();

      reviews.removeWhere((element) => element.id == review.id);
      
      EasyLoading.dismiss();
      showToast(message: 'Review deleted successfully');
      notifyListeners();
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error deleting review: $error');
      return false;
    }
  }

  Future<bool> updateReview(ReviewsModel review, String newFeedback, double newRating) async {
    try {
      EasyLoading.show();
      
      await firebasestore
          .collection('pins')
          .doc(review.pindropId)
          .collection('reviews')
          .doc(review.id)
          .update({
        'feedback': newFeedback,
        'rating': newRating,
      });

      // Update the review in the local list
      int index = reviews.indexWhere((element) => element.id == review.id);
      if (index != -1) {
        reviews[index].feedback = newFeedback;
        reviews[index].rating = newRating;
      }
      
      EasyLoading.dismiss();
      showToast(message: 'Review updated successfully');
      notifyListeners();
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error updating review: $error');
      return false;
    }
  }

  // Future<void> getPins(LatLng location) async {
  //   // pins.clear();
  //   if(isInitialized) return;
  //   pins = await getPinsNearUserLocation(location);
  //   notifyListeners();

  // }

  Future<List<PinnedLocation>> getPins(LatLng location) async {
    final ref = firebasestore.collection('pins');
    final querySnapshot = await ref.get();

    List<PinnedLocation> pins = querySnapshot.docs
        .map((doc) => PinnedLocation.fromSnapshot(doc))
        .toList();

    return pins;
  }

  Future<List<ReviewsModel>> fetchReviewsByPinId(String pinId) async {
    log('pinId:$pinId');
    try {
      QuerySnapshot querySnapshot = await firebasestore
          .collection('pins')
          .doc(pinId)
          .collection('reviews')
          .where('pinId', isEqualTo: pinId)
          .orderBy('timestamp', descending: true)
          .get();

      List<ReviewsModel> reviews = querySnapshot.docs
          .map((doc) => ReviewsModel.fromSnapshot(doc))
          .toList();

      return reviews;
    } catch (e) {
      log('Error fetching reviews: $e');
      return [];
    }
  }

  Future<bool> addComment(ReviewsModel comment) async {
    bool uploaded = await addReviewsToFirestore(comment);
    if (!uploaded) {
      return false;
    }

    reviews.add(comment);

    notifyListeners();
    return true;
  }

  Future<bool> addReviewsToFirestore(ReviewsModel reviews) async {
    try {
      EasyLoading.show();
      DocumentReference docRef = await firebasestore
          .collection('pins')
          .doc(reviews.pindropId)
          .collection('reviews')
          .add(reviews.toJson());

      String docId = docRef.id;

      await docRef.update({'doc_id': docId});
      pins
          .where((element) => element.id == reviews.pindropId)
          .first
          .reviews!
          .add(reviews);
      EasyLoading.dismiss();
      showToast(message: 'review added successfully');
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error adding review to Firestore: $error');
      return false;
    }
  }

  Future<void> saveEditPin(PinnedLocation pinnedLocation) async {
    await firebasestore
        .collection('pins')
        .doc(pinnedLocation.uid)
        .set(pinnedLocation.toMap());

    notifyListeners();
  }

  Future<void> savePinnedLocation(PinnedLocation pinnedLocation) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('pins')
          .add(pinnedLocation.toMap());

      String id = firebasestore.collection('pins').doc().id;
      pinnedLocation.id = id;
      await docRef.update({'id': id});
      pins.add(PinnedLocation.fromMap(pinnedLocation.toMap()));
      // fetchReviewsByPinId(pinnedLocation.id!);

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> uploadImage(File imageFile, String fileName) async {
    try {
      EasyLoading.show();
      Reference ref = firebaseStorage.ref().child('pinImages/$fileName');

      UploadTask uploadTask = ref.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      EasyLoading.dismiss();
      return downloadUrl;
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: 'Error uploading image: $e');
      return '';
    }
  }

  Future<List<String>> uploadImages(List<XFile> imageFiles) async {
    final List<String> downloadUrls = [];
    EasyLoading.show();
    for (final imageFile in imageFiles) {
      final fileName = imageFile.name;
      final ref = firebaseStorage.ref().child('pinImages/$fileName');
      final uploadTask = ref.putFile(File(imageFile.path));
      final taskSnapshot = await uploadTask;
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    EasyLoading.dismiss();
    return downloadUrls;
  }

  // Future<void> addReview(String pinId, Review review) async {
  //   final CollectionReference pinsCollection =
  //       FirebaseFirestore.instance.collection('pins');
  //   final DocumentReference pinDoc = pinsCollection.doc(pinId);
  //   final CollectionReference reviewsCollection = pinDoc.collection('reviews');
  //   final DocumentReference reviewDoc = reviewsCollection.doc();

  //   await reviewDoc.set(review.toFirestore());
  // }

  Future<List<PinnedLocation>> getPinsNearUserLocation(LatLng userLocation) async {
    try {
      final ref = firebasestore.collection('pins');
      final query = await GeoCollectionReference(ref).fetchWithinWithDistance(
        center: GeoFirePoint(
          GeoPoint(
            userLocation.latitude,
            userLocation.longitude,
          ),
        ),
        radiusInKm: 50,
        geohashField: 'geohash',
        field: 'geo',
        strictMode: true,
        geopointFrom: (data) =>
            (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint,
      );

      // Clear existing pins if we're reloading
      if (!isInitialized) {
        pins.clear();
      }

      // Process pins in batches for better performance
      final List<Future<PinnedLocation>> pinFutures = query.map((doc) async {
        PinnedLocation pin = PinnedLocation.fromSnapshot(doc.documentSnapshot);
        pin.reviews = await fetchReviewsByPinId(pin.id!);
        return pin;
      }).toList();

      // Wait for all pins to load
      List<PinnedLocation> loadedPins = await Future.wait(pinFutures);
      pins.addAll(loadedPins);

      log('Loaded ${pins.length} pins');
      isInitialized = true;
      notifyListeners();
      return pins;
    } catch (e) {
      log('Error loading pins: $e');
      return [];
    }
  }

  Future<List<PinnedLocation>> getPinsUsingTags(
      LatLng userLocation, List<String> tags) async {
    final List<PinnedLocation> pins = [];
    final ref = firebasestore.collection('pins');
    final query = await GeoCollectionReference(ref).fetchWithinWithDistance(
      center: GeoFirePoint(
        GeoPoint(
          userLocation.latitude,
          userLocation.longitude,
        ),
      ),
      radiusInKm: 0.5,
      geohashField: 'geohash',
      field: 'geo',
      strictMode: true,
      queryBuilder: (query) => query.where(
        'tags',
        arrayContainsAny: tags,
      ),
      geopointFrom: (data) => (data['geo'])['geopoint'] as GeoPoint,
    );

    for (final doc in query) {
      final PinnedLocation pin =
          PinnedLocation.fromSnapshot(doc.documentSnapshot);
      pins.add(pin);
    }
    log("get location ${pins.toString()}");
    notifyListeners();
    return pins;
  }
}
