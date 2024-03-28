import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/settings_viewmodel.dart';

class SettingsListSettingsScreen extends ViewModelWidget<SettingsViewModel> {
  const SettingsListSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceMedium,
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {},
          title: Text(
            'Edit Profile',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor,
            size: 14,
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {},
          title: Text(
            'Become a Chef',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor,
            size: 14,
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {},
          title: Text(
            'Terms & Conditions',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor,
            size: 14,
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {},
          title: Text(
            'Blocked Accounts',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor,
            size: 14,
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {},
          title: Text(
            'Send Feedback',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor,
            size: 14,
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {},
          title: Text(
            'Delete Account',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor,
            size: 14,
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {},
          title: Text(
            'Logout',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor,
            size: 14,
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {
            viewModel.getToMap();
          },
          title: Text(
            'Show Map',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor,
            size: 14,
          ),
        ),
      ],
    );
  }
}
