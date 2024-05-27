// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class SearchBarIndexView extends ViewModelWidget<IndexViewModel> {
  const SearchBarIndexView({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // showSearch(context: context, delegate: RecipeSearchDelegate());
              viewModel.toSearch();
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              margin:  EdgeInsets.symmetric(horizontal: 16.0.dg),
              
              decoration: BoxDecoration(
                color: kcPrimaryColor.withOpacity(0.09),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/icons/search.svg', color: searchIconColor,
                    width: 16.w,height: 16.h,),
                  
                  horizontalSpaceSmall,
                  Text(
                    'Search',
                    style: globalTextStyle(
                      fontSize: 12.sp,
                      letterSpacing: -0.5,
                      color: searchIconColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
       
        IconButton(
          onPressed: viewModel.goToFilterView,
          icon: SvgPicture.asset('assets/images/misc/equilizer.svg',color: filterIconColor,width: 30.dg,height: 30.dg,),
          color: kcPrimaryColor,
          iconSize: 32.h,
         
        ),
        horizontalSpaceSmall,
      ],
    );
  }
}
