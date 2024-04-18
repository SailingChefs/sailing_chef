import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';

class SearchBarPinDrop extends ViewModelWidget<PinDropMapViewModel> {
  const SearchBarPinDrop({super.key});

  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // viewModel.goToSearchView();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  horizontalSpaceTiny,
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
            // viewModel.goToFilterView();
          },
          icon: const Icon(FlutterRemix.equalizer_line),
          color: kcPrimaryColor,
          iconSize: 30.dg,
        ),
      ],
    );
  }
}
