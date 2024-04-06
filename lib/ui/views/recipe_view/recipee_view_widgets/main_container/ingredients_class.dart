import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

import '../../../../widgets/bottom_sheet_btn.dart';

class IngredientsClass extends ViewModelWidget<RecipeViewViewModel> {
  final RecipeModel recipe;
  final List<XFile?> selectedImages ;
  const IngredientsClass(this.recipe, this.selectedImages, {
    super.key,
  });

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
  

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModel.addServes();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kcPrimaryColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(2)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(5, 5)),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 10,
                        color: kcwhitecolor,
                      ),
                    ),
                    Text(
                      'Serves ${viewModel.serves}',
                      style: const TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.removeServes();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kcPrimaryColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(2)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(5, 5)),
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 10,
                        color: kcwhitecolor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '${recipe.ingredients.length} items ',
              style: const TextStyle(fontSize: 10.0),
            ),
            SizedBox(
              height: recipe.ingredients.length * 80.0,
              child: ListView.builder(
                  itemCount: recipe.ingredients.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50.0,
                      width: 330.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            recipe.ingredients[index].name,
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            '${recipe.ingredients[index].quantity}  ${recipe.ingredients[index].unit}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            verticalSpaceMedium,
            Save_Recipe_Button(
              onPressed: () =>viewModel.saveRecipe(recipe,selectedImages),
              buttonText: 'Submit Recipe',
            ),
            horizontalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
