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
    List<InlineSpan> formattedSpans = [];

    List<String> parts = description.split('@');

    for (int i = 0; i < parts.length; i++) {
      String part = parts[i];
      if (i % 2 == 0) {
        formattedSpans.add(TextSpan(text: part));
      } else {
        formattedSpans.add(TextSpan(
          text: part,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      
      text: TextSpan(
        style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,color: kcWhiteColor,fontFamily: 'Inter'),
        children: formattedSpans,
      ),
    );
  }
}
