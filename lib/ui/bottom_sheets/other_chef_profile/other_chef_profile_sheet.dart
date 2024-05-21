import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'other_chef_profile_sheet_model.dart';

class OtherChefProfileSheet extends StackedView<OtherChefProfileSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const OtherChefProfileSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OtherChefProfileSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: kcWhiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => completer!(SheetResponse(
                      confirmed: true,
                    )),
                    child: Container(
                      height: 55,
                      decoration: const BoxDecoration(
                        color: kcWhiteColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text('Report Profile',
                            style: globalTextStyle(
                                fontSize: 16.sp,
                                letterSpacing: -0.3,
                                fontWeight: FontWeight.w500,
                                color: kcBlackColor)),
                      ),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () => viewModel.blockAccount(request.data),
                    child: Container(
                      height: 55,
                      decoration: const BoxDecoration(
                        color: kcWhiteColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text('Block Profile',
                            style: globalTextStyle(
                                fontSize: 16.sp,
                                letterSpacing: -0.3,
                                fontWeight: FontWeight.w500,
                                color: kcBlackColor)),
                      ),
                    ),
                  ),
                ]),
          ),
          verticalSpaceMedium,
          GestureDetector(
            onTap: () => completer!(SheetResponse(
              confirmed: true,
            )),
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: kcWhiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text('Cancel',
                    style: globalTextStyle(
                        fontSize: 16.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w500,
                        color: kcErrorColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  OtherChefProfileSheetModel viewModelBuilder(BuildContext context) =>
      OtherChefProfileSheetModel();
}
