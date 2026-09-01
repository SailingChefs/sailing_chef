import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'featured_listing_info_viewmodel.dart';

class FeaturedListingInfoView
    extends StackedView<FeaturedListingInfoViewModel> {
  const FeaturedListingInfoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FeaturedListingInfoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(viewModel: viewModel),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceMedium,
                    _HeroSection(),
                    verticalSpaceMedium,
                    _PinComparisonSection(),
                    verticalSpaceMedium,
                    _WhatsIncludedSection(),
                    verticalSpaceMedium,
                    _PricingCard(),
                    verticalSpaceMedium,
                    _CtaButtons(viewModel: viewModel),
                    verticalSpaceLarge,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  FeaturedListingInfoViewModel viewModelBuilder(BuildContext context) =>
      FeaturedListingInfoViewModel();
}

class _TopBar extends StatelessWidget {
  final FeaturedListingInfoViewModel viewModel;
  const _TopBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: viewModel.back,
            child: Icon(Icons.arrow_back_ios, color: kcBlackColor, size: 20.sp),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56.r,
          height: 56.r,
          decoration: BoxDecoration(
            color: kcDarkColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Icon(Icons.store_rounded, color: kcDarkColor, size: 30.sp),
        ),
        verticalSpaceMedium,
        Text(
          'Get featured on the map',
          style: globalTextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: kcDarkColor,
            letterSpacing: -0.5,
          ),
        ),
        verticalSpaceSmall,
        Text(
          'Reach yacht chefs and crew actively looking for the best suppliers in your area',
          style: globalTextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: kcBlackColor.withOpacity(0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _PinComparisonSection extends StatelessWidget {
  const _PinComparisonSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: kcSurfaceColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(child: _PinCard(featured: false)),
          SizedBox(width: 12.w),
          Expanded(child: _PinCard(featured: true)),
        ],
      ),
    );
  }
}

class _PinCard extends StatelessWidget {
  final bool featured;
  const _PinCard({required this.featured});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: kcWhiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: featured
            ? Border.all(color: kcPrimaryColor, width: 1.5)
            : Border.all(color: kcBlackColor.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.location_pin,
            color: featured ? kcPrimaryColor : kcBlackColor.withOpacity(0.35),
            size: featured ? 36.sp : 24.sp,
          ),
          verticalSpaceSmall,
          Text(
            featured ? 'Featured' : 'Standard',
            style: globalTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: featured ? kcPrimaryColor : kcBlackColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _WhatsIncludedSection extends StatelessWidget {
  const _WhatsIncludedSection();

  static const List<String> _items = [
    'Larger pin on the map',
    'Business photo and description',
    'Contact button for direct enquiries',
    'Priority in search results',
    'Monthly impressions report',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s included',
          style: globalTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: kcDarkColor,
          ),
        ),
        verticalSpaceSmall,
        ..._items.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_rounded,
                      color: kcPrimaryColor, size: 18.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      item,
                      style: globalTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: kcBlackColor,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class _PricingCard extends StatelessWidget {
  const _PricingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: kcDarkColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'R799',
            style: globalTextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: kcWhiteColor,
              letterSpacing: -1,
            ),
          ),
          Text(
            'per month',
            style: globalTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: kcWhiteColor.withOpacity(0.7),
            ),
          ),
          verticalSpaceSmall,
          Text(
            'Cancel anytime',
            style: globalTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: kcWhiteColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaButtons extends StatelessWidget {
  final FeaturedListingInfoViewModel viewModel;
  const _CtaButtons({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: viewModel.getInTouch,
          style: ElevatedButton.styleFrom(
            backgroundColor: kcPrimaryColor,
            foregroundColor: kcWhiteColor,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Get in touch',
            style: globalTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
        ),
        verticalSpaceSmall,
        OutlinedButton(
          onPressed: viewModel.goToSupplierSignUp,
          style: OutlinedButton.styleFrom(
            foregroundColor: kcPrimaryColor,
            side: BorderSide(color: kcPrimaryColor, width: 1.5),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Create a free listing',
            style: globalTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: kcPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
