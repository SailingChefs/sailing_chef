import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/dialogs/reviews_all/reviews_all_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReviewsAllDialog extends StackedView<ReviewsAllDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ReviewsAllDialog({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    ReviewsAllDialogModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            insetPadding: const EdgeInsets.only(left: 33, right: 33, bottom: 140, top: 25),
            backgroundColor: Colors.white,
            child: SizedBox(
              width: 365,
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 19.0, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: () => completer(DialogResponse(confirmed: true)),
                          child: Icon(Icons.close, size: 17, color: kcBlackColor.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19.0, left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              viewModel.isEditingReview
                                  ? 'Edit Review'
                                  : viewModel.isAddingReview
                                      ? 'Add Review'
                                      : 'Reviews',
                              style: globalTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kcBlackColor,
                              ),
                            ),
                            if (viewModel.isEditingReview || viewModel.isAddingReview)
                              TextButton(
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  if (viewModel.isEditingReview) {
                                    viewModel.cancelEdit();
                                  } else {
                                    viewModel.cancelAddingReview();
                                  }
                                },
                                child: Text(
                                  'Cancel',
                                  style: globalTextStyle(
                                    fontSize: 14,
                                    color: kcBlackColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      verticalSpaceTiny,

                      // Review form interface (both for edit and add)
                      if (viewModel.isEditingReview || viewModel.isAddingReview)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Review',
                                style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: kcBlackColor,
                                ),
                              ),
                              verticalSpaceTiny,
                              TextField(
                                controller: viewModel.feedbackController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Enter your review here',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              verticalSpaceSmall,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rating:',
                                    style: globalTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => IconButton(
                                        icon: Icon(
                                          index < viewModel.currentRating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: kclightgreencolor,
                                        ),
                                        onPressed: () {
                                          viewModel.currentRating = index + 1;
                                          viewModel.notifyListeners();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpaceSmall,
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    HapticFeedback.mediumImpact();
                                    if (viewModel.isEditingReview) {
                                      viewModel.saveEditedReview();
                                    } else {
                                      viewModel.addNewReview();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kcPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    viewModel.isEditingReview ? 'Save Changes' : 'Add Review',
                                    style: globalTextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        SizedBox(
                          height: 280,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewModel.reviews.length,
                            itemBuilder: (context, index) {
                              final isUserReview = viewModel.isUserReview(viewModel.reviews[index]);
                              return ListTile(
                                contentPadding: const EdgeInsets.only(left: 5.0, right: 5),
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: viewModel.reviews[index].userImageUrl.isEmpty
                                      ? const AssetImage('assets/images/default_location.png')
                                      : NetworkImage(viewModel.reviews[index].userImageUrl)
                                          as ImageProvider,
                                ),
                                title: Text(
                                  viewModel.reviews[index].userName,
                                  style: globalTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: kcBlackColor,
                                  ),
                                ),
                                subtitle: Text(
                                  viewModel.reviews[index].feedback!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: globalTextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: kcBlackColor,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: isUserReview ? 130 : 80,
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Rating display
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 15,
                                            color: kclightgreencolor,
                                          ),
                                          horizontalSpaceSmall,
                                          Text(
                                            viewModel.reviews[index].rating?.toString() ??
                                                'No rating',
                                            style: globalTextStyle(
                                              color: kcBlackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Edit and delete buttons for user's own reviews
                                      if (isUserReview) ...[
                                        horizontalSpaceTiny,
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 16,
                                              color: kcPrimaryColor,
                                            ),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            splashRadius: 18,
                                            onPressed: () {
                                              HapticFeedback.mediumImpact();
                                              viewModel.editReview(viewModel.reviews[index]);
                                            },
                                            tooltip: 'Edit Review',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 16,
                                              color: Colors.red,
                                            ),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            splashRadius: 18,
                                            onPressed: () {
                                              HapticFeedback.mediumImpact();
                                              viewModel.deleteReview(viewModel.reviews[index]);
                                            },
                                            tooltip: 'Delete Review',
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                  if (!viewModel.isEditingReview && !viewModel.isAddingReview)
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        viewModel.startAddingReview();
                      },
                      child: Center(
                        child: DecoratedBox(
                          decoration: const UnderlineTabIndicator(
                              borderSide: BorderSide(color: kcPrimaryColor)),
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
                    ),
                  verticalSpaceSmall,
                ],
              ),
            ),
          );
  }

  @override
  void onViewModelReady(ReviewsAllDialogModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.onViewModelReady();
  }

  @override
  ReviewsAllDialogModel viewModelBuilder(BuildContext context) => ReviewsAllDialogModel(
      pinnedLocation: request.data as PinnedLocation,
      placeMark: request.title ?? 'No title provided');
}
