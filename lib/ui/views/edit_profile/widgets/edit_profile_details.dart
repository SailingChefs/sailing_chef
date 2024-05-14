import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/views/edit_profile/widgets/lables_text.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class EditProfileForm extends ViewModelWidget<EditProfileViewModel> {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context, EditProfileViewModel viewModel) {
    return SingleChildScrollView(
        child: UserdataServiceService.user.userRole == 'culinarySchool'
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LablesText(text: 'Company Name'),
                          SemiRoundedTranpaentTextField(
                            suffixIcon: false,
                            controller: viewModel.nameController,
                            borderRadius: 27.dg,
                            labelText: '',
                          ),
                          verticalSpaceTiny,
                          const LablesText(text: 'Description'),
                          SemiRoundedTranpaentTextField(
                            suffixIcon: false,
                            prefixIcons: false,
                            borderRadius: 27.dg,
                            maxLength: 500,
                            maxLines: 5,
                            controller: viewModel.bioController,
                            labelText: '',
                          ),
                          const LablesText(text: 'Email'),
                          SemiRoundedTranpaentTextField(
                            suffixIcon: false,
                            prefixIcons: true,
                            controller: viewModel.emailController,
                            borderRadius: 27.dg,
                            labelText: '',
                            prefixIcon: Icons.email_outlined,
                            size: 20,
                          ),
                          verticalSpaceTiny,
                          const LablesText(text: 'Link'),
                          SemiRoundedTranpaentTextField(
                            suffixIcon: false,
                            prefixIcons: true,
                            borderRadius: 27.dg,
                            controller: viewModel.linkController,
                            prefixIcon: Icons.link,
                            size: 20,
                            labelText: '',
                          ),
                          verticalSpaceTiny,
                          const LablesText(text: 'Location'),
                          SemiRoundedTranpaentTextField(
                            suffixIcon: false,
                            borderRadius: 27.dg,
                            prefixIcons: false,
                            controller: viewModel.location,
                            labelText: '',
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpaceMedium,
                  PrimaryColorRoundedElevatedButton(
                    onPressed: viewModel.saveEditDetailsCullinary,
                    buttonText: 'Save',
                  ),
                ],
              )
            : UserdataServiceService.user.userRole == 'chef'
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: viewModel.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LablesText(text: 'Full Name'),
                              SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                controller: viewModel.nameController,
                                borderRadius: 27.dg,
                                labelText: '',
                              ),
                              verticalSpaceTiny,
                              const LablesText(text: 'Bio'),
                              SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                prefixIcons: false,
                                borderRadius: 27.dg,
                                maxLength: 500,
                                maxLines: 5,
                                controller: viewModel.bioController,
                                labelText: '',
                              ),
                              const LablesText(text: 'Email'),
                              SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                prefixIcons: true,
                                controller: viewModel.emailController,
                                borderRadius: 27.dg,
                                labelText: '',
                                prefixIcon: Icons.email_outlined,
                                size: 20,
                              ),
                              verticalSpaceTiny,
                              const LablesText(text: 'Link'),
                              SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                prefixIcons: true,
                                borderRadius: 27.dg,
                                controller: viewModel.linkController,
                                prefixIcon: Icons.link,
                                size: 20,
                                labelText: '',
                              ),
                              verticalSpaceTiny,
                              const LablesText(text: 'Boat Name'),
                              SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                prefixIcons: false,
                                borderRadius: 27.dg,
                                controller: viewModel.boatController,
                                labelText: '',
                              ),
                              verticalSpaceTiny,
                              const LablesText(text: 'Location'),
                              SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                borderRadius: 27.dg,
                                prefixIcons: false,
                                controller: viewModel.location,
                                labelText: '',
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      PrimaryColorRoundedElevatedButton(
                        onPressed: () {
                          viewModel.saveEditDetailsChef(
                              viewModel.nameController.text.isEmpty
                                  ? UserdataServiceService.user.displayName!
                                  : viewModel.nameController.text.isEmpty
                                      ? UserdataServiceService.user.displayName!
                                      : viewModel.nameController.text,
                              viewModel.bioController.text.isEmpty
                                  ? UserdataServiceService.user.bio!
                                  : viewModel.bioController.text,
                              viewModel.emailController.text.isEmpty
                                  ? UserdataServiceService.user.email!
                                  : viewModel.emailController.text,
                              viewModel.linkController.text.isEmpty
                                  ? UserdataServiceService.user.link!
                                  : viewModel.linkController.text,
                              viewModel.bioController.text.isEmpty
                                  ? UserdataServiceService.user.boatName!
                                  : viewModel.boatController.text);
                        },
                        buttonText: 'Save',
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: viewModel.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LablesText(text: 'Full Name'),
                              SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                controller: viewModel.nameController,
                                borderRadius: 27.dg,
                                labelText: '',
                              ),
                              verticalSpaceTiny,
                              const LablesText(text: 'Bio'),
                              SemiRoundedTranpaentTextField(
                                suffixIcon: false,
                                prefixIcons: false,
                                borderRadius: 27.dg,
                                maxLength: 500,
                                maxLines: 5,
                                controller: viewModel.bioController,
                                labelText: '',
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      PrimaryColorRoundedElevatedButton(
                        onPressed: () {
                          viewModel.saveEditDetailsGuest(
                              viewModel.nameController.text.isEmpty
                                  ? UserdataServiceService.user.displayName!
                                  : viewModel.nameController.text.isEmpty
                                      ? UserdataServiceService.user.displayName!
                                      : viewModel.nameController.text,
                              viewModel.bioController.text.isEmpty
                                  ? UserdataServiceService.user.bio!
                                  : viewModel.bioController.text);
                        },
                        buttonText: 'Save',
                      ),
                    ],
                  ));
  }
}
