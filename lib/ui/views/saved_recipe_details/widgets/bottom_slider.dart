
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class BottomSlider extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  const BottomSlider({super.key});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return SizedBox(
      width: double.maxFinite,
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.recipeList.length,
        itemBuilder: (context, index) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: SizedBox(
                width: 139,
                height: 162,
                child: ClipRRect(
                
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(viewModel.recipeList[index].coverImage.first,fit: BoxFit.cover,)
                ),
              )
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(viewModel.recipeList[index].title),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_outline)),
                ],
              ),
            ]
          ),
        );
                })

    );
  }
}