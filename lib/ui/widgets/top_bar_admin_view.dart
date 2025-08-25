import 'package:sailing_chefs/core/imports/core_imports.dart';

class TopBarAdminView<T extends BaseViewModel> extends ViewModelWidget<T>
    implements PreferredSizeWidget {
  const TopBarAdminView(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context, T viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => viewModel.getBack(),
              child: Container(
                alignment: Alignment.center,
                height: 26.h,
                width: 26.w,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: kcBlackColor,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: globalTextStyle(
              fontSize: 16.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
          horizontalSpaceSmall,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
