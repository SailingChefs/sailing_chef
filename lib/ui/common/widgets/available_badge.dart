import 'package:sailing_chefs/core/imports/core_imports.dart';

/// Small green pill shown next to a chef's name when they have turned on the
/// "Open to work" toggle in profile settings (UserModel.isAvailable).
class AvailableBadge extends StatelessWidget {
  const AvailableBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.dg, vertical: 3.dg),
      decoration: BoxDecoration(
        color: kcAvailableGreen.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20.dg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.dg,
            height: 6.dg,
            decoration: const BoxDecoration(
              color: kcAvailableGreen,
              shape: BoxShape.circle,
            ),
          ),
          horizontalSpaceTiny,
          Text(
            'Available',
            style: globalTextStyle(
              fontSize: 11.sp,
              letterSpacing: -0.2,
              fontWeight: FontWeight.w600,
              color: kcAvailableGreen,
            ),
          ),
        ],
      ),
    );
  }
}
