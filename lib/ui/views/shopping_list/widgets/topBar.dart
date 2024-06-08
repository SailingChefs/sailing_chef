// ignore_for_file: deprecated_member_use

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/shopping_list/shopping_list_viewmodel.dart';

class TopBarShoppingScreen extends ViewModelWidget<ShoppingListViewModel>
    implements PreferredSizeWidget {
  const TopBarShoppingScreen({super.key});
  
  @override
  Widget build(BuildContext context, ShoppingListViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0,bottom: 20,left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: viewModel.back,
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
            'Shopping List',
            style: globalTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kcBlackColor),
          ),
          const SizedBox(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
