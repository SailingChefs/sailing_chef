import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_viewmodel.dart';

import '../../../widgets/back_arrow.dart';

class TopBarFollowing extends ViewModelWidget<FollowingListViewModel>
    implements PreferredSizeWidget {
  final String name;
  const TopBarFollowing({super.key, required this.name});

  @override
  Widget build(BuildContext context, FollowingListViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackArrowWidget(
            onTap: () {
              viewModel.popBack();
            },
          ),
          SizedBox(
            width: 300,
            child: Text(
              textAlign: TextAlign.center,
              capitalizeEachWord(name),
              style: globalTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: kcBlackColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
