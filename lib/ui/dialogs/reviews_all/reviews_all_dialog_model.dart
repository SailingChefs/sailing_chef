import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/reviews.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReviewsAllDialogModel extends BaseViewModel {
  PinnedLocation pinnedLocation;
  String placeMark;
  ReviewsAllDialogModel(
      {required this.pinnedLocation, required this.placeMark});
  final _reviewService = locator<PinDropService>();
  final _dialogService = locator<DialogService>();
  final _auth = FirebaseAuth.instance;

  List<ReviewsModel> reviews = [];
  ReviewsModel? currentEditingReview;
  bool isEditingReview = false;
  bool isAddingReview = false;

  final TextEditingController feedbackController = TextEditingController();
  double currentRating = 0.0;

  Future<void> onViewModelReady() async {
    setBusy(true);
    await _reviewService.getReviews(pinnedLocation.id!);
    reviews = _reviewService.reviews;
    setBusy(false);
  }

  bool isUserReview(ReviewsModel review) {
    return review.userId == _auth.currentUser?.uid;
  }

  Future<void> deleteReview(ReviewsModel review) async {
    if (!isUserReview(review)) return;

    final dialogResponse = await _dialogService.showDialog(
      title: 'Delete Review',
      description: 'Are you sure you want to delete this review?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (dialogResponse?.confirmed ?? false) {
      setBusy(true);
      final success = await _reviewService.deleteReview(review);
      if (success) {
        reviews.removeWhere((r) => r.id == review.id);
      }
      setBusy(false);
      notifyListeners();
    }
  }

  void editReview(ReviewsModel review) {
    if (!isUserReview(review)) return;

    currentEditingReview = review;
    feedbackController.text = review.feedback ?? '';
    currentRating = review.rating ?? 0.0;
    isEditingReview = true;
    notifyListeners();
  }

  void cancelEdit() {
    currentEditingReview = null;
    feedbackController.clear();
    currentRating = 0.0;
    isEditingReview = false;
    notifyListeners();
  }

  Future<void> saveEditedReview() async {
    if (currentEditingReview == null) return;

    setBusy(true);
    final success = await _reviewService.updateReview(
        currentEditingReview!, feedbackController.text, currentRating);

    if (success) {
      // Update locally
      final index = reviews.indexWhere((r) => r.id == currentEditingReview!.id);
      if (index != -1) {
        reviews[index].feedback = feedbackController.text;
        reviews[index].rating = currentRating;
      }
      cancelEdit();
    }

    setBusy(false);
    notifyListeners();
  }

  void startAddingReview() {
    // Reset fields
    feedbackController.clear();
    currentRating = 0.0;
    isAddingReview = true;
    isEditingReview = false;
    currentEditingReview = null;
    notifyListeners();
  }

  void cancelAddingReview() {
    isAddingReview = false;
    feedbackController.clear();
    currentRating = 0.0;
    notifyListeners();
  }

  Future<bool> addNewReview() async {
    if (_auth.currentUser == null) {
      // Show error that user must be logged in
      return false;
    }

    if (feedbackController.text.trim().isEmpty || currentRating == 0) {
      // Show error that feedback and rating are required
      return false;
    }

    setBusy(true);

    // Get current user info
    final currentUser = _auth.currentUser!;

    // Create a new review
    final newReview = ReviewsModel(
      userId: currentUser.uid,
      userName: currentUser.displayName ?? 'Anonymous',
      userImageUrl: currentUser.photoURL ?? '',
      pindropId: pinnedLocation.id!,
      feedback: feedbackController.text.trim(),
      timestamp: Timestamp.now(),
      rating: currentRating,
    );

    // Add the review
    final success = await _reviewService.addComment(newReview);

    if (success) {
      // If successful, refresh reviews
      await _reviewService.getReviews(pinnedLocation.id!);
      reviews = _reviewService.reviews;
      isAddingReview = false;
      feedbackController.clear();
      currentRating = 0.0;
    }

    setBusy(false);
    notifyListeners();
    return success;
  }
}
