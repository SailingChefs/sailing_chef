import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/widgets/form.dart';
import 'package:sailing_chefs/ui/views/user_details/widgets/profile_picture.dart';
import 'package:sailing_chefs/ui/views/user_details/widgets/top_bar.dart';

import 'user_details_viewmodel.dart';

class UserDetailsView extends StackedView<UserDetailsViewModel> {
  const UserDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserDetailsViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: EdgeInsets.fromLTRB(10.0.dg, 30.0.dg, 10.0.dg, 0.0.dg),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TopBarUserDetailsScreen(),
                  verticalSpaceMedium,
                  const ProfilePictureUserDetailsScreen(),
                  verticalSpaceMedium,
                  const FormUserDetailsScrenn(),
                  verticalSpaceMedium,
                ],
              ),
            ),
          )),
    );
  }
  @override
  void onViewModelReady(UserDetailsViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }
  @override
  UserDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserDetailsViewModel();
}
