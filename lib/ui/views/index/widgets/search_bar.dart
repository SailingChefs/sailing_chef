import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class SearchBarIndexView extends ViewModelWidget<IndexViewModel> {
  const SearchBarIndexView({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // showSearch(context: context, delegate: RecipeSearchDelegate());
              viewModel.toSearch();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.05,
              padding:
                  const EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                color: kcbuttoncolor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/icons/search.svg', color: searchIconColor,
                    width: 20.dg,height: 20,),
                  
                  horizontalSpaceSmall,
                  Text(
                    'Search',
                    style: globalTextStyle(
                      fontSize: 16.sp,
                      color: searchIconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        verticalSpaceMedium,
        IconButton(
          onPressed: viewModel.goToFilterView,
          icon: SvgPicture.asset('assets/images/icons/filter.svg',color: filterIconColor,width: 30,height: 30,),
          color: kcPrimaryColor,
          iconSize: 32.h,
         
        ),
      ],
    );
  }
}
