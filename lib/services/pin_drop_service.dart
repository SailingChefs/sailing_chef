import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/pindrop_review.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class PinDropService with ListenableServiceMixin {
  Future<void> savePinnedLocation(PinnedLocation pinnedLocation) async {
    Map<String, dynamic> data = pinnedLocation.toMap();

    await FirebaseFirestore.instance.collection('pins').add(data);
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

  Future<void> addReview(String pinId, Review review) async {
    final CollectionReference pinsCollection =
        FirebaseFirestore.instance.collection('pins');
    final DocumentReference pinDoc = pinsCollection.doc(pinId);
    final CollectionReference reviewsCollection = pinDoc.collection('reviews');
    final DocumentReference reviewDoc = reviewsCollection.doc();

    await reviewDoc.set(review.toFirestore());
  }

  Future<List<PinnedLocation>> getPinsNearUserLocation(
      LatLng userLocation) async {
    final List<PinnedLocation> pins = [];
    final ref = FirebaseFirestore.instance.collection('pins');
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
      geopointFrom: (data) =>
          (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint,
    );

    for (final doc in query) {
      final PinnedLocation pin =
          PinnedLocation.fromSnapshot(doc.documentSnapshot);
      pins.add(pin);
    }
    log(pins.toString());
    return pins;
  }

  Future<List<PinnedLocation>> getPinsUsingTags(
      LatLng userLocation, List<String> tags) async {
    final List<PinnedLocation> pins = [];
    final ref = FirebaseFirestore.instance.collection('pins');
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
