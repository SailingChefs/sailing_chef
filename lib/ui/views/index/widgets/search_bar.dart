import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class SearchBarIndexView extends ViewModelWidget<IndexViewModel> {
  const SearchBarIndexView({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: 35.dg,
          child: GestureDetector(
            onTap: () {
              viewModel.goToSearchView();
            },
            child: Container(
              decoration: BoxDecoration(
                color: kcPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: kcPrimaryColor,
                    size: 22.dg,
                  ),
                  horizontalSpaceSmall,
                  Text(
                    'Search',
                    style: globalTextStyle(
                      fontSize: 16.sp,
                      color: kcPrimaryColor,
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
    );
  }
}
