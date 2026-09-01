import 'package:sailing_chefs/core/imports/core_imports.dart';

class SupplierBottomNavViewModel extends BaseViewModel {
  int currentIndex = 0;

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
