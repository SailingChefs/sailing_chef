import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/widgets/selectedtab.dart';

class TagsSelectionWidget extends ViewModelWidget<PinDropMapViewModel> {
  const TagsSelectionWidget({
    required this.id,
    Key? key,
  }) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 130),
      child: Container(
        decoration: BoxDecoration(
            color: kcwhitecolor,
            borderRadius: BorderRadius.circular(27.0.dg),
            boxShadow: [
              BoxShadow(
                color: kcsgreycolor.withOpacity(0.5),
                spreadRadius: 5,
              )
            ]),
        width: 400.w,
        height: 435.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
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
                        fontSize: 18.0.dg,
                        color: kcBlackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.tagsIconSelected();
                    },
                    child: Icon(Icons.close,
                        color: kcBlackColor.withOpacity(0.87), size: 24.0.dg),
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
              verticalSpaceLarge,
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                GestureDetector(
                  onTap: () => viewModel.clearTags(),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: kcBlackColor),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Clear',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                horizontalSpaceLarge,
                horizontalSpaceMedium,
                Flexible(
                  child: Container(
                    height: 45,
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kcPrimaryColor),
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
                            fontSize: 14,
                            color: kcwhitecolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
