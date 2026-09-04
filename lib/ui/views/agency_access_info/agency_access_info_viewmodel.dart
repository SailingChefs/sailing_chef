import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:url_launcher/url_launcher.dart';

class AgencyAccessInfoViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  static const String enquiryEmail = 'thesailingchefs@gmail.com';
  static const String enquirySubject = 'Agency access enquiry';

  Future<void> getInTouch() async {
    final uri = Uri(
      scheme: 'mailto',
      path: enquiryEmail,
      query: 'subject=${Uri.encodeComponent(enquirySubject)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void goBack() {
    _navigationService.back<dynamic>();
  }
}
