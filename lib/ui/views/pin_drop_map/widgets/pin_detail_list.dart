import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/ui/dialogs/pindrop_dialoguebox/widgets/shimmer.dart';
import 'package:sailing_chefs/ui/views/Messages/chat_viewmodel.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_viewmodel.dart';

class PinDetailList extends ViewModelWidget<PinDropMapViewModel> {
  const PinDetailList({super.key});

  @override
  Widget build(BuildContext context, PinDropMapViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.filteredPins.isEmpty
          ? viewModel.pins.length
          : viewModel.filteredPins.length,
      itemBuilder: (context, index) {
        final pin = viewModel.filteredPins.isEmpty
            ? viewModel.pins[index]
            : viewModel.filteredPins[index];

        final imageUrl = pin.picture.isNotEmpty ? pin.picture[0] : '';

        return GestureDetector(
          onTap: () => viewModel.callDetailsDialog(pin),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;
              final cardHeight = screenHeight * 0.18;
              final imageWidth = screenWidth * 0.26;

              return Container(
                height: cardHeight,
                width: screenWidth * 0.8,
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  color: kcWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: viewModel.isBusy
                    ? const ShimmerDialog()
                    : Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image section with fixed proportions
                              SizedBox(
                                width: imageWidth,
                                height: cardHeight,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(27),
                                    bottomLeft: Radius.circular(27),
                                  ),
                                  child: ImageUtils.networkImageWithFallback(
                                    imageUrl: imageUrl,
                                    width: imageWidth,
                                    height: cardHeight,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(27),
                                      bottomLeft: Radius.circular(27),
                                    ),
                                  ),
                                ),
                              ),
                              // Content section
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Rating
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: kclightgreencolor,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            viewModel.calculateAverageRating(
                                              pin.reviews ?? [],
                                            ),
                                            style: globalTextStyle(
                                              color: kcBlackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      // Name and Place
                                      Text(
                                        pin.name,
                                        style: globalTextStyle(
                                          color: kcBlackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        pin.place,
                                        style: globalTextStyle(
                                          color: kcBlackColor.withOpacity(0.4),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if ([
                            PinnedLocationStatus.pending,
                            PinnedLocationStatus.review
                          ].contains(pin.status))
                            Positioned(
                              right: 8.dg,
                              top: 8.dg,
                              child: Container(
                                height: 25.h,
                                padding:
                                    EdgeInsets.only(left: 10.dg, right: 10.dg),
                                decoration: BoxDecoration(
                                  color:
                                      pin.status == PinnedLocationStatus.pending
                                          ? Colors.yellow
                                          : Colors.orange,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.r),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      pin.status.name.capitalizeFirst(),
                                      maxLines: 1,
                                      style: globalTextStyle(
                                          fontSize: 10.sp, color: kcBlackColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
              );
            },
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
    );
  }
}
