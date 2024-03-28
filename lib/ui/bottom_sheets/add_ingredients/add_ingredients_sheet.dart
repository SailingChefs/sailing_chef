import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';
import 'package:sailing_chefs/ui/widgets/common_textfield.dart';
import 'package:sailing_chefs/ui/widgets/two_textfields_inarow.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'add_ingredients_sheet_model.dart';

class AddIngredientsSheet extends StackedView<AddIngredientsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AddIngredientsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddIngredientsSheetModel viewModel,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    onTap: (){
                      
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
                request.title ?? 'Add your ingredients',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            verticalSpaceMedium,
            SizedBox(
              width: double.infinity,
              child: CommonTextField(
                hintText: 'Add one or multiple steps',
                prefix: Icons.drag_indicator,
              ),
            ),
            verticalSpaceTiny,
            const TwoTextFields(),
            verticalSpaceSmall,
            SizedBox(
              width: double.infinity,
              child: CommonTextField(
                hintText: 'Add one or multiple steps',
                prefix: Icons.drag_indicator,
              ),
            ),
            const TwoTextFields(),
            Custom_BottomSheet_Buton(
              onPressed: () {},
              buttonText: 'Ingredients ',
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
  AddIngredientsSheetModel viewModelBuilder(BuildContext context) =>
      AddIngredientsSheetModel();
}
