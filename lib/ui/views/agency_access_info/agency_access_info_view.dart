import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'agency_access_info_viewmodel.dart';

class AgencyAccessInfoView extends StackedView<AgencyAccessInfoViewModel> {
  const AgencyAccessInfoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AgencyAccessInfoViewModel viewModel,
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
                    _FeaturesSection(),
                    verticalSpaceMedium,
                    _PricingSection(),
                    verticalSpaceMedium,
                    _CtaButton(viewModel: viewModel),
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
  AgencyAccessInfoViewModel viewModelBuilder(BuildContext context) =>
      AgencyAccessInfoViewModel();
}

class _TopBar extends StatelessWidget {
  final AgencyAccessInfoViewModel viewModel;
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
          child: Icon(Icons.work_rounded, color: kcDarkColor, size: 30.sp),
        ),
        verticalSpaceMedium,
        Text(
          'Find your next yacht chef',
          style: globalTextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: kcDarkColor,
            letterSpacing: -0.5,
          ),
        ),
        verticalSpaceSmall,
        Text(
          'Access a live database of available yacht chefs, filtered by location, cuisine style and experience',
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

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  static const List<_Feature> _features = [
    _Feature(
      icon: Icons.search_rounded,
      title: 'Searchable chef database',
      subtitle: 'Filter by location, cuisine style and experience',
    ),
    _Feature(
      icon: Icons.toggle_on_rounded,
      title: 'Availability filter',
      subtitle: 'See only chefs who are actively looking for work',
    ),
    _Feature(
      icon: Icons.chat_bubble_rounded,
      title: 'Direct messaging',
      subtitle: 'Connect with chefs directly through the app',
    ),
    _Feature(
      icon: Icons.notifications_rounded,
      title: 'New chef alerts',
      subtitle: 'Get notified when chefs matching your criteria join',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What you get',
          style: globalTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: kcDarkColor,
          ),
        ),
        verticalSpaceSmall,
        ..._features.map((f) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36.r,
                    height: 36.r,
                    decoration: BoxDecoration(
                      color: kcPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(f.icon, color: kcPrimaryColor, size: 18.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          f.title,
                          style: globalTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          f.subtitle,
                          style: globalTextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: kcBlackColor.withOpacity(0.55),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String subtitle;
  const _Feature({required this.icon, required this.title, required this.subtitle});
}

class _PricingSection extends StatelessWidget {
  const _PricingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pricing',
          style: globalTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: kcDarkColor,
          ),
        ),
        verticalSpaceSmall,
        Row(
          children: [
            Expanded(child: _PricingTile(plan: 'Basic', price: 'R1 500', popular: false)),
            SizedBox(width: 12.w),
            Expanded(child: _PricingTile(plan: 'Pro', price: 'R3 500', popular: true)),
          ],
        ),
      ],
    );
  }
}

class _PricingTile extends StatelessWidget {
  final String plan;
  final String price;
  final bool popular;
  const _PricingTile({required this.plan, required this.price, required this.popular});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: popular ? kcDarkColor : kcSurfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: popular ? null : Border.all(color: kcBlackColor.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (popular)
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Popular',
                style: globalTextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: kcWhiteColor,
                ),
              ),
            ),
          Text(
            plan,
            style: globalTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: popular ? kcWhiteColor : kcBlackColor,
            ),
          ),
          verticalSpaceTiny,
          Text(
            price,
            style: globalTextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: popular ? kcWhiteColor : kcDarkColor,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            '/mo',
            style: globalTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: popular
                  ? kcWhiteColor.withOpacity(0.65)
                  : kcBlackColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final AgencyAccessInfoViewModel viewModel;
  const _CtaButton({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
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
    );
  }
}
