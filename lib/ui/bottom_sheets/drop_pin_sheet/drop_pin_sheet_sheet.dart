// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/buttons.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/link_textfield.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/pindroptag.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/widgets/textfield_droppin.dart';

import 'drop_pin_sheet_sheet_model.dart';

class DropPinSheetSheet extends StackedView<DropPinSheetSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const DropPinSheetSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

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
        color: kcwhitecolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        child: Container(
          padding: const EdgeInsets.all(15.0),
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
                color: kcBlackColor.withOpacity(0.87)
              ),
                color: kcBlackColor.withOpacity(0.6),
                contoll: viewModel.name,
              ),
              const Divider(),
              TagsSelectionWidget(
                completer: completer,
                request: request,
              ),
              DopPinTextFieldLink(
                hinttext: 'Link*',
                suffixIcon: FlutterRemix.link_m,
                color: kcBlackColor.withOpacity(0.4),
                controller: viewModel.link,
              ),
              const Divider(),
              TextField(
                controller: viewModel.phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Contact Number*',
                    hintStyle: globalTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kcBlackColor.withOpacity(0.4),
                    ),
                    border: InputBorder.none),
              ),
              const Divider(),
              verticalSpaceTiny,
              TextField(
                controller: viewModel.email,
                decoration: InputDecoration(
                  hintText: 'Email*',
                  border: InputBorder.none,
                  hintStyle: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kcBlackColor.withOpacity(0.4),
                  ),
                ),
              ),
              const Divider(),
              verticalSpaceTiny,
              TextField(
                controller: viewModel.description,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: InputBorder.none,
                  hintStyle: globalTextStyle(
                    fontSize: 16,
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
                  padding: const EdgeInsets.only(left:20.0,right:20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add your Review',
                        style: globalTextStyle(
                          fontSize: 15,
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
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0.005),
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
              ButtonsPindrop(completer: completer),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }

  @override
  DropPinSheetSheetModel viewModelBuilder(BuildContext context) =>
      DropPinSheetSheetModel(location: request.data as LatLng);
}
