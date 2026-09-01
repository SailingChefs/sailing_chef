import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'supplier_confirmation_viewmodel.dart';

class SupplierConfirmationView
    extends StackedView<SupplierConfirmationViewModel> {
  const SupplierConfirmationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SupplierConfirmationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: kcPrimaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.store_rounded,
                  size: 52,
                  color: kcPrimaryColor,
                ),
              ),
              SizedBox(height: 28.h),
              Text(
                "You're on the map!",
                textAlign: TextAlign.center,
                style: globalTextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: kcBlackColor,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Your business pin is now live. Sailors nearby can find you on the map.',
                textAlign: TextAlign.center,
                style: globalTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: kcBlackColor.withOpacity(0.55),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Check your email to verify your account before logging in.',
                textAlign: TextAlign.center,
                style: globalTextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: kcBlackColor.withOpacity(0.4),
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.goToSupplierHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: Text(
                    'Go to my store',
                    style: globalTextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SupplierConfirmationViewModel viewModelBuilder(BuildContext context) =>
      SupplierConfirmationViewModel();
}
