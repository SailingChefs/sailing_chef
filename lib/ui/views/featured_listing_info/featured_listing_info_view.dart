import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/featured_listing_info/featured_listing_info_viewmodel.dart';

class FeaturedListingInfoView
    extends StackedView<FeaturedListingInfoViewModel> {
  const FeaturedListingInfoView({super.key});

  static const List<String> _included = [
    'Larger, branded pin on the map',
    'Photo of your business',
    'Full description of what you offer',
    'Direct contact button for chefs',
    'Priority placement in search results',
    'Monthly performance report',
  ];

  @override
  Widget builder(
    BuildContext context,
    FeaturedListingInfoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(onBack: viewModel.goBack),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          color: kcPrimaryColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.storefront,
                          color: kcPrimaryColor,
                          size: 32,
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    Center(
                      child: Text(
                        'Get featured on the map',
                        textAlign: TextAlign.center,
                        style: globalTextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: kcBlackColor,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Center(
                      child: Text(
                        'Put your business in front of yacht chefs and crew '
                        'searching the map for trusted suppliers along the coast.',
                        textAlign: TextAlign.center,
                        style: globalTextStyle(
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                          color: kcBlackColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                    verticalSpaceLarge,
                    const _PinComparison(),
                    verticalSpaceLarge,
                    Text(
                      "What's included",
                      style: globalTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                        color: kcBlackColor,
                      ),
                    ),
                    verticalSpaceSmall,
                    ..._included.map((item) => _ChecklistRow(text: item)),
                    verticalSpaceLarge,
                    const _PricingCard(),
                    verticalSpaceLarge,
                    _PrimaryButton(
                      label: 'Get in touch',
                      onTap: viewModel.getInTouch,
                    ),
                    verticalSpaceMedium,
                    _OutlinedButton(
                      label: 'Create a free listing',
                      onTap: viewModel.createFreeListing,
                    ),
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
  const _TopBar({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 24, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: kcBlackColor,
          ),
          Text(
            'Featured listing',
            style: globalTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
              color: kcBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PinComparison extends StatelessWidget {
  const _PinComparison();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _PinCard(
            label: 'Standard',
            caption: 'Small grey pin',
            child: Icon(Icons.place, size: 30, color: kcMediumGrey),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _PinCard(
            label: 'Featured',
            caption: 'Large branded pin with photo',
            highlighted: true,
            child: SizedBox(
              height: 48,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.place, size: 48, color: kcPrimaryColor),
                  Positioned(
                    top: 6,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        color: kcWhiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.photo_camera,
                        size: 11,
                        color: kcPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PinCard extends StatelessWidget {
  const _PinCard({
    required this.label,
    required this.caption,
    required this.child,
    this.highlighted = false,
  });

  final String label;
  final String caption;
  final Widget child;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: highlighted ? kcPrimaryColor.withOpacity(0.08) : kcWhiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlighted
              ? kcPrimaryColor
              : kcBlackColor.withOpacity(0.08),
          width: highlighted ? 1.4 : 1,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 48, child: Center(child: child)),
          verticalSpaceSmall,
          Text(
            label,
            style: globalTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: highlighted ? kcPrimaryColor : kcBlackColor,
            ),
          ),
          verticalSpaceTiny,
          Text(
            caption,
            textAlign: TextAlign.center,
            style: globalTextStyle(
              fontSize: 11,
              height: 1.3,
              fontWeight: FontWeight.w400,
              color: kcBlackColor.withOpacity(0.55),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: kcPrimaryColor),
          horizontalSpaceSmall,
          Expanded(
            child: Text(
              text,
              style: globalTextStyle(
                fontSize: 14,
                height: 1.35,
                fontWeight: FontWeight.w400,
                color: kcBlackColor.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  const _PricingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'R799',
                style: globalTextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: kcBlackColor,
                ),
              ),
              Text(
                '/month',
                style: globalTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kcBlackColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          verticalSpaceTiny,
          Text(
            'Cancel anytime',
            style: globalTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: kcPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kcPrimaryColor,
          foregroundColor: kcWhiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: globalTextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: kcWhiteColor,
          ),
        ),
      ),
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: kcPrimaryColor,
          side: const BorderSide(color: kcPrimaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: globalTextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: kcPrimaryColor,
          ),
        ),
      ),
    );
  }
}
