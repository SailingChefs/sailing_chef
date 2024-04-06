import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet.dart';

class CookingInstructionsSheetModel extends BaseViewModel {
      final Function(SheetResponse response)? completer;
      CookingInstructionsSheetModel({required this.completer});
  final _navigationService = locator<NavigationService>();
  final TextEditingController cookingInstructionController =
      TextEditingController();
  List<String> instructionsList = [];

  void popBack() {
    _navigationService.back();
  }

  void saveData() {
    if(completer != null){
      completer!(SheetResponse(confirmed: true,data: CookingInstructionsSheetResponse( instructionsListResponse: instructionsList)));
      
    }
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
