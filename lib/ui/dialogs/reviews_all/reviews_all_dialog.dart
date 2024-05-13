import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'reviews_all_dialog_model.dart';


class ReviewsAllDialog extends StackedView<ReviewsAllDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ReviewsAllDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ReviewsAllDialogModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            insetPadding: const EdgeInsets.only(
                left: 33, right: 33, bottom: 140, top: 25),
            backgroundColor: Colors.white,
            child: SizedBox(
              width: 365,
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 19.0, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: () =>
                              completer(DialogResponse(confirmed: true)),
                          child: Icon(Icons.close,
                              size: 17, color: kcBlackColor.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 19.0, left: 15, right: 15),
                        child: Text(
                          'Reviews',
                          style: globalTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor,
                          ),
                        ),
                      ),
                      verticalSpaceTiny,
                      SizedBox(
                        height: 280,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.reviews.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 5.0, right: 5),
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  viewModel.reviews[index].userImageUrl,
                                ),
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
                                width: 80,
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 26.0, right: 5),
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
                                          viewModel.reviews[index].rating
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Container(
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
  ReviewsAllDialogModel viewModelBuilder(BuildContext context) =>
      ReviewsAllDialogModel(
          pinnedLocation: request.data as PinnedLocation,
          placeMark: request.title.toString());
}
