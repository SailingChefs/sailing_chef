// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/helpers/checkdatatype.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/buttons.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/link_textfield.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/pindroptag.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/textfield_droppin.dart';

import 'drop_pin_sheet_sheet_model.dart';

class DropPinSheetSheet extends StackedView<DropPinSheetSheetModel> {
  final Function(SheetResponse response)? completer;
  final bool isNew;
  final SheetRequest request;

  const DropPinSheetSheet(
      {Key? key,
      required this.completer,
      required this.request,
      required this.isNew})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DropPinSheetSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
      ),
      decoration: const BoxDecoration(
        color: kcWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16.w, right: 16.w),
        child: Container(
          decoration: const BoxDecoration(
              color: kcWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )),
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20),
                  DopPinTextFields(
                    func: () {
                      viewModel.getPfpImage();
                    },
                    hinttext: 'Name',
                    suffixIcon: SvgPicture.asset(
                        'assets/images/icons/pinimage.svg',
                        width: 30,
                        height: 30,
                        color: kcBlackColor.withOpacity(0.87)),
                    color: kcBlackColor.withOpacity(0.6),
                    contoll: viewModel.name,
                  ),
                  const Divider(),
                  TagsSelectionWidget(
                    completer: completer,
                    request: request,
                  ),
                  verticalSpace(14.h),
                  DopPinTextFieldLink(
                    hinttext: 'Link*',
                    suffixIcon: FlutterRemix.link_m,
                    color: kcBlackColor.withOpacity(0.4),
                    controller: viewModel.link,
                  ),
                  const Divider(),
                  TextFormField(
                    controller: viewModel.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Contact Number*',
                        hintStyle: globalTextStyle(
                          fontSize: 14.sp,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w400,
                          color: kcBlackColor.withOpacity(0.4),
                        ),
                        border: InputBorder.none),
                  ),
                  const Divider(),
                  verticalSpaceTiny,
                  TextFormField(
                    controller: viewModel.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email*',
                      border: InputBorder.none,
                      hintStyle: globalTextStyle(
                        fontSize: 14.sp,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w400,
                        color: kcBlackColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                  const Divider(),
                  verticalSpaceTiny,
                  TextFormField(
                    controller: viewModel.description,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: InputBorder.none,
                      hintStyle: globalTextStyle(
                        fontSize: 14.sp,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w400,
                        color: kcBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const Divider(),
                  verticalSpaceLarge,
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add your Review',
                            style: globalTextStyle(
                              fontSize: 14.sp,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                              color: kcBlackColor.withOpacity(0.4),
                            ),
                          ),
                          RatingBar.builder(
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            initialRating: viewModel.ratings,
                            itemSize: 20,
                            unratedColor: Colors.grey.shade400,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.005),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: kcPrimaryColor,
                            ),
                            onRatingUpdate: (double value) {
                              viewModel.setRating(value);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  verticalSpaceLarge,
                  ButtonsPindrop(
                      completer: completer, isNew: request.data['isNew']),
                  verticalSpaceMedium,
                  // request.data != null
                  //     ? GestureDetector(
                  //         onTap: () {
                  //           completer!(SheetResponse(confirmed: true));
                  //           viewModel.deletePin();
                  //         },
                  //         child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Icon(
                  //                 FlutterRemix.delete_bin_6_line,
                  //                 color: kcBlackColor.withOpacity(0.6),
                  //                 size: 20,
                  //               ),
                  //               horizontalSpaceSmall,
                  //               Text(
                  //                 'Delete This Pin Drop',
                  //                 style: globalTextStyle(
                  //                     color: kcErrorColor,
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w500),
                  //               ),
                  //             ]),
                  //       )
                  //     : Container(),
                  // verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(DropPinSheetSheetModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  DropPinSheetSheetModel viewModelBuilder(BuildContext context) =>
      DropPinSheetSheetModel(
          completer, request.data['pinnedLocationData'] as PinnedLocationData,
          isNew: request.data['isNew']);
}
