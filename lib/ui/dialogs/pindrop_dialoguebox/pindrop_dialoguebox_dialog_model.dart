import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';

import '../../../model/reviews.dart';

class PindropDialogueboxDialogModel extends ReactiveViewModel {
  PinnedLocation pinnedLocation;
  String placeMark;
  // String curLat;
  // String curLong;
  final _dialogService = locator<DialogService>();
  final _reviewService = locator<PinDropService>();
  List<ReviewsModel> get reviews => _reviewService.reviews;
  @override
  List<ListenableServiceMixin> get listenableServices => [_reviewService];
  PindropDialogueboxDialogModel({
    required this.pinnedLocation,
    required this.placeMark,
    // required this.curLong,
    // required this.curLat
  });

  String calculateAverageRating(List<ReviewsModel> comments) {
    if (comments.isEmpty) {
      return "0.0"; 
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
    return averageRating.toStringAsFixed(1);
  }

  void onViewModelReady() async {
    setBusy(true);
    await _reviewService.getReviews(pinnedLocation.id!);
    setBusy(false);
  }

  getAddress(double latitude, double longitude) {}

  void callDeatilsDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.pindetails,
      data: pinnedLocation,

      title: placeMark,
      // additionalButtonTitle: curLat,
      // description: curLong,
    );
  }
}
