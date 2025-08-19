// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/shopping_list/shopping_list_viewmodel.dart';

class TopBarShoppingScreen extends ViewModelWidget<ShoppingListViewModel>
    implements PreferredSizeWidget {
  const TopBarShoppingScreen({super.key});

  @override
  Widget build(BuildContext context, ShoppingListViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0, left: 40.w, right: 10),
      child: ListTile(
        title: Center(
          child: Text(
            'Shopping List',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        trailing: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            try {
              await viewModel.updateShoppingList();
              viewModel.back();
            } catch (e, stackTrace) {
              log('Failed to update shopping list on pop: $e');
              log('StackTrace: $stackTrace');
            }
            // Ensure that the pop operation is not blocked
          },
          child: Container(
              alignment: Alignment.center,
              height: 26.h,
              width: 26.w,
              child: SvgPicture.asset('assets/images/icons/close.svg')),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
