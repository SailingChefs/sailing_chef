import 'package:sailing_chefs/core/imports/core_imports.dart';

class OnboardModel {
  final String image;
  final String title;
  String description;

  OnboardModel(
    {required this.image, required this.title, required this.description});  // Method to process description and apply custom formatting
  Widget getFormattedDescription() {
    List<InlineSpan> formattedSpans = [];

    RegExp regExp = RegExp(r'\[bold\](.*?)\[/bold\]');
    List<String> parts = description.split(regExp);

    for (int i = 0; i < parts.length; i++) {
      String part = parts[i];
      if (i % 2 == 0) {
        // Regular text part
        formattedSpans.add(TextSpan(text: part));
      } else {
        String boldText = regExp.firstMatch(part)?.group(1) ?? '';
        formattedSpans.add(TextSpan(
          text: boldText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      }
    }

    return RichText(
      text: TextSpan(children: formattedSpans),
    );
  }


}




