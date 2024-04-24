import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';

import '../saved_recipe_details_viewmodel.dart';

class ViewProfileRow extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final UserModel user;
  const ViewProfileRow({super.key, required this.user});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: 150.w,
        child: Row(
          children: [
            CircleAvatar(
              radius: 19.62.dg,
              backgroundImage: NetworkImage(
                user.displayPicture!,
              ),
            ),
            horizontalSpaceSmall,
            Flexible(
              child: Text(
                user.displayName!,
                style: TextStyle(
                    color: kcBlackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      OutlinedButton(
        onPressed: () => viewModel.moveToChefProfileView(user),
        child: const Text(
          'View',
          style: TextStyle(
            color: kcPrimaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ]);
  }
}
