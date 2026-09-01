import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/ui/dialogs/pindrop_dialoguebox/widgets/shimmer.dart';

import 'pindrop_dialoguebox_dialog_model.dart';

class PindropDialogueboxDialog
    extends StackedView<PindropDialogueboxDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PindropDialogueboxDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PindropDialogueboxDialogModel viewModel,
    Widget? child,
  ) {
    final PinnedLocation pinnedLocation = viewModel.pinnedLocation;

    return GestureDetector(
      onTap: () {
        viewModel.callDeatilsDialog();
      },
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
        alignment: Alignment.bottomRight,
        backgroundColor: kcWhiteColor,
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
                        pinnedLocation.picture.first,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width * 0.26,
                      ),
                    ),
                  ),
                  horizontalSpaceTiny,
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 15),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                pinnedLocation.tags[0],
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
                                    color: kcPrimaryColor,
                                  ),
                                  horizontalSpaceSmall,
                                  Text(
                                    viewModel
                                                .calculateAverageRating(
                                                    viewModel.reviews)
                                                .toString() ==
                                            '0.0'
                                        ? pinnedLocation.rating.toString()
                                        : viewModel
                                            .calculateAverageRating(
                                                viewModel.reviews)
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
                        Container(
                          padding: const EdgeInsets.only(left: 8, top: 6),
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  pinnedLocation.name,
                                  style: globalTextStyle(
                                    color: kcBlackColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                viewModel.placeMark,
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
                ],
              ),
      ),
    );
  }

  @override
  void onViewModelReady(PindropDialogueboxDialogModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  PindropDialogueboxDialogModel viewModelBuilder(BuildContext context) {
    log("${request.data}");

    return PindropDialogueboxDialogModel(
      pinnedLocation: request.data,
      placeMark: request.title.toString(),
      // curLat: request.additionalButtonTitle!,
      // curLong: request.description!
    );
  }
}
