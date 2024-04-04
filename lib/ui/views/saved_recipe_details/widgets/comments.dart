import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/custom_comments_list.dart';

class CommentsDetailsScreen
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  const CommentsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceMedium,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ratings & Comments',
              style: TextStyle(
                fontSize: 17.0,
                color: kcBlackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'View All',
              style: TextStyle(
                color: kcBlackColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        const CustomListTileComments(
          name: 'Ellie',
          date: '15-08-2023',
          description:
              'I love sandwiches. but i never tried it out yet. looks pretty easy... looks delicious... I will defiI love sandwiches. but i never tried it out yet. looks pretty easy... looks delicious... I will definitelI love sandwiches. but i never tried it out yet. looks pretty easy... looks delicious... I will definitelnitely leave comment after trying it.',
          image: 'assets/images/icons/dp.jpg',
        ),
      ],
    );
  }
}
