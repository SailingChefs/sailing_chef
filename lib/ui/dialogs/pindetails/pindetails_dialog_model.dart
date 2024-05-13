import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';

class PindetailsDialogModel extends BaseViewModel {
  PinnedLocation pinnedLocation;
  String placeMark;
  PindetailsDialogModel(
      {required this.pinnedLocation, required this.placeMark});
  PageController pageController = PageController(viewportFraction: 1.0);
  List<String>? tags;
  final _dialogNavigation = locator<DialogService>();
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

  void onViewModelReady() {
    for (var i = 0; i < pinnedLocation.tags.length; i++) {
      tags = pinnedLocation.tags;
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
