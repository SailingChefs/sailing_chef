
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/widgets/settings_list.dart';
import 'package:sailing_chefs/ui/views/settings/widgets/top_bar.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  final bool? isCurrentUser;
  final String? uid;

  const SettingsView({Key? key, this.isCurrentUser, this.uid})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return  const SafeArea(
      child: Scaffold(
        
        backgroundColor: kcBackgroundColor,

        body:  SingleChildScrollView(
          child: Column(

            children:  [
              TopBarSettingsProfile(),

              SettingsListSettingsScreen(),
            ],
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
