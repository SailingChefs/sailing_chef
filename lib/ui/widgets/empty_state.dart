import 'package:sailing_chefs/core/imports/core_imports.dart';

class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: kcPrimaryColor.withOpacity(0.25),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: globalTextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: kcBlackColor.withOpacity(0.45),
                letterSpacing: -0.4,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: globalTextStyle(
                  fontSize: 13.sp,
                  color: kcBlackColor.withOpacity(0.3),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
