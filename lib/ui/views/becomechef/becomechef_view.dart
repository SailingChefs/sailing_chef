import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/views/becomechef/widgets/editdata.dart';
import 'package:sailing_chefs/ui/views/becomechef/widgets/topbar_editprofile.dart';
import 'package:stacked/stacked.dart';

import 'becomechef_viewmodel.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';


class BecomechefView extends StackedView<BecomechefViewModel> {
  const BecomechefView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BecomechefViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpaceLarge,
              const TopBarBecomeChef('Become a Chef'),
              verticalSpaceSmall,
              const BecomeChefForm(),
              verticalSpaceMedium,
              
            ],
          ),
        ));
  }

  @override
  void onViewModelReady(BecomechefViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  BecomechefViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BecomechefViewModel();
}
