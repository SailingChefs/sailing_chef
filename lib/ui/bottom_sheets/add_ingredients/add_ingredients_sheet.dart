
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/quantity_measurment_input.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      decoration: const BoxDecoration(
        color: kcwhitecolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
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
                        completer!(SheetResponse(confirmed: false));
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                   completer!(SheetResponse(
                    confirmed: true,
                  ));
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
              const Center(
                child: Text(
                  'Add your ingredients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              verticalSpaceMedium,
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.3,
                child: ListView(children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.drag_indicator_outlined,
                            color: kcBlackColor.withOpacity(0.4),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            height: MediaQuery.sizeOf(context).height * 0.06,
                            child: RoundedTransparentTextField(
                              textColor: kcBlackColor.withOpacity(0.5),
                              labelText: 'Add one or multiple steps',
                               controller: viewModel.ingredientsController,
                              
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceTiny,
                      const QuantityMeasurmentInput(),
                    ],
                  ),
                ]),
              ),
              Custom_BottomSheet_Buton(
                onPressed: () {},
                buttonText: 'Ingredients ',
                prefix: Icons.add,
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  @override
  AddIngredientsSheetModel viewModelBuilder(BuildContext context) =>
      AddIngredientsSheetModel();
}
