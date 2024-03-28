import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/dialogs/save_draft_alertbox/save_draft_alertbox_dialog.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

import 'cooking_instructions_sheet_model.dart';

class CookingInstructionsSheet
    extends StackedView<CookingInstructionsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CookingInstructionsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CookingInstructionsSheetModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        decoration: const BoxDecoration(
          color: kcwhitecolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackArrowWidget(
                    onTap: () {
                      viewModel.popBack();
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.saveData();
                    },
                    child: Text(
                      'Save',
                      style: globalTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: kcPrimaryColor.withOpacity(0.5)),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                request.title ?? 'Cooking Instructions',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            verticalSpaceMedium,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step 1',
                    style: TextStyle(
                        fontSize: 16, color: kcDarkColor.withOpacity(0.4)),
                  ),
                  verticalSpaceTiny,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                          color: kcVeryLightGrey.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Row(
                          children: [
                            horizontalSpaceSmall,
                            SizedBox(
                              width: 270.w,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Firstly, in a large tawa heat 1 tsp butter and saute 2 tbsp onion. Also, add 1 cup spinach and saute for 2 minutes or until spinach shrinks.',
                                  style: globalTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kcBlackColor.withOpacity(0.5)),
                                ),
                              ),
                            ),
                            horizontalSpaceSmall,
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_outline_sharp,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 55),
              child: const SizedBox(
                width: double.infinity,
                child: SemiRoundedTranpaentTextField(
                  labelText: '+ Add one or multiple steps',
                ),
              ),
            ),
            Custom_BottomSheet_Buton(
              onPressed: () {},
              buttonText: 'Add setp',
              prefix: Icons.add,
            ),
            if (request.description != null) ...[
              verticalSpaceTiny,
              Text(
                request.description!,
                style: const TextStyle(fontSize: 14, color: kcMediumGrey),
                maxLines: 3,
                softWrap: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  CookingInstructionsSheetModel viewModelBuilder(BuildContext context) =>
      CookingInstructionsSheetModel();
}
