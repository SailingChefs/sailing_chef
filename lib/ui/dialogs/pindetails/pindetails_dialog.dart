import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/ui/dialogs/pindetails/pindetails_dialog_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PindetailsDialog extends StackedView<PindetailsDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PindetailsDialog({
    required this.request, required this.completer, super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    PindetailsDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      alignment: Alignment.topCenter,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      insetPadding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      backgroundColor: kcwhitecolor,
      child: viewModel.isBusy
          ? SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Center(
                child: CircularProgressIndicator(
                  color: kcPrimaryColor,
                ),
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 210,
                          width: 400,
                          child: viewModel.pinnedLocation.picture.isNotEmpty
                              ? Stack(
                                  children: [
                                    PageView.builder(
                                      itemCount: viewModel
                                          .pinnedLocation.picture.length
                                          .clamp(1, 20),
                                      controller: viewModel.pageController,
                                      itemBuilder: (context, index) {
                                        // Ensure index is within bounds
                                        if (index >=
                                            viewModel.pinnedLocation.picture
                                                .length) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                              color: Colors.grey[300],
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                  Icons.image_not_supported),
                                            ),
                                          );
                                        }

                                        final media = viewModel
                                            .pinnedLocation.picture[index];

                                        return ImageUtils
                                            .networkImageWithFallback(
                                          imageUrl: media,
                                          width: 400,
                                          height: 210,
                                          borderRadius:
                                              BorderRadius.circular(27),
                                        );
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: viewModel.pinnedLocation
                                                  .picture.isNotEmpty
                                              ? SmoothPageIndicator(
                                                  controller:
                                                      viewModel.pageController,
                                                  count: viewModel
                                                      .pinnedLocation
                                                      .picture
                                                      .length
                                                      .clamp(1,
                                                          20), // Clamp to reasonable range
                                                  effect: WormEffect(
                                                    spacing: 5.0,
                                                    radius: 5.0,
                                                    dotWidth: 10.0,
                                                    dotHeight: 10.0,
                                                    dotColor: kcwhitecolor
                                                        .withOpacity(0.5),
                                                    activeDotColor:
                                                        kcwhitecolor,
                                                  ),
                                                )
                                              : const SizedBox
                                                  .shrink(), // Hide indicator if no pictures
                                        ),
                                        verticalSpaceSmall
                                      ],
                                    ),
                                  ],
                                )
                              : DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(27),
                                    color: Colors.grey[300],
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.image_not_supported,
                                            size: 48),
                                        SizedBox(height: 8),
                                        Text('No images available'),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: GestureDetector(
                            onTap: () =>
                                completer(DialogResponse(confirmed: true)),
                            child: const Icon(Icons.close, color: kcBlackColor),
                          ),
                        ),
                        // viewModel.pinnedLocation.uid == userDetails!.uid
                        //     ? Positioned(
                        //         top: 20,
                        //         left: 20,
                        //         child: GestureDetector(
                        //           onTap: () {
                        //             completer(DialogResponse(confirmed: true));
                        //             viewModel.navigateToBottomSheet();
                        //           },
                        //           child: const Icon(Icons.edit_outlined,
                        //               color: kcBlackColor),
                        //         ),
                        //       )
                        //     : const Positioned(
                        //         top: 20,
                        //         left: 20,
                        //         child: Icon(Icons.edit_off_outlined,
                        //             color: kcBlackColor),
                        //       )
                      ],
                    ),
                    verticalSpaceSmall,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                capitalizeEachWord(
                                    viewModel.pinnedLocation.name),
                                style: globalTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: kcBlackColor,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: FittedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 15,
                                          color: kclightgreencolor,
                                        ),
                                        horizontalSpaceSmall,
                                        Text(
                                          viewModel
                                                      .calculateAverageRating(
                                                          viewModel.reviews)
                                                       ==
                                                  '0.0'
                                              ? viewModel.pinnedLocation.rating
                                                  .toString()
                                              : viewModel
                                                  .calculateAverageRating(
                                                      viewModel.reviews)
                                                  ,
                                          style: globalTextStyle(
                                            color: kcBlackColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    viewModel.tags!.join(', '),
                                    style: globalTextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: kcBlackColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  viewModel.showReviews();
                                },
                                child: DecoratedBox(
                                  decoration: const UnderlineTabIndicator(
                                      borderSide:
                                          BorderSide(color: kcPrimaryColor)),
                                  child: Row(
                                    children: [
                                      Text(
                                        'See all reviews',
                                        style: globalTextStyle(
                                          color: kcBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        size: 16,
                                        color: kcBlackColor.withOpacity(0.8),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Company Contact Information Section
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Information',
                            style: globalTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kcBlackColor,
                            ),
                          ),
                          verticalSpaceSmall,
                          // Contact Number
                          if (viewModel
                              .pinnedLocation.contactNumber.isNotEmpty) ...[
                            Row(
                              children: [
                                const Icon(Icons.phone,
                                    size: 16, color: kcPrimaryColor),
                                horizontalSpaceSmall,
                                Text(
                                  viewModel.pinnedLocation.contactNumber,
                                  style: globalTextStyle(
                                    color: kcBlackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpaceTiny,
                          ],
                          // Email
                          if (viewModel.pinnedLocation.email.isNotEmpty) ...[
                            Row(
                              children: [
                                const Icon(Icons.email,
                                    size: 16, color: kcPrimaryColor),
                                horizontalSpaceSmall,
                                Expanded(
                                  child: Text(
                                    viewModel.pinnedLocation.email,
                                    style: globalTextStyle(
                                      color: kcBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpaceTiny,
                          ],
                          // Website Link
                          if (viewModel.pinnedLocation.link.isNotEmpty) ...[
                            Row(
                              children: [
                                const Icon(Icons.link,
                                    size: 16, color: kcPrimaryColor),
                                horizontalSpaceSmall,
                                Expanded(
                                  child: Text(
                                    viewModel.pinnedLocation.link,
                                    style: globalTextStyle(
                                      color: kcPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpaceTiny,
                          ],
                          // Location
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 16, color: kcPrimaryColor),
                              horizontalSpaceSmall,
                              Expanded(
                                child: Text(
                                  viewModel.placeMark,
                                  style: globalTextStyle(
                                    color: kcBlackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Description Section
                    if (viewModel.pinnedLocation.description.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About',
                              style: globalTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kcBlackColor,
                              ),
                            ),
                            verticalSpaceSmall,
                            Text(
                              viewModel.pinnedLocation.description,
                              style: globalTextStyle(
                                color: kcBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    verticalSpaceMedium,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              viewModel.openGoogleMaps();
                            },
                            child: Container(
                              width: 144,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: kcPrimaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  'Get directions',
                                  style: globalTextStyle(
                                    color: kcwhitecolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              viewModel.editPin();
                            },
                            child: Container(
                              width: 144,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: kcPrimaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  'Edit',
                                  style: globalTextStyle(
                                    color: kcwhitecolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceSmall,
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void onViewModelReady(PindetailsDialogModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  PindetailsDialogModel viewModelBuilder(BuildContext context) =>
      PindetailsDialogModel(
          pinnedLocation: request.data as PinnedLocation,
          placeMark: request.title.toString());
}
