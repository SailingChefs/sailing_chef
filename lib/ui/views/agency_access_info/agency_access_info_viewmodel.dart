import 'package:url_launcher/url_launcher.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class AgencyAccessInfoViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void back() => _navigationService.back();

  Future<void> getInTouch() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'thesailingchefs@gmail.com',
      query: 'subject=Agency%20access%20enquiry',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
