// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/sign_up/sign_up_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RoleSelector extends ViewModelWidget<SignUpViewModel> {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F7).withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: Chef | Culinary School
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _RoleCellSvg(
                    role: 'chef',
                    selectedRole: viewModel.selectedSignUpAs,
                    onTap: () => viewModel.handleSignUpAs(2),
                    svgAsset: 'assets/images/icons/hat.svg',
                    svgSize: 14,
                    label: 'Chef',
                    sublabel: 'Share recipes',
                    topLeft: true,
                  ),
                ),
                Container(width: 1, color: kcWhiteColor.withOpacity(0.2)),
                Expanded(
                  child: _RoleCellSvg(
                    role: 'culinarySchool',
                    selectedRole: viewModel.selectedSignUpAs,
                    onTap: () => viewModel.handleSignUpAs(1),
                    svgAsset: 'assets/images/icons/school.svg',
                    svgSize: 18,
                    label: 'Culinary school',
                    sublabel: 'Publish courses',
                    topRight: true,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: kcWhiteColor.withOpacity(0.2)),
          // Row 2: Guest | Supplier
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _RoleCellSvg(
                    role: 'guest',
                    selectedRole: viewModel.selectedSignUpAs,
                    onTap: () => viewModel.handleSignUpAs(0),
                    svgAsset: 'assets/images/icons/guest.svg',
                    svgSize: 18,
                    label: 'Guest',
                    sublabel: 'Browse & save',
                    bottomLeft: true,
                  ),
                ),
                Container(width: 1, color: kcWhiteColor.withOpacity(0.2)),
                Expanded(
                  child: _RoleCellIcon(
                    role: 'supplier',
                    selectedRole: viewModel.selectedSignUpAs,
                    onTap: () => viewModel.handleSignUpAs(3),
                    icon: Icons.store_rounded,
                    label: 'Supplier',
                    sublabel: 'List your business',
                    bottomRight: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleCellSvg extends StatelessWidget {
  final String role;
  final String selectedRole;
  final VoidCallback onTap;
  final String svgAsset;
  final double svgSize;
  final String label;
  final String sublabel;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  const _RoleCellSvg({
    required this.role,
    required this.selectedRole,
    required this.onTap,
    required this.svgAsset,
    required this.svgSize,
    required this.label,
    required this.sublabel,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final selected = selectedRole == role;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? kcPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: topLeft ? const Radius.circular(10) : Radius.zero,
            topRight: topRight ? const Radius.circular(10) : Radius.zero,
            bottomLeft: bottomLeft ? const Radius.circular(10) : Radius.zero,
            bottomRight: bottomRight ? const Radius.circular(10) : Radius.zero,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: svgSize,
              height: svgSize,
              child: SvgPicture.asset(svgAsset),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
                fontSize: 12,
              ),
            ),
            Text(
              sublabel,
              style: const TextStyle(fontSize: 9, color: kcWhiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCellIcon extends StatelessWidget {
  final String role;
  final String selectedRole;
  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final String sublabel;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  const _RoleCellIcon({
    required this.role,
    required this.selectedRole,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.sublabel,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final selected = selectedRole == role;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? kcPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: topLeft ? const Radius.circular(10) : Radius.zero,
            topRight: topRight ? const Radius.circular(10) : Radius.zero,
            bottomLeft: bottomLeft ? const Radius.circular(10) : Radius.zero,
            bottomRight: bottomRight ? const Radius.circular(10) : Radius.zero,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: kcWhiteColor, size: 18),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
                fontSize: 12,
              ),
            ),
            Text(
              sublabel,
              style: const TextStyle(fontSize: 9, color: kcWhiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
