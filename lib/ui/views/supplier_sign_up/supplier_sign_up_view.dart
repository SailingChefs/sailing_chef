import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/supplier_sign_up/widgets/supplier_step1.dart';
import 'package:sailing_chefs/ui/views/supplier_sign_up/widgets/supplier_step2_map.dart';
import 'package:sailing_chefs/ui/views/supplier_sign_up/widgets/supplier_step3.dart';

import 'supplier_sign_up_viewmodel.dart';

class SupplierSignUpView extends StackedView<SupplierSignUpViewModel> {
  const SupplierSignUpView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SupplierSignUpViewModel viewModel,
    Widget? child,
  ) {
    final stepTitles = [
      'Business details',
      'Pin your location',
      'Create account',
    ];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kcWhiteColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: viewModel.wizardStep == 0
                          ? viewModel.goBack
                          : viewModel.goToPreviousStep,
                      child: Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: kcVeryLightGrey,
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 16),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stepTitles[viewModel.wizardStep],
                          style: globalTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: kcBlackColor,
                          ),
                        ),
                        Text(
                          'Step ${viewModel.wizardStep + 1} of 3',
                          style: globalTextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: kcBlackColor.withOpacity(0.45),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              // Progress bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: List.generate(3, (i) {
                    return Expanded(
                      child: Container(
                        height: 4,
                        margin: EdgeInsets.only(right: i < 2 ? 4.w : 0),
                        decoration: BoxDecoration(
                          color: i <= viewModel.wizardStep
                              ? kcPrimaryColor
                              : kcVeryLightGrey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 8.h),
              // Steps
              Expanded(
                child: IndexedStack(
                  index: viewModel.wizardStep,
                  children: const [
                    SupplierStep1(),
                    SupplierStep2Map(),
                    SupplierStep3(),
                  ],
                ),
              ),
              // Bottom navigation
              Container(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                decoration: BoxDecoration(
                  color: kcWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: kcBlackColor.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (viewModel.wizardStep > 0) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: viewModel.goToPreviousStep,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: kcPrimaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: Text(
                            'Back',
                            style: globalTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: kcPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: viewModel.isBusy
                            ? null
                            : (viewModel.wizardStep < 2
                                ? viewModel.goToNextStep
                                : viewModel.createAccount),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kcPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: viewModel.isBusy
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: kcWhiteColor,
                                ),
                              )
                            : Text(
                                viewModel.wizardStep < 2
                                    ? 'Next'
                                    : 'Create Account',
                                style: globalTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kcWhiteColor,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(SupplierSignUpViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  SupplierSignUpViewModel viewModelBuilder(BuildContext context) =>
      SupplierSignUpViewModel();
}
