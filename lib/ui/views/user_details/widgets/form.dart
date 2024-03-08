import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class FormUserDetailsScrenn extends ViewModelWidget<UserDetailsViewModel> {
  const FormUserDetailsScrenn({super.key});

  @override
  Widget build(BuildContext context, UserDetailsViewModel viewModel) {
    return Column(
      children: [
        Form(
            child: Column(children: [
          SemiRoundedTranpaentTextField(
              controller: viewModel.nameController, labelText: 'Name'),
          verticalSpaceMedium,
          SemiRoundedTranpaentTextField(
              controller: viewModel.bioController, labelText: 'Bio'),
          verticalSpaceMedium,
          SemiRoundedTranpaentTextField(
              controller: viewModel.linkController, labelText: 'Link'),
          verticalSpaceMedium,
          SemiRoundedTranpaentTextField(
              controller: viewModel.boatNameController, labelText: 'Boat Name'),
          verticalSpaceMedium,
          SemiRoundedTranpaentTextField(
              controller: viewModel.locationController, labelText: 'Location'),
          verticalSpaceMedium,
          SemiRoundedTranpaentTextField(
              controller: viewModel.syjoyController, labelText: 'Sy Joy '),
          verticalSpaceMedium,
          SemiRoundedTranpaentTextField(
              controller: viewModel.location2Controller, labelText: 'Location'),
        ])),
        verticalSpaceMedium,
        PrimaryColorRoundedElevatedButton(
          onPressed: viewModel.saveUserDetails,
          buttonText: 'SAVE',
        ),
      ],
    );
  }
}
