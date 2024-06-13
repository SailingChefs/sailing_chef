import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'pindetails_dialog_model.dart';

class PindetailsDialog extends StackedView<PindetailsDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PindetailsDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

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
                          child: Stack(
                            children: [
                              PageView.builder(
                                itemCount:
                                    viewModel.pinnedLocation.picture.length,
                                controller: viewModel.pageController,
                                itemBuilder: (context, index) {
                                  var media =
                                      viewModel.pinnedLocation.picture[index];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(27),
                                    child: Image.network(
                                      media,
                                      height: 210,
                                      width: 400,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SmoothPageIndicator(
                                      controller: viewModel.pageController,
                                      count: viewModel
                                          .pinnedLocation.picture.length,
                                      axisDirection: Axis.horizontal,
                                      effect: WormEffect(
                                        spacing: 5.0,
                                        radius: 5.0,
                                        dotWidth: 10.0,
                                        dotHeight: 10.0,
                                        strokeWidth: 1,
                                        dotColor: kcwhitecolor.withOpacity(0.5),
                                        activeDotColor: kcwhitecolor,
                                      ),
                                    ),
                                  ),
                                  verticalSpaceSmall
                                ],
                              ),
                            ],
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
                                                      .toString() ==
                                                  '0.0'
                                              ? viewModel.pinnedLocation.rating
                                                  .toString()
                                              : viewModel
                                                  .calculateAverageRating(
                                                      viewModel.reviews)
                                                  .toString(),
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
                              SizedBox(
                                width: 239,
                                child: Text(
                                  viewModel.tags!.join(', '),
                                  style: globalTextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: kcBlackColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  viewModel.showRatingsExperience();
                                },
                                child: Container(
                                  decoration: const UnderlineTabIndicator(
                                      borderSide:
                                          BorderSide(color: kcPrimaryColor)),
                                  child: Text(
                                    'Add review',
                                    style: globalTextStyle(
                                      color: kcBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    viewModel.pinnedLocation.contactNumber.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 10),
                            child: Text(
                              viewModel.pinnedLocation.contactNumber,
                              style: globalTextStyle(
                                color: kcBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                    viewModel.pinnedLocation.email.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              viewModel.pinnedLocation.email,
                              style: globalTextStyle(
                                color: kcBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                    viewModel.pinnedLocation.description.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 10, right: 15),
                            child: Text(
                              viewModel.pinnedLocation.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: globalTextStyle(
                                color: kcBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                    verticalSpaceMedium,
                    Center(
                      child: GestureDetector(
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
