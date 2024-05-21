import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/reviews.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:stacked/stacked.dart';

class ReviewsAllDialogModel extends BaseViewModel {
  PinnedLocation pinnedLocation;
  String placeMark;
  ReviewsAllDialogModel(
      {required this.pinnedLocation, required this.placeMark});
  final _reviewService = locator<PinDropService>();
  List<ReviewsModel> reviews = [];
  void onViewModelReady() async {
    setBusy(true);
    await _reviewService.getReviews(pinnedLocation.id!);
    reviews = _reviewService.reviews;
    setBusy(false);
  }
}
