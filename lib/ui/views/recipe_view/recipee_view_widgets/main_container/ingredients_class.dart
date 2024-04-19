import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class IngredientsClass extends ViewModelWidget<RecipeViewViewModel> {
  final RecipeModel recipe;
  final List<XFile?> selectedImages;
  const IngredientsClass(
    this.recipe,
    this.selectedImages, {
    super.key,
  });

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.dg, horizontal: 25.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModel.addServes(recipe.servingSize);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kcPrimaryColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(2)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(5, 5)),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 10.sp,
                        color: kcwhitecolor,
                      ),
                    ),
                    Text(
                      'Serves ${recipe.servingSize}',
                      style: TextStyle(color: Colors.black, fontSize: 10.sp),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.removeServes(recipe.servingSize);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kcPrimaryColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(2)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(5, 5)),
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 10.dg,
                        color: kcwhitecolor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '${recipe.ingredients.length} items ',
              style: TextStyle(fontSize: 10.0.sp),
            ),
            SizedBox(
              height: recipe.ingredients.length * 100.h,
              child: ListView.builder(
                  itemCount: recipe.ingredients.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50.0.h,
                      width: 330.0.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(15.0.r),
                      ),
                      padding: EdgeInsets.all(10.0.dg),
                      margin: EdgeInsets.symmetric(vertical: 5.0.h),
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
          ],
        ),
      ),
    );
  }
}
