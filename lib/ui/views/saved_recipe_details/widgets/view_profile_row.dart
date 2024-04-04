import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../saved_recipe_details_viewmodel.dart';

class ViewProfileRow extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  const ViewProfileRow({super.key});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          height: 40,
          width: 150,
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/icons/chef.jpg'),
              ),
              horizontalSpaceSmall,
              const Text(
                'Danica Nel',
                style: TextStyle(
                    color: kcBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {
            viewModel.moveToChefProfileView();
          },
          child: const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              'View',
              style: TextStyle(
                color: kcPrimaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
