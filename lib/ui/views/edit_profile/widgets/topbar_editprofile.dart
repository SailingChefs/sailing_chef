import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_viewmodel.dart';

class TopBarEditProfile extends ViewModelWidget<EditProfileViewModel> {
  const TopBarEditProfile(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context, EditProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => viewModel.getBack(),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 8.0.dg),
              height: 36.h,
              width: 36.w,
              child: Icon(
                Icons.arrow_back_ios,
                color: kcBlackColor,
                size: 18.sp,
              ),
            ),
          ),
          Text(
            title,
            style: globalTextStyle(
                fontSize: 20.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w600),
          ),
          horizontalSpaceSmall,
        ],
      ),
    );
  }
}
