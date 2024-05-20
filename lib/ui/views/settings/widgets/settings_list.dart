import 'dart:developer';

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/settings_viewmodel.dart';

class SettingsListSettingsScreen extends ViewModelWidget<SettingsViewModel> {
  const SettingsListSettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) {
    log(userDetails!.userRole!);
    return Column(
      children: [
        verticalSpaceMedium,
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {
            viewModel.getEditProfile();
          },
          title: Text(
            'Edit Profile',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 16.5.dg,
          ),
        ),
        userDetails!.userRole == 'guest'
            ? Column(
                children: [
                  Divider(
                    color: kcBlackColor.withOpacity(0.08),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
                    onTap: viewModel.getBecomeChef,
                    title: Text(
                      'Become a Chef',
                      style: globalTextStyle(
                          fontSize: 16.0.dg,
                          color: kcBlackColor,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kcBlackColor.withOpacity(0.87),
                      size: 16.5.dg,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Divider(
                    color: kcBlackColor.withOpacity(0.08),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
                    onTap: viewModel.getAllDrafts,
                    title: Text(
                      'View all drafts',
                      style: globalTextStyle(
                          fontSize: 16.0.dg,
                          color: kcBlackColor,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kcBlackColor.withOpacity(0.87),
                      size: 16.5.dg,
                    ),
                  ),
                ],
              ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: viewModel.getTerms,
          title: Text(
            'Terms & Policies',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 16.5.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: viewModel.getBlockAcc,
          title: Text(
            'Blocked Accounts',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 16.5.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
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
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 16.5.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: viewModel.deleteAccount,
          title: Text(
            'Delete Account',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 16.5.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: viewModel.signOutUser,
          title: Text(
            'Sign Out',
            style: globalTextStyle(
                fontSize: 16.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 16.5.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
      ],
    );
  }
}
