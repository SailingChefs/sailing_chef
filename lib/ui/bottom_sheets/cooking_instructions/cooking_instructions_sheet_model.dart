import 'package:sailing_chefs/core/imports/core_imports.dart';

class CookingInstructionsSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final TextEditingController cookingInstructionController =
      TextEditingController();
  List<String> instructionsList = [];

  void popBack() {
    _navigationService.back();
  }

  void saveData() {
    // Your logic to save data
  }

  void addInstruction() {
    final instruction = cookingInstructionController.text.trim();
    if (instruction.isNotEmpty) {
      instructionsList.add(instruction);
      cookingInstructionController.clear();
      notifyListeners();
    }
  }

  void deleteInstruction(int index) {
    instructionsList.removeAt(index);
    notifyListeners();
  }
}
