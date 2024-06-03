import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/dialogs/pindrop_dialoguebox/widgets/shimmer.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';

class PinDetailList extends ViewModelWidget<PinDropMapViewModel> {
  const PinDetailList({super.key});

  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return ListView.builder(
      itemBuilder: (context, index) {
        log('pins length ${viewModel.pins.last.picture.length}');
        final pin = viewModel.filteredPins.isEmpty
            ? viewModel.pins[index]
            : viewModel.filteredPins[index];

        //  int actualIndex = (index + viewModel.startIndex) % viewModel.pins.length.toInt();
        return GestureDetector(
          onTap: () => viewModel.callDetailsDialog(viewModel.pins[index]),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(27),
              color: kcWhiteColor,
            ),
            child: viewModel.isBusy
                ? const ShimmerDialog()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(27),
                              bottomLeft: Radius.circular(27)),
                          child: Image.network(
                            pin.picture.first,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 0.26,
                          ),
                        ),
                      ),
                      horizontalSpaceTiny,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      pin.tags[0],
                                      style: globalTextStyle(
                                        color: kcBlackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  horizontalSpaceMedium,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: kclightgreencolor,
                                        ),
                                        horizontalSpaceSmall,
                                        Text(
                                          viewModel
                                                      .calculateAverageRating(
                                                          pin.reviews ?? [])
                                                      .toString() ==
                                                  '0.0'
                                              ? pin.rating.toString()
                                              : viewModel
                                                  .calculateAverageRating(
                                                      pin.reviews ?? [])
                                                  .toString(),
                                          style: globalTextStyle(
                                            color: kcBlackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                // padding: const EdgeInsets.only(left: 8, top: 6),
                                width: 230,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        pin.name,
                                        style: globalTextStyle(
                                          color: kcBlackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      pin.place,
                                      overflow: TextOverflow.ellipsis,
                                      style: globalTextStyle(
                                        color: kcBlackColor.withOpacity(0.4),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: viewModel.filteredPins.isEmpty
          ? viewModel.pins.length
          : viewModel.filteredPins.length,
      shrinkWrap: true,
    );
  }
}
