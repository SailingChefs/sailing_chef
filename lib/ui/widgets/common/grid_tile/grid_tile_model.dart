import 'package:sailing_chefs/app/app.locator.dart';

import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:stacked/stacked.dart';

class GridTileModel extends ReactiveViewModel {
  final SavedRecipeService _savedRecipeService = locator<SavedRecipeService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_savedRecipeService];

  void onBookmarkTap(String recipeId) {
    _savedRecipeService.addSavedRecipe(SavedRecipeModel(
      recipeId: recipeId,
    ));
    notifyListeners();
  }
// String formatTimeString(String timeString) {
//   int minutes = int.tryParse(timeString) ?? 0; // Parsing string to integer, defaulting to 0 if parsing fails
  
//   if (minutes == 0) {
//     return '0 h'; // If time is zero minutes, only display hours
//   } else {
//     int hours = minutes ~/ 60;
//     int remainingMinutes = minutes % 60;
//     if (remainingMinutes == 0) {
//       return '$hours h'; // If no remaining minutes, only display hours
//     } else if (hours == 0) {
//       return '$remainingMinutes mins'; // If less than an hour, display only minutes
//     } else {
//       return '$hours h $remainingMinutes mins'; // Otherwise, display hours and minutes
//     }
//   }
// }



}
