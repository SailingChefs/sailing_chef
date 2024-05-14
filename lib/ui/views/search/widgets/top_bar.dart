import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../search_viewmodel.dart';

class TopBarSearchScreen extends ViewModelWidget<SearchViewModel> {
  const TopBarSearchScreen({super.key});

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => viewModel.goBack(),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8.0.dg),
            height: 36.h,
            width: 36.w,
            decoration: const BoxDecoration(
              color: kcVeryLightGrey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: kcPrimaryColor,
              size: 18.sp,
            ),
          ),
        ),
        // Text(
        //   'Saved Recipes',
        //   style: globalTextStyle(
        //       fontSize: 18.0.dg,
        //       color: Colors.black.withOpacity(0.6),
        //       fontWeight: FontWeight.w600),
        // ),
        const SizedBox(),
      ],
    );
  }
}
