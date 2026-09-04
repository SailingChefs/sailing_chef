import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/sign_up/sign_up_viewmodel.dart';

class RoleSelector extends ViewModelWidget<SignUpViewModel> {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Column(
      children: [
        _RoleCard(
          svgPath: 'assets/images/icons/hat.svg',
          label: 'Chef',
          description: 'Share recipes, build your portfolio and get discovered',
          isSelected: viewModel.selectedSignUpAs == 'chef',
          onTap: () => viewModel.handleSignUpAs(2),
        ),
        const SizedBox(height: 10),
        _RoleCard(
          svgPath: 'assets/images/icons/school.svg',
          label: 'Culinary School',
          description: 'List your courses and connect with aspiring chefs',
          isSelected: viewModel.selectedSignUpAs == 'culinarySchool',
          onTap: () => viewModel.handleSignUpAs(1),
        ),
        const SizedBox(height: 10),
        _RoleCard(
          svgPath: 'assets/images/icons/guest.svg',
          label: 'Guest',
          description: 'Browse recipes and discover top sailing chefs',
          isSelected: viewModel.selectedSignUpAs == 'guest',
          onTap: () => viewModel.handleSignUpAs(0),
        ),
        const SizedBox(height: 10),
        _RoleCard(
          svgPath: 'assets/images/icons/supplier.svg',
          label: 'Supplier',
          description: 'List your marine products and reach sailing chefs',
          isSelected: viewModel.selectedSignUpAs == 'supplier',
          onTap: () => viewModel.handleSignUpAs(3),
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String svgPath;
  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.svgPath,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? kcPrimaryColor.withOpacity(0.12) : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? kcPrimaryColor : Colors.white.withOpacity(0.25),
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                svgPath,
                color: isSelected ? kcPrimaryColor : kcWhiteColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? kcPrimaryColor : kcWhiteColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: globalTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: isSelected
                          ? kcPrimaryColor.withOpacity(0.8)
                          : kcWhiteColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: kcPrimaryColor, size: 20),
          ],
        ),
      ),
    );
  }
}
