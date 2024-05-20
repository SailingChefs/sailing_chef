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
                  Icon(
                    FlutterRemix.search_line,
                    color: kcBlackColor.withOpacity(0.6),
                    size: 20.dg,
                  ),
                  horizontalSpaceSmall,
                  Text(
                    'Search',
                    style: globalTextStyle(
                      fontSize: 16.sp,
                      color: kcBlackColor.withOpacity(0.6),
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
          icon: const Icon(FlutterRemix.equalizer_line,color: filterIconColor,),
          color: kcPrimaryColor,
          iconSize: 32.h,
         
        ),
      ],
    );
  }
}
