
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';

import '../saved_recipe_details_viewmodel.dart';

class ViewProfileRow extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final UserModel user;
  const ViewProfileRow({super.key, required this.user});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          height: 40.h,
          width: 150.w,
          child: Row(
            children: [
               CircleAvatar(
                backgroundImage: NetworkImage(user.displayPicture!),
              ),
              horizontalSpaceSmall,
              Text(
                user.displayName!,
                style: const TextStyle(
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
