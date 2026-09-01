import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'supplier_profile_viewmodel.dart';

class SupplierProfileView extends StackedView<SupplierProfileViewModel> {
  const SupplierProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SupplierProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcWhiteColor,
      appBar: AppBar(
        backgroundColor: kcWhiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Store',
          style: globalTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: kcBlackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store header
            Row(
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: kcPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.store_rounded,
                    size: 36,
                    color: kcPrimaryColor,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.businessName,
                        style: globalTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: kcBlackColor,
                        ),
                      ),
                      if (viewModel.category.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: kcPrimaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            viewModel.category,
                            style: globalTextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: kcPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.directions_outlined,
                    label: 'Get directions',
                    onTap: viewModel.getDirections,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Messages',
                    onTap: viewModel.toMessages,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            // Description
            if (viewModel.description.isNotEmpty) ...[
              _SectionTitle('About'),
              SizedBox(height: 8.h),
              Text(
                viewModel.description,
                style: globalTextStyle(
                  fontSize: 13.sp,
                  color: kcBlackColor.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),
            ],
            // Contact details
            _SectionTitle('Contact'),
            SizedBox(height: 12.h),
            if (viewModel.contact.isNotEmpty)
              _ContactRow(
                icon: Icons.phone_outlined,
                label: viewModel.contact,
                onTap: viewModel.callPhone,
              ),
            if (viewModel.email.isNotEmpty)
              _ContactRow(
                icon: Icons.email_outlined,
                label: viewModel.email,
                onTap: null,
              ),
            if (viewModel.website.isNotEmpty)
              _ContactRow(
                icon: Icons.language_outlined,
                label: viewModel.website,
                onTap: viewModel.openWebsite,
              ),
          ],
        ),
      ),
    );
  }

  @override
  SupplierProfileViewModel viewModelBuilder(BuildContext context) =>
      SupplierProfileViewModel();
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: globalTextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: kcBlackColor,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: kcPrimaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: kcPrimaryColor, size: 22),
            SizedBox(height: 4.h),
            Text(
              label,
              style: globalTextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: kcPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ContactRow({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          children: [
            Icon(icon, color: kcPrimaryColor, size: 18),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: globalTextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: onTap != null
                      ? kcPrimaryColor
                      : kcBlackColor.withOpacity(0.7),
                  decoration:
                      onTap != null ? TextDecoration.underline : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
