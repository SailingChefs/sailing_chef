// ignore_for_file: deprecated_member_use

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/supplier_profile/supplier_profile_viewmodel.dart';

class SupplierProfileView extends StackedView<SupplierProfileViewModel> {
  final UserModel supplier;
  final bool isSelf;

  const SupplierProfileView({
    required this.supplier,
    this.isSelf = false,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    SupplierProfileViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(viewModel: viewModel, isSelf: isSelf),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BusinessInfo(supplier: viewModel.supplier),
                    const SizedBox(height: 20),
                    _ActionButtons(viewModel: viewModel, isSelf: isSelf),
                    const SizedBox(height: 20),
                    if (viewModel.supplier.bio != null &&
                        viewModel.supplier.bio!.isNotEmpty) ...[
                      Text(
                        'About',
                        style: globalTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: kcBlackColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.supplier.bio!,
                        style: globalTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: kcBlackColor.withOpacity(0.65),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    _ContactRow(viewModel: viewModel),
                    const SizedBox(height: 30),
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
  SupplierProfileViewModel viewModelBuilder(BuildContext context) =>
      SupplierProfileViewModel(supplier: supplier, isSelf: isSelf);
}

// ─── Header (avatar + name + category chip) ──────────────────────────────────

class _Header extends StatelessWidget {
  final SupplierProfileViewModel viewModel;
  final bool isSelf;
  const _Header({required this.viewModel, required this.isSelf});

  @override
  Widget build(BuildContext context) {
    final s = viewModel.supplier;
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          color: kcPrimaryColor.withOpacity(0.08),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          ),
        ),
        if (isSelf)
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: viewModel.editProfile,
              child: Icon(Icons.edit_outlined,
                  size: 20, color: kcBlackColor.withOpacity(0.55)),
            ),
          ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Transform.translate(
            offset: const Offset(0, 30),
            child: CircleAvatar(
              radius: 44,
              backgroundColor: kcPrimaryColor.withOpacity(0.15),
              backgroundImage: (s.displayPicture != null &&
                      s.displayPicture!.isNotEmpty)
                  ? NetworkImage(s.displayPicture!)
                  : null,
              child: (s.displayPicture == null || s.displayPicture!.isEmpty)
                  ? const Icon(Icons.store_rounded, size: 36, color: kcPrimaryColor)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Business info ────────────────────────────────────────────────────────────

class _BusinessInfo extends StatelessWidget {
  final UserModel supplier;
  const _BusinessInfo({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 36),
        Text(
          supplier.displayName ?? 'Supplier',
          style: globalTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: kcBlackColor,
          ),
        ),
        if (supplier.businessCategory != null &&
            supplier.businessCategory!.isNotEmpty) ...[
          const SizedBox(height: 6),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: kcPrimaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              supplier.businessCategory!,
              style: globalTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kcPrimaryColor,
              ),
            ),
          ),
        ],
        if (supplier.namedLocation != null &&
            supplier.namedLocation!.isNotEmpty) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 14, color: kcBlackColor.withOpacity(0.4)),
              const SizedBox(width: 4),
              Text(
                supplier.namedLocation!,
                style: globalTextStyle(
                  fontSize: 12,
                  color: kcBlackColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ─── Action buttons ───────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  final SupplierProfileViewModel viewModel;
  final bool isSelf;
  const _ActionButtons({required this.viewModel, required this.isSelf});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (viewModel.hasAddress) ...[
          Expanded(
            child: OutlinedButton.icon(
              onPressed: viewModel.openDirections,
              icon: const Icon(Icons.directions_outlined, size: 16),
              label: const Text('Directions'),
              style: OutlinedButton.styleFrom(
                foregroundColor: kcPrimaryColor,
                side: const BorderSide(color: kcPrimaryColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          if (!isSelf) const SizedBox(width: 10),
        ],
        if (!isSelf)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: viewModel.messageSupplier,
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
              label: const Text('Message'),
              style: ElevatedButton.styleFrom(
                backgroundColor: kcPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Contact row ──────────────────────────────────────────────────────────────

class _ContactRow extends StatelessWidget {
  final SupplierProfileViewModel viewModel;
  const _ContactRow({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final s = viewModel.supplier;
    final hasContact =
        s.contactNumber != null && s.contactNumber!.isNotEmpty;
    final hasWebsite = s.link != null && s.link!.isNotEmpty;

    if (!hasContact && !hasWebsite) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: globalTextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: kcBlackColor,
          ),
        ),
        const SizedBox(height: 10),
        if (hasContact)
          _ContactTile(
            icon: Icons.phone_outlined,
            label: s.contactNumber!,
            onTap: viewModel.callPhone,
          ),
        if (hasWebsite)
          _ContactTile(
            icon: Icons.language_outlined,
            label: s.link!,
            onTap: viewModel.openWebsite,
          ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ContactTile(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Icon(icon, size: 18, color: kcPrimaryColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: globalTextStyle(
                  fontSize: 13,
                  color: kcPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
