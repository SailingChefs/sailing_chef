// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/reviews.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PindetailsDialogModel extends ReactiveViewModel {
  PinnedLocation pinnedLocation;
  String placeMark;
  final _reviewService = locator<PinDropService>();
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
    }
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
}
