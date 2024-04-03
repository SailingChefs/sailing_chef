import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class EditProfileForm extends ViewModelWidget<EditProfileViewModel> {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context, EditProfileViewModel viewModel) {
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
                    controller: viewModel.nameController,
                    labelText: UserdataServiceService.user.displayName ?? 'Name',
                  ),
                  verticalSpaceMedium,
                  SemiRoundedTranpaentTextField(
                    controller: viewModel.emailController,
                    labelText:  UserdataServiceService.user.email ?? 'Email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      size: 15,
                    ),
                  ),
                  verticalSpaceMedium,
                  SemiRoundedTranpaentTextField(
                    controller: viewModel.numberController,
                    labelText:  UserdataServiceService.user.phoneNumber ?? 'Phone Number',
                  ),
                  verticalSpaceMedium,
                  SemiRoundedTranpaentTextField(
                    controller: viewModel.dobController,
                    labelText:  UserdataServiceService.user.dob ?? 'Date of Birth',
                  ),
                  verticalSpaceMedium,
                  SemiRoundedTranpaentTextField(
                    controller: viewModel.bioController,
                    labelText: UserdataServiceService.user.bio ?? 'Bio',
                  ),
                  verticalSpaceMedium,
                  PrimaryColorRoundedElevatedButton(
                    onPressed: () {
                      viewModel.saveEditDetails(viewModel.nameController.text.isEmpty ? UserdataServiceService.user.displayName! : viewModel.nameController.text.isEmpty? UserdataServiceService.user.displayName! : viewModel.nameController.text,viewModel.emailController.text.isEmpty ? UserdataServiceService.user.email! : viewModel.emailController.text,viewModel.numberController.text.isEmpty ? UserdataServiceService.user.phoneNumber! : viewModel.numberController.text,viewModel.dobController.text.isEmpty ? UserdataServiceService.user.dob! : viewModel.dobController.text,viewModel.bioController.text.isEmpty ? UserdataServiceService.user.bio! : viewModel.bioController.text);
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
