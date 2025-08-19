// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/helpers/checkdatatype.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/reviews.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PindetailsDialogModel extends ReactiveViewModel {
  PinnedLocation pinnedLocation;
  String placeMark;
  final _reviewService = locator<PinDropService>();
  final bottomSheetService = locator<BottomSheetService>();
  List<ReviewsModel> get reviews => _reviewService.reviews;
  late bool serviceEnabled;
  late LocationPermission permission;
  Position? currentPosition;

  PindetailsDialogModel(
      {required this.pinnedLocation, required this.placeMark});

  PageController pageController = PageController(viewportFraction: 1.0);
  List<String>? tags;
  final _dialogNavigation = locator<DialogService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_reviewService];

  void showPreviousImage() {
    if (pageController.page! > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void showNextImage() {
    if (pageController.page! < pinnedLocation.picture.length - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  Future<void> openGoogleMaps() async {
    final url =
        'https://www.google.com/maps/dir/?api=1&origin=${currentPosition!.latitude},${currentPosition!.longitude}&destination=${pinnedLocation.location.latitude},${pinnedLocation.location.longitude}&travelmode=driving';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void editPin() async {
    // String markerId = const Uuid().v4();
    // final pinnedLocationData = PinnedLocationData(
    //     LatLng(currentCameraPosition!.target.latitude,
    //         currentCameraPosition!.target.longitude),
    //     null);

    final pinnedLocationData = PinnedLocationData(
        LatLng(pinnedLocation.location.latitude,
            pinnedLocation.location.longitude),
        pinnedLocation);
    await bottomSheetService.showCustomSheet(
      variant: BottomSheetType.dropPinSheet,
      data: {"pinnedLocationData": pinnedLocationData, "isNew": false},
    );
    // if (res2?.data == false || res2?.data == null) return;

    // addMarkers(
    //   markerId,
    //   LatLng(currentCameraPosition!.target.latitude,
    //       currentCameraPosition!.target.longitude),
    // );
    // showBottomButtons = false;
    // showMarker = false;
    rebuildUi();
  }

  void editMapPin(String markerId) async {
    final pinnedLocationData = PinnedLocationData(
        LatLng(pinnedLocation.location.latitude,
            pinnedLocation.location.longitude),
        pinnedLocation);
    final res2 = await bottomSheetService.showCustomSheet(
      variant: BottomSheetType.dropPinSheet,
      customData: pinnedLocationData,
    );

    if (res2?.data == false || res2?.data == null) return;

    // Perform any necessary updates after the user has edited the pin
    rebuildUi();
  }

  String calculateAverageRating(List<ReviewsModel> comments) {
    if (comments.isEmpty) {
      log(pinnedLocation.rating.toString());
      return "0.0"; // Return 0 if there are no comments
    }

    double totalRating = 0.0;

    // Calculate the total rating
    for (var comment in comments) {
      if (comment.rating != null) {
        totalRating += comment.rating!;
      }
    }

    // Calculate the average rating
    double averageRating = totalRating / comments.length;
    log(averageRating.toString());
    return averageRating.toStringAsFixed(1);
  }

  void onViewModelReady() async {
    setBusy(true);
    await getCurrentLocation();
    for (var i = 0; i < pinnedLocation.tags.length; i++) {
      tags = pinnedLocation.tags;
      log(tags.toString());
    }

    // notifyListeners();
    await _reviewService.getReviews(pinnedLocation.id!);
    setBusy(false);
  }

  Future<Position> getCurrentLocation() async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log(currentPosition.toString());
      rebuildUi();
      return currentPosition!;
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }

  void showRatingsExperience() {
    _dialogNavigation.showCustomDialog(
      variant: DialogType.rateExperience,
      data: pinnedLocation,
      title: placeMark,
    );
  }

  void navigateToBottomSheet() {
    final pinnedLocationData = PinnedLocationData(null, pinnedLocation);
    bottomSheetService.showCustomSheet(
        variant: BottomSheetType.dropPinSheet, data: pinnedLocationData);
  }

  void showReviews() {
    _dialogNavigation.showCustomDialog(
      variant: DialogType.reviewsAll,
      data: pinnedLocation,
      title: placeMark,
    );
  }
}
