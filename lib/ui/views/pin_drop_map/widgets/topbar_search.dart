import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/searchbar.dart';

class SearchBarPinDrop extends ViewModelWidget<PinDropMapViewModel> {
  const SearchBarPinDrop({super.key});

  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: PinsSearchDelegate());
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
        Stack(
          children: [
            IconButton(
              onPressed: viewModel.tagsIconSelected,
              icon: const Icon(FlutterRemix.equalizer_line),
              color: kcPrimaryColor,
              iconSize: 30.dg,
            ),
            Positioned(
              top: 0,
              left: 25,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  color: kclightgreencolor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  viewModel.totalFilters.toString(),
                  style: globalTextStyle(fontSize: 12.sp, color: kcwhitecolor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
