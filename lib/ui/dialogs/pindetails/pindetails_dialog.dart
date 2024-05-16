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
      backgroundColor: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 490,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 210,
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemCount: viewModel.pinnedLocation.picture.length,
                        controller: viewModel.pageController,
                        itemBuilder: (context, index) {
                          var media = viewModel.pinnedLocation.picture[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(27),
                            child: Image.network(
                              media,
                              height: 210,
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
                                    count:
                                        viewModel.pinnedLocation.picture.length,
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
                                verticalSpaceSmall,
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
                          child:
                              const Icon(Icons.close, color: kcchatboxecolor),
                        ),
                      )
                    ],
                  ),

                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => completer(DialogResponse(confirmed: true)),
                    child: const Icon(Icons.close, color: kcchatboxecolor),
                  ),
                )
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
                        capitalizeEachWord(viewModel.pinnedLocation.name),
                        style: globalTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kcBlackColor,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 15,
                                color: kclightgreencolor,

                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 230,
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
                  Padding(
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
                  Padding(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 10),
                    child: Text(
                      viewModel.pinnedLocation.description,
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
                ],
              ),
      ),
    );
  }

  @override
  void onViewModelReady(PindetailsDialogModel viewModel) {
    viewModel.onViewModelReady();
  }

  @override
  PindetailsDialogModel viewModelBuilder(BuildContext context) =>
      PindetailsDialogModel(
          pinnedLocation: request.data as PinnedLocation,
          placeMark: request.title.toString());
}
