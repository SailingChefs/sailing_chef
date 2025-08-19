import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/sign_up/sign_up_viewmodel.dart';
import 'package:sailing_chefs/ui/views/sign_up/widget/roleselector_compnent.dart';
import 'package:sailing_chefs/ui/views/sign_up/widget/sign_up_form.dart';
import 'package:sailing_chefs/ui/views/sign_up/widget/topbar.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  const SignUpView({super.key});

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
        backgroundColor: Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/background/back_screen.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background/back.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 35.0.dg,
                    left: 20.dg,
                    right: 20.dg,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      const SignUpTopBar(),
                      verticalSpace(MediaQuery.of(context).size.height * 0.05),
                      Text(
                        "Let's create your account",
                        style: globalTextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      verticalSpace(MediaQuery.of(context).size.height * 0.010),
                      Text(
                        'sign up as',
                        style: globalTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      verticalSpace(MediaQuery.of(context).size.height * 0.028),
                      const RoleSelector(),
                      verticalSpace(MediaQuery.of(context).size.height * 0.05),
                      const SignUpForm(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(BuildContext context) => SignUpViewModel();
}
