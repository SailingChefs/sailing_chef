import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/settings_viewmodel.dart';
import 'package:sailing_chefs/ui/views/settings/widgets/settings_list.dart';
import 'package:sailing_chefs/ui/views/settings/widgets/top_bar.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  final bool? isCurrentUser;
  final String? uid;

  const SettingsView({super.key, this.isCurrentUser, this.uid});

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return Material(
      elevation: 10,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: const SingleChildScrollView(
            child: Column(
              children: [
                TopBarSettingsProfile(),
                SettingsListSettingsScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}
