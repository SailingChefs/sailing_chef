import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

import 'rate_experience_dialog_model.dart';

class RateExperienceDialog extends StackedView<RateExperienceDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const RateExperienceDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RateExperienceDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetPadding: const EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 255,
        width: 340,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  GestureDetector(
                    onTap: () => completer(DialogResponse(confirmed: true)),
                    child: Icon(Icons.close,
                        size: 17, color: kcBlackColor.withOpacity(0.8)),
                  ),
                ],
              ),
              Text(
                'Rate your experience',
                style: globalTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor,
                ),
              ),
              verticalSpaceSmall,
              RatingBar.builder(
                direction: Axis.horizontal,
                allowHalfRating: true,
                initialRating: viewModel.ratings,
                itemSize: 30,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: kcPrimaryColor,
                ),
                onRatingUpdate: (double value) {
                  viewModel.setRating(value);
                },
              ),
              verticalSpaceMedium,
              SemiRoundedTranpaentTextField(
                controller: viewModel.reviewController,
                labelText: 'Leave a comment...',
                borderRadius: 30.dg,
                suffixIcon: false,
              ),
              verticalSpaceMedium,
              Center(
                child: GestureDetector(
                  onTap: () {
                    viewModel.saveReviewData();
                    completer(DialogResponse(confirmed: true));
                    viewModel.showAllRatings();
                  },
                  child: Container(
                    width: 144,
                    height: 45,
                    decoration: BoxDecoration(
                        color: kcPrimaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        'Submit Review',
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
  RateExperienceDialogModel viewModelBuilder(BuildContext context) =>
      RateExperienceDialogModel(
          pinnedLocation: request.data as PinnedLocation,
          placeMark: request.title.toString());
}
