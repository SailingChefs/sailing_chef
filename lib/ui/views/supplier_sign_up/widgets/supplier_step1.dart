import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/supplier_sign_up/supplier_sign_up_viewmodel.dart';

class SupplierStep1 extends ViewModelWidget<SupplierSignUpViewModel> {
  const SupplierStep1({super.key});

  @override
  Widget build(BuildContext context, SupplierSignUpViewModel viewModel) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      child: Form(
        key: viewModel.step1FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tell us about your business',
              style: globalTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: kcBlackColor.withOpacity(0.55),
              ),
            ),
            SizedBox(height: 20.h),
            _FieldLabel('Business name'),
            SizedBox(height: 6.h),
            _TextField(
              controller: viewModel.businessNameController,
              hint: 'e.g. Captain\'s Catch',
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 16.h),
            _FieldLabel('Category'),
            SizedBox(height: 8.h),
            _CategorySelector(viewModel: viewModel),
            SizedBox(height: 16.h),
            _FieldLabel('Phone number (optional)'),
            SizedBox(height: 6.h),
            _TextField(
              controller: viewModel.phoneController,
              hint: 'e.g. +61 400 000 000',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),
            _FieldLabel('Website (optional)'),
            SizedBox(height: 6.h),
            _TextField(
              controller: viewModel.websiteController,
              hint: 'e.g. www.yourbusiness.com',
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 16.h),
            _FieldLabel('Description'),
            SizedBox(height: 6.h),
            _TextField(
              controller: viewModel.descriptionController,
              hint: 'Tell sailors what you sell or offer…',
              maxLines: 4,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: globalTextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: kcBlackColor.withOpacity(0.75),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;

  const _TextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      cursorColor: kcPrimaryColor,
      style: globalTextStyle(
        fontSize: 13.sp,
        color: kcBlackColor,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: globalTextStyle(
          fontSize: 13.sp,
          color: kcBlackColor.withOpacity(0.35),
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: kcVeryLightGrey,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: kcPrimaryColor, width: 1.5),
        ),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final SupplierSignUpViewModel viewModel;
  const _CategorySelector({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SupplierSignUpViewModel.categoryOptions.map((cat) {
        final selected = viewModel.selectedCategory == cat;
        return GestureDetector(
          onTap: () => viewModel.selectCategory(cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? kcPrimaryColor : kcVeryLightGrey,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              cat,
              style: globalTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: selected ? kcWhiteColor : kcBlackColor.withOpacity(0.65),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
