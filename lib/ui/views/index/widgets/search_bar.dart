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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: kcsgreycolor,
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
        horizontalSpaceTiny,
        IconButton(
          onPressed: viewModel.goToFilterView,
          icon: const Icon(FlutterRemix.equalizer_line),
          color: kcPrimaryColor,
          iconSize: 30.dg,
        ),
      ],
    );
  }
}
