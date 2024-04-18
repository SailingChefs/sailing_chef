import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class FormUserDetailsScrenn extends ViewModelWidget<UserDetailsViewModel> {
  const FormUserDetailsScrenn({super.key});

  @override
  Widget build(BuildContext context, UserDetailsViewModel viewModel) {
    bool islocationempty = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                SemiRoundedTranpaentTextField(
                  validator: (value) => viewModel.validateName(value),
                  controller: viewModel.nameController,
                  labelText: 'Name',
                ),
                verticalSpaceMedium,
                SemiRoundedTranpaentTextField(
                 validator: (value) => viewModel.validateBio(value),
                    controller: viewModel.bioController, labelText: 'Bio'),
                verticalSpaceMedium,
                SemiRoundedTranpaentTextField(
                  validator: (value) => viewModel.validateLink(value),
                    controller: viewModel.linkController, labelText: 'Link'),
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
                      decoration:   islocationempty == false? BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.red,),
                        color: Colors.grey.withOpacity(0.2),

                      ) : BoxDecoration(
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
              ],
            ),
          ),
        ),
        verticalSpaceMassive,
        PrimaryColorRoundedElevatedButton(
          onPressed: (){
            if(viewModel.formKey.currentState!.validate()){
              if(viewModel.locationController.text.isEmpty){
                log('location empty');
                islocationempty = false;
              }else{
                islocationempty = true;
              }
              viewModel.saveUserDetails();
            }
          },
          buttonText: 'SAVE',
        ),
      ],
    );
  }
}
