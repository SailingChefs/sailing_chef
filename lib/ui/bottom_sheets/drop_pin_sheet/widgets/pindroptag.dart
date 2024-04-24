import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/drop_pin_sheet_sheet_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/selectedwidget.dart';

// class Tags extends ViewModelWidget<DropPinSheetSheetModel> {
//   const Tags({super.key});

//   @override
//   Widget build(BuildContext context, DropPinSheetSheetModel viewModel) {
//     return Column(
//       children: [
//          Text(
//           'Select one or more',
//           style: globalTextStyle(
//               fontSize: 18.0.dg,
//               color: kcBlackColor,
//               fontWeight: FontWeight.w500),
//         ),
//         verticalSpaceSmall,
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SelectedWidgetPinDrop(selectedTabSelection: 'Provisioner', index: 0, selection: () { viewModel.provionerSelected(); },),
//             verticalSpaceMedium,
//             SelectedWidgetPinDrop(selectedTabSelection: 'Supermarket', index: 1, selection: () { viewModel.supermarketSelected(); },),
//             verticalSpaceMedium,
//             SelectedWidgetPinDrop(selectedTabSelection: 'Deliverables ', index: 2, selection: () { viewModel.deliverablesSelected(); },),
//             verticalSpaceMedium,
//             SelectedWidgetPinDrop(selectedTabSelection: 'Fresh market', index: 3, selection: () { viewModel.freshmarketSelected(); },),
//             verticalSpaceMedium,
//           ]
//         )
//       ],
//     );
//   }
// }

class TagsSelectionWidget extends ViewModelWidget<DropPinSheetSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const TagsSelectionWidget({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, DropPinSheetSheetModel viewModel) {
    return SizedBox(
      width: 400,
      height: viewModel.isTagsVisible == true ? 405 : 65,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              viewModel.toggleTagsVisibility();
            },
            child: SizedBox(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      viewModel.selectedTabSelections.isEmpty
                          ? 'Tags'
                          : viewModel.selectedTabSelections.join(', '),
                      overflow: TextOverflow.ellipsis,
                      style: viewModel.selectedTabSelections.isEmpty
                          ? globalTextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: kcBlackColor.withOpacity(0.6))
                          : globalTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: kcBlackColor.withOpacity(0.8),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      viewModel.isTagsVisible == true
                          ? FlutterRemix.arrow_up_s_line
                          : FlutterRemix.arrow_down_s_line,
                      size: 25,
                      color: kcBlackColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Container(
            height: viewModel.isTagsVisible == true ? 340 : 0,
            width: viewModel.isTagsVisible == true ? 398 : 0,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Visibility(
              visible: viewModel.isTagsVisible,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceSmall,
                  Text(
                    'Select one or more',
                    style: globalTextStyle(
                        fontSize: 18.0.dg,
                        color: kcBlackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  verticalSpaceSmall,
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: [
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Provisioner',
                        index: 0,
                        selection: () {
                          viewModel.handleTabSelection('Provisioner');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Supermarket',
                        index: 1,
                        selection: () {
                          viewModel.handleTabSelection('Supermarket');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Deliverables',
                        index: 2,
                        selection: () {
                          viewModel.handleTabSelection('Supermarket');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Fresh market',
                        index: 3,
                        selection: () {
                          viewModel.handleTabSelection('Fresh market');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Fishmonger',
                        index: 4,
                        selection: () {
                          viewModel.handleTabSelection('Fishmonger');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Butchery',
                        index: 5,
                        selection: () {
                          viewModel.handleTabSelection('Butchery');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Bakery/Patisserie',
                        index: 6,
                        selection: () {
                          viewModel.handleTabSelection('Bakery/Patisserie');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Cakes',
                        index: 7,
                        selection: () {
                          viewModel.handleTabSelection('Cakes');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Special dietary',
                        index: 8,
                        selection: () {
                          viewModel.handleTabSelection('Special dietary');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Culinary store',
                        index: 9,
                        selection: () {
                          viewModel.handleTabSelection('Culinary store');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Florist',
                        index: 10,
                        selection: () {
                          viewModel.handleTabSelection('Florist');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Farm',
                        index: 11,
                        selection: () {
                          viewModel.handleTabSelection('Farm');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Liquor',
                        index: 12,
                        selection: () {
                          viewModel.handleTabSelection('Liquor');
                        },
                      ),
                      SelectedWidgetPinDrop(
                        selectedTabSelection: 'Restaurant',
                        index: 13,
                        selection: () {
                          viewModel.handleTabSelection('Restaurant');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
