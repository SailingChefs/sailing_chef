import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class FeedbackViewModel extends BaseViewModel {
  final TextEditingController feedbackController = TextEditingController();
  final _navigationService = locator<NavigationService>();
  Future<void> submitFeedback(String userId) async {
    final feedbackText = feedbackController.text;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('feedbacks')
          .add({
        'feedback': feedbackText,
        'timestamp': FieldValue.serverTimestamp(),
      });
      feedbackController.clear();
      showToast(message: 'Feedback sent');
    } catch (e) {
      showToast(message: e.toString());
    }
  }

  void getBack() {
    _navigationService.back();
  }
}
