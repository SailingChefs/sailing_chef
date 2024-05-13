import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/reviews.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';

class RateExperienceDialogModel extends BaseViewModel {
  PinnedLocation pinnedLocation;
  String placeMark;
  RateExperienceDialogModel(
      {required this.pinnedLocation, required this.placeMark});
  double ratings = 3;
  final _dialogNavigation = locator<DialogService>();
  final TextEditingController reviewController = TextEditingController();
  final _reviewsService = locator<PinDropService>();
  void setRating(double value) {
    ratings = value;
    notifyListeners();
  }

  void showAllRatings() {}

  void saveReviewData() {
    try {
      log(pinnedLocation.id!);
      _reviewsService
          .addReviewsToFirestore(
            Reviews(
                userId: userDetails!.uid!,
                userName: userDetails!.displayName!,
                userImageUrl: userDetails!.displayPicture!,
                pindropId: pinnedLocation.id!,
                feedback: reviewController.text,
                rating: ratings,
                timestamp: Timestamp.now()),
          )
          .then((value) => _dialogNavigation.showCustomDialog(
                variant: DialogType.reviewsAll,
                data: pinnedLocation,
                title: placeMark,
              ));
    } catch (e) {
      log(e.toString());
    }
  }
}
