import 'package:sailing_chefs/core/imports/core_imports.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: kcPrimaryColor.withOpacity(0.35)),
          const SizedBox(height: 14),
          Text(
            title,
            style: globalTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kcBlackColor.withOpacity(0.55),
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: globalTextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: kcBlackColor.withOpacity(0.35),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
