// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class TopBarIndexScreen extends ViewModelWidget<IndexViewModel> implements PreferredSizeWidget{
  const TopBarIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width * 0.59,
          margin: const EdgeInsets.only(top:10,bottom: 10,),
          child: SvgPicture.asset(
            'assets/images/icons/logoo.svg',
            height: 39.h,
            width: 201,
            fit: BoxFit.scaleDown,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:20.0),
          child: SvgPicture.asset(
            'assets/images/icons/Menu.svg',
            width: 24.w,
            height: 24.h,
            color: kcBlackColor,
          ),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
