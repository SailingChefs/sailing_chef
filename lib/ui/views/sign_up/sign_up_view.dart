import 'package:sailing_chefs/ui/views/sign_up/widget/roleselector_compnent.dart';
import 'package:sailing_chefs/ui/views/sign_up/widget/sign_up_form.dart';
import 'package:sailing_chefs/ui/views/sign_up/widget/topbar.dart';
import '../../../core/imports/core_imports.dart';
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
                        'Let\'s create your account',
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
                      viewModel.selectedSignUpAs == 'supplier'
                          ? _SupplierGetStarted(viewModel: viewModel)
                          : const SignUpForm(),
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

class _SupplierGetStarted extends StatelessWidget {
  final SignUpViewModel viewModel;
  const _SupplierGetStarted({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ready to list your business for sailors nearby?',
          textAlign: TextAlign.center,
          style: globalTextStyle(
            fontSize: 14.sp,
            color: kcWhiteColor.withOpacity(0.85),
            fontWeight: FontWeight.w400,
          ),
        ),
        verticalSpace(24),
        ElevatedButton(
          onPressed: viewModel.navigateToSupplierWizard,
          style: ElevatedButton.styleFrom(
            backgroundColor: kcPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          ),
          child: Text(
            'Set up my store →',
            style: globalTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
