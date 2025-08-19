import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/selectedtab.dart';

class TagsSelectionWidget extends ViewModelWidget<PinDropMapViewModel> {
  const TagsSelectionWidget({
    required this.id,
    super.key,
  });
  final String id;
  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          final containerWidth = screenWidth * 0.95;
          final containerHeight = screenHeight * 0.6;
          final padding = screenWidth * 0.03;
          final verticalPadding = screenHeight * 0.15;
          final textFontSize = screenWidth * 0.04;
          final iconSize = screenWidth * 0.06;
          final spaceSize = screenWidth * 0.07;
          final buttonWidth = screenWidth * 0.4;
          final buttonHeight = screenHeight * 0.07;
          final borderRadius = screenWidth * 0.07;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: padding, right: padding, top: verticalPadding),
              child: Container(
                decoration: BoxDecoration(
                    color: kcwhitecolor,
                    borderRadius: BorderRadius.circular(borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: kcsgreycolor.withOpacity(0.5),
                        spreadRadius: 5,
                      )
                    ]),
                width: containerWidth,
                height: containerHeight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select one or more',
                            style: globalTextStyle(
                                fontSize: textFontSize,
                                letterSpacing: -0.5,
                                color: kcBlackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              viewModel.tagsIconSelected();
                            },
                            child: Icon(Icons.close,
                                color: kcBlackColor.withOpacity(0.87),
                                size: iconSize),
                          ),
                        ],
                      ),
                      verticalSpaceMedium,
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: [
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Provisioner',
                            index: 0,
                            selection: () {
                              viewModel.handleTagSelection('Provisioner');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Supermarket',
                            index: 1,
                            selection: () {
                              viewModel.handleTagSelection('Supermarket');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Deliverables',
                            index: 2,
                            selection: () {
                              viewModel.handleTagSelection('Supermarket');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Fresh market',
                            index: 3,
                            selection: () {
                              viewModel.handleTagSelection('Fresh market');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Fishmonger',
                            index: 4,
                            selection: () {
                              viewModel.handleTagSelection('Fishmonger');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Butchery',
                            index: 5,
                            selection: () {
                              viewModel.handleTagSelection('Butchery');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Bakery/Patisserie',
                            index: 6,
                            selection: () {
                              viewModel.handleTagSelection('Bakery/Patisserie');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Cakes',
                            index: 7,
                            selection: () {
                              viewModel.handleTagSelection('Cakes');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Special dietary',
                            index: 8,
                            selection: () {
                              viewModel.handleTagSelection('Special dietary');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Culinary store',
                            index: 9,
                            selection: () {
                              viewModel.handleTagSelection('Culinary store');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Florist',
                            index: 10,
                            selection: () {
                              viewModel.handleTagSelection('Florist');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Farm',
                            index: 11,
                            selection: () {
                              viewModel.handleTagSelection('Farm');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Liquor',
                            index: 12,
                            selection: () {
                              viewModel.handleTagSelection('Liquor');
                            },
                          ),
                          SelectedWidgetPinDrop(
                            selectedTabSelection: 'Restaurant',
                            index: 13,
                            selection: () {
                              viewModel.handleTagSelection('Restaurant');
                            },
                          ),
                        ],
                      ),
                      verticalSpace(spaceSize),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => viewModel.clearTags(),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      ),
                                ),
                              ),
                              child: Text(
                                'Clear',
                                style: globalTextStyle(
                                    fontSize: textFontSize * 0.875,
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.w500,
                                    color: kcBlackColor),
                              ),
                            ),
                          ),
                          horizontalSpaceLarge,
                          horizontalSpaceMedium,
                          Flexible(
                            child: Container(
                              height: buttonHeight,
                              width: buttonWidth,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  color: filterIconColor),
                              child: TextButton(
                                onPressed: () {
                                  viewModel.totalFilters =
                                      viewModel.tagTabSelections.length;
                                  viewModel.tagsIconSelected();
                                  viewModel.showAllMarkersWithTags();
                                },
                                child: Text(
                                  'Apply Filter',
                                  style: globalTextStyle(
                                      fontSize: textFontSize,
                                      letterSpacing: -0.5,
                                      color: kcwhitecolor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
