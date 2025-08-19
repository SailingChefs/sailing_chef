import 'package:sailing_chefs/core/imports/core_imports.dart';

class OnboardModel {
  final String image;
  final String title;
  String description;

  OnboardModel({
    required this.image,
    required this.title,
    required this.description,
  });

  Widget getFormattedDescription() {
    final formattedSpans = <InlineSpan>[];

    final parts = description.split('@');

    for (var i = 0; i < parts.length; i++) {
      final part = parts[i];
      if (i % 2 == 0) {
        formattedSpans.add(TextSpan(text: part));
      } else {
        formattedSpans.add(TextSpan(
          text: part,
          style: globalTextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              letterSpacing: -0.3,
              height: 1.5),
        ));
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: globalTextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: kcWhiteColor,
            letterSpacing: -0.3),
        children: formattedSpans,
      ),
    );
  }
}
