import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';

import '../saved_recipe_details_viewmodel.dart';

class ViewProfileRow extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final UserModel user;
  const ViewProfileRow({super.key, required this.user});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        padding: EdgeInsets.all(8.0.dg),
        // width: 150.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 19.62.dg,
              backgroundImage: NetworkImage(
                user.displayPicture!,
              ),
            ),
            horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName!,
                   style: globalTextStyle(
                      letterSpacing: -0.5,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: kcBlackColor,
                    ),
                ),
                Text('${user.recipes!.length} dishes',

                    style: globalTextStyle(
                      fontSize: 14.sp,
                      letterSpacing: -0.3,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.5),
                    ),
                    ),
              ],
            ),
          ],
        ),
      ),
      user.uid == userDetails!.uid!
          ? const SizedBox()
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                
                backgroundColor: kcsgreycolor
              ),
              onPressed: () => viewModel.moveToChatScreen(user),
              child: const Icon(
                FlutterRemix.chat_4_line,
                color: kcBlackColor,
              ),
            )
    ]);
  }
}