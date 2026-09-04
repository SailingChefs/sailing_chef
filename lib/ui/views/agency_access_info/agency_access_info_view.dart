import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/agency_access_info/agency_access_info_viewmodel.dart';

class AgencyAccessInfoView extends StackedView<AgencyAccessInfoViewModel> {
  const AgencyAccessInfoView({super.key});

  static const List<String> _agenciesGet = [
    'Searchable database of yacht chefs',
    'Filter by who is available for work',
    'Message chefs directly in the app',
    'Alerts when new chefs join',
  ];

  @override
  Widget builder(
    BuildContext context,
    AgencyAccessInfoViewModel viewModel,
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
                          Icons.work_outline,
                          color: kcPrimaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    Center(
                      child: Text(
                        'Find your next yacht chef',
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
                        'Give your placement team direct access to the chefs on '
                        'Sailing Chefs and reach the right crew faster.',
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
                    Text(
                      'What agencies get',
                      style: globalTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                        color: kcBlackColor,
                      ),
                    ),
                    verticalSpaceSmall,
                    ..._agenciesGet.map((item) => _ChecklistRow(text: item)),
                    verticalSpaceLarge,
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _PricingTier(
                            name: 'Basic',
                            price: 'R1 500',
                            period: '/mo',
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: _PricingTier(
                            name: 'Pro',
                            price: 'R3 500',
                            period: '/mo',
                            popular: true,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceLarge,
                    _PrimaryButton(
                      label: 'Get in touch',
                      onTap: viewModel.getInTouch,
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
  AgencyAccessInfoViewModel viewModelBuilder(BuildContext context) =>
      AgencyAccessInfoViewModel();
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
            'Agency access',
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

class _PricingTier extends StatelessWidget {
  const _PricingTier({
    required this.name,
    required this.price,
    required this.period,
    this.popular = false,
  });

  final String name;
  final String price;
  final String period;
  final bool popular;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      decoration: BoxDecoration(
        color: popular ? kcPrimaryColor.withOpacity(0.08) : kcWhiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: popular ? kcPrimaryColor : kcBlackColor.withOpacity(0.08),
          width: popular ? 1.4 : 1,
        ),
      ),
      child: Column(
        children: [
          if (popular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Popular',
                style: globalTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  color: kcWhiteColor,
                ),
              ),
            )
          else
            const SizedBox(height: 21),
          verticalSpaceSmall,
          Text(
            name,
            style: globalTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: popular ? kcPrimaryColor : kcBlackColor,
            ),
          ),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: globalTextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                  color: kcBlackColor,
                ),
              ),
              Text(
                period,
                style: globalTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: kcBlackColor.withOpacity(0.6),
                ),
              ),
            ],
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
