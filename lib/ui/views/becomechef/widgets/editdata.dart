import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/becomechef/becomechef_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class BecomeChefForm extends ViewModelWidget<BecomechefViewModel> {
  const BecomeChefForm({super.key});

  @override
  Widget build(BuildContext context, BecomechefViewModel viewModel) {
    bool islocationempty = true;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  
                  SemiRoundedTranpaentTextField(
                      validator: (value) => viewModel.validateLink(value),
                      controller: viewModel.linkController,
                      labelText: 'Link'),
                  verticalSpaceMedium,
                  SemiRoundedTranpaentTextField(
                      validator: (value) => viewModel.validateBoatName(value),
                      controller: viewModel.boatNameController,
                      labelText: 'Boat Name'),
                  verticalSpaceMedium,
                  GestureDetector(
                      onTap: viewModel.getLocation,
                      child: Container(
                        height: 45.h,
                        width: double.infinity,
                        decoration: islocationempty == false
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: Colors.red,
                                ),
                                color: Colors.grey.withOpacity(0.2),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0.dg),
                          child: Text(
                            viewModel.locationController.text.isNotEmpty
                                ? viewModel.locationController.text
                                : 'Location',
                            style: globalTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: kcBlackColor.withOpacity(0.6)),
                          ),
                        ),
                      )),
                  verticalSpaceMedium,
                  PrimaryColorRoundedElevatedButton(
                    onPressed: () {
                      viewModel.saveEditDetails();
                    },
                    buttonText: 'Save',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
