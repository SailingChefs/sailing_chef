import 'dart:developer';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/comment_model.dart';
import 'package:sailing_chefs/services/comment_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditCommentSheetModel extends BaseViewModel {
  final CommentModel comment;
  final Function(SheetResponse response)? completer;
  final CommentService _commentService = CommentService();
  final TextEditingController commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  double rating;
  List<File> images = [];
  List<String> existingImages = [];
  List<int> imagesToDelete = [];

  EditCommentSheetModel({
    required this.comment,
    required this.completer,
    required this.rating,
  });

  void onViewModelReady() {
    commentController.text = comment.content ?? '';
    if (comment.imageUrl != null && comment.imageUrl!.isNotEmpty) {
      existingImages = List.from(comment.imageUrl!);
    }
    rebuildUi();
  }

  void updateRating(double value) {
    rating = value;
    notifyListeners();
    rebuildUi();
  }

  void pickImage() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    images.addAll(selectedImages.map((xFile) => File(xFile.path)));
    rebuildUi();
  }

  void removeImage(int index) {
    images.removeAt(index);
    rebuildUi();
  }

  void removeExistingImage(int index) {
    imagesToDelete.add(index);
    rebuildUi();
  }

  bool isExistingImageMarkedForDeletion(int index) {
    return imagesToDelete.contains(index);
  }

  Future<void> updateComment() async {
    try {
      setBusy(true);

      // Upload new images if any
      List<String>? newImageUrls;
      if (images.isNotEmpty) {
        newImageUrls = await _commentService.uploadImagesToFirebase(images);
      }

      // Filter out images marked for deletion
      List<String> updatedExistingImages = [];
      for (int i = 0; i < existingImages.length; i++) {
        if (!imagesToDelete.contains(i)) {
          updatedExistingImages.add(existingImages[i]);
        }
      }

      // Combine existing and new images
      List<String> finalImageUrls = [
        ...updatedExistingImages,
        ...(newImageUrls ?? []),
      ];

      // Update the comment model
      CommentModel updatedComment = CommentModel(
        id: comment.id,
        userId: comment.userId,
        recipeId: comment.recipeId,
        content: commentController.text,
        timestamp: comment.timestamp,
        rating: rating,
        userName: comment.userName,
        userImageUrl: comment.userImageUrl,
        imageUrl: finalImageUrls.isEmpty ? null : finalImageUrls,
      );

      bool success =
          await _commentService.updateCommentInFirestore(updatedComment);

      if (success) {
        showToast(message: 'Comment updated successfully');
        completer!(SheetResponse(confirmed: true, data: updatedComment));
      } else {
        showToast(message: 'Failed to update comment');
      }
    } catch (e) {
      log('Error updating comment: $e');
      showToast(message: 'An error occurred');
    } finally {
      setBusy(false);
    }
  }

  void cancel() {
    completer!(SheetResponse(confirmed: false));
  }
}
