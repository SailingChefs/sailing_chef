import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/edit_profile/widgets/edit_profile_details.dart';
import 'package:sailing_chefs/ui/views/edit_profile/widgets/profileimage.dart';
import 'package:sailing_chefs/ui/views/edit_profile/widgets/topbar_editprofile.dart';
import 'package:stacked/stacked.dart';

import 'edit_profile_viewmodel.dart';

class EditProfileView extends StackedView<EditProfileViewModel> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpaceMedium,
              const TopBarEditProfile('Edit Profile'),
              verticalSpaceMedium,
              const EditProfileImage(),
              verticalSpaceSmall,
               EditProfileForm(key: ValueKey(viewModel.countryValue),),
              verticalSpaceMedium,
            ],
          ),
        ));
  }

  @override
  void onViewModelReady(EditProfileViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  EditProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditProfileViewModel();
}
