import 'package:url_launcher/url_launcher.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class SupplierProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  String get businessName =>
      userDetails?.businessName ?? userDetails?.displayName ?? 'My Store';
  String get category => userDetails?.businessCategory ?? '';
  String get description =>
      userDetails?.businessDescription ?? userDetails?.bio ?? '';
  String get contact => userDetails?.businessContact ?? '';
  String get website => userDetails?.businessWebsite ?? userDetails?.link ?? '';
  String get email => userDetails?.email ?? '';

  Future<void> getDirections() async {
    final location = userDetails?.supplierLocation;
    if (location == null) {
      showToast(message: 'Location not set');
      return;
    }
    final uri = Uri.parse(
      'https://maps.google.com/?q=${location.latitude},${location.longitude}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      showToast(message: 'Could not open maps');
    }
  }

  Future<void> callPhone() async {
    if (contact.isEmpty) {
      showToast(message: 'No phone number set');
      return;
    }
    final uri = Uri(scheme: 'tel', path: contact);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> openWebsite() async {
    if (website.isEmpty) {
      showToast(message: 'No website set');
      return;
    }
    final raw = website.startsWith('http') ? website : 'https://$website';
    final uri = Uri.parse(raw);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void toMessages() {
    _navigationService.navigateToChatListView();
  }
}
