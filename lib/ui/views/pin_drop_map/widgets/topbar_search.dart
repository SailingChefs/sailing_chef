// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
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
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.05,
              padding: const EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                color: kcButtonColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/search.svg',
                    colorFilter: const ColorFilter.mode(
                      kcIconColor,
                      BlendMode.srcIn,
                    ),
                    // color: kcIconColor,
                    width: 20.dg,
                    height: 20,
                  ),
                  horizontalSpaceSmall,
                  Text(
                    'Search',
                    style: globalTextStyle(
                      fontSize: 16.sp,
                      color: kcIconColor,
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
              icon: SvgPicture.asset(
                'assets/images/misc/equilizer.svg',
                color: kcPrimaryColorDark,
                width: 30,
                height: 30,
              ),
              color: kcPrimaryColor,
              iconSize: 32.h,
            ),
            Positioned(
              top: 3,
              left: 25,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  color: kcPrimaryColorDark,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  viewModel.totalFilters.toString(),
                  style: globalTextStyle(fontSize: 10.sp, color: kcWhiteColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
