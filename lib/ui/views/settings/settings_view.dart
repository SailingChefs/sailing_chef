import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/views/settings/widgets/settings_list.dart';
import 'package:sailing_chefs/ui/views/settings/widgets/top_bar.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Column(
        children: [
          TopBarSettingsScreen(title: 'Settings'),
          SettingsListSettingsScreen(),
        ],
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}
