import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/settings_viewmodel.dart';

class SettingsListSettingsScreen extends ViewModelWidget<SettingsViewModel> {
  const SettingsListSettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceMedium,
        if (userDetails!.isAdmin) ...[
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
            onTap: () {
              viewModel.goToManageRecipes();
            },
            title: Text(
              'Manage Recipes (Admin)',
              style: globalTextStyle(
                fontSize: 14.0.dg,
                color: kcBlackColor,
                letterSpacing: -0.3,
                // fontWeight: FontWeight.w900,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: kcBlackColor.withOpacity(0.87),
              size: 14.dg,
            ),
          ),
          Divider(
            color: kcBlackColor.withOpacity(0.08),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
            onTap: () {
              viewModel.goToManagePins();
            },
            title: Text(
              'Manage Pins (Admin)',
              style: globalTextStyle(
                fontSize: 14.0.dg,
                color: kcBlackColor,
                letterSpacing: -0.3,
                // fontWeight: FontWeight.w900,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: kcBlackColor.withOpacity(0.87),
              size: 14.dg,
            ),
          ),
          Divider(
            color: kcBlackColor.withOpacity(0.08),
          ),
        ],
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {
            viewModel.getEditProfile();
          },
          title: Text(
            'Edit Profile',
            style: globalTextStyle(
              fontSize: 14.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 14.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
        if (userDetails!.userRole == 'chef') ...[
          SwitchListTile(
            contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
            activeThumbColor: kcPrimaryColor,
            value: viewModel.isAvailable,
            onChanged: viewModel.toggleAvailability,
            title: Text(
              'Open to work',
              style: globalTextStyle(
                fontSize: 14.0.dg,
                color: kcBlackColor,
                letterSpacing: -0.3,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              'Agencies can find your profile when this is on',
              style: globalTextStyle(
                fontSize: 12.0.dg,
                color: kcBlackColor.withOpacity(0.6),
                letterSpacing: -0.3,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Divider(
            color: kcBlackColor.withOpacity(0.08),
          ),
        ],
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {
            viewModel.getToShoppingList();
          },
          title: Text(
            'Shopping List',
            style: globalTextStyle(
              fontSize: 14.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 14.dg,
          ),
        ),
        if (userDetails!.userRole == 'guest')
          Column(
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
                    fontSize: 14.0.dg,
                    color: kcBlackColor,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kcBlackColor.withOpacity(0.87),
                  size: 14.dg,
                ),
              ),
            ],
          )
        else
          Column(
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
                    fontSize: 14.0.dg,
                    color: kcBlackColor,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kcBlackColor.withOpacity(0.87),
                  size: 14.dg,
                ),
              ),
            ],
          ),
        if (userDetails!.userRole == 'culinarySchool')
          Column(
            children: [
              Divider(
                color: kcBlackColor.withOpacity(0.08),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
                onTap: viewModel.getSavedRecipes,
                title: Text(
                  'Saved Recipes',
                  style: globalTextStyle(
                    fontSize: 14.0.dg,
                    color: kcBlackColor,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kcBlackColor.withOpacity(0.87),
                  size: 14.dg,
                ),
              ),
            ],
          )
        else
          Container(),
        if (userDetails!.userRole == 'culinarySchool' || userDetails!.userRole == 'chef')
          Column(
            children: [
              Divider(
                color: kcBlackColor.withOpacity(0.08),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
                onTap: viewModel.goToPrivateRecipes,
                title: Text(
                  'Private Recipes',
                  style: globalTextStyle(
                    fontSize: 14.0.dg,
                    color: kcBlackColor,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kcBlackColor.withOpacity(0.87),
                  size: 14.dg,
                ),
              ),
            ],
          )
        else
          Container(),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: viewModel.getPrivacyPolicy,
          title: Text(
            'Privacy Policy',
            style: globalTextStyle(
              fontSize: 14.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 14.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: viewModel.getTermsConditions,
          title: Text(
            'Terms & Conditions',
            style: globalTextStyle(
              fontSize: 14.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 14.dg,
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
              fontSize: 14.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 14.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.0.dg, right: 20),
          onTap: () {
            viewModel.sendFeedback();
          },
          title: Text(
            'Send Feedback',
            style: globalTextStyle(
              fontSize: 14.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 14.dg,
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
              fontSize: 14.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 14.dg,
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
              fontSize: 14.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: kcBlackColor.withOpacity(0.87),
            size: 14.dg,
          ),
        ),
        Divider(
          color: kcBlackColor.withOpacity(0.08),
        ),
      ],
    );
  }
}
