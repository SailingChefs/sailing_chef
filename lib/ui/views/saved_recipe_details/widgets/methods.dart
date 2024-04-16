import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class Methods extends StatelessWidget {
  final RecipeModel recipe;
  const Methods({super.key,required this.recipe});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Instructions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(
      
          height: recipe.methods.length * 70.h,
          child: ListView.builder(
            itemCount: recipe.methods.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CircleAvatar(
                      minRadius: double.minPositive + 13,
                      backgroundColor: Colors.blueGrey,
                      child: Text(
                      '${index + 1}',
                        style: const TextStyle(
                            color: kcwhitecolor, fontSize: 12),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(15.dg),
                      child: Text(
                       recipe.methods[index],
                        style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
       
      ],
    );
  }
}
