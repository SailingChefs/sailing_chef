import 'package:sailing_chefs/ui/views/sign_up/widget/roleselector_compnent.dart';
import 'package:sailing_chefs/ui/views/sign_up/widget/sign_up_form.dart';
import 'package:sailing_chefs/ui/views/sign_up/widget/topbar.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

import '../../../core/imports/core_imports.dart';
import '../../widgets/rounded_elevated_button.dart';
import 'sign_up_viewmodel.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignUpViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/background/back_screen.png'),
                    fit: BoxFit.fill)),
          ),
          Positioned.fill(
            child: Container(
              height: screenHeight(context),
              width: screenWidth(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background/back.png'),
                      fit: BoxFit.fill)),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 35.0.dg, left: 20.dg, right: 20.dg),
                child: Column(children: [
                  const SignUpTopBar(),
                  verticalSpace(MediaQuery.of(context).size.height * 0.05),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Lets create your account',
                          style: globalTextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.010),
                        Text(
                          'sign up as',
                          style: globalTextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.028),
                        const RoleSelector(),
                        verticalSpace(
                            MediaQuery.of(context).size.height * 0.05),
                        const SignUpForm(),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignUpViewModel();
}
