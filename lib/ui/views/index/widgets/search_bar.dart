import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class SearchBarIndexView extends ViewModelWidget<IndexViewModel> {
  const SearchBarIndexView({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left:5.0),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.74,
            height: 42.dg,
            child: GestureDetector(
              onTap: () {
                viewModel.goToSearchView();
              },
              child: Container(
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
          horizontalSpaceSmall,
          IconButton(
            onPressed: () {
              viewModel.goToFilterView();
            },
            icon: const Icon(FlutterRemix.equalizer_line),
            color: kcPrimaryColor,
            iconSize: 30.dg,
          ),
        ],
      ),
    );
  }
}
