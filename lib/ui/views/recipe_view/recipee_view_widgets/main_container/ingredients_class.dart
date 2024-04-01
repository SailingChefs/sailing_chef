import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

import '../../../../widgets/bottom_sheet_btn.dart';

class IngredientsClass extends ViewModelWidget<RecipeViewViewModel> {
  const IngredientsClass({super.key,});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    List<String> ingredients = [
      'Butter',
      'Onion',
      'Spinach',
      'Corn',
      'Herbs',
      'Chilli flakes'
    ];

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const Text(
              '6 items',
              style: TextStyle(fontSize: 10.0),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: ingredients.length,
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
                            ingredients[index],
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            '${index + 1} Tsp',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            verticalSpaceMedium,
            Save_Recipe_Button(
              onPressed: () {},
              buttonText: 'Submit Recipe',
            ),
            horizontalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
