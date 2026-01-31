import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/privacy_policy/privacy_policy_viewmodel.dart';

class PrivacyPolicyView extends StackedView<PrivacyPolicyViewModel> {
  const PrivacyPolicyView({super.key});

  static const String _markdownContent = '''
# **PRIVACY POLICY**

**Sailing-Chefs (trading as The Sailing Chefs)**

**Last Updated:** 26 - 01 - 2026

## **1. INTRODUCTION**

Sailing-Chefs (“we”, “us”, “our”), trading as **The Sailing Chefs**, is based in Salt Rock, South
Africa and operates a mobile application and related services (collectively, the “App”).

We are committed to protecting your personal information in accordance with the **Protection
of Personal Information Act, 2013 (POPIA)** and applicable international privacy standards.

By using the App, you agree to the collection and use of information in accordance with this
Privacy Policy.

## **2. INFORMATION WE COLLECT**

### **2.1 Personal Information You Provide**
- Email address and password when registering
- Name or display name (optional)
- User-generated content including:
    - Recipes
    - Photos
    - Reviews and comments
    - Location pin drops and business information
  - Communications sent to us

### **2.2 Automatically Collected Information**
  - IP address
  - Device type, operating system, and identifiers
  - App usage data and logs
  - Approximate location data (when enabled)

## **3. LOCATION INFORMATION**

The App allows users to submit and view location-based content (“pin drops”).
  - Location data is provided voluntarily by users
  - We do not guarantee accuracy of any location or business information
  - You may disable location permissions at any time via your device settings

## **4. HOW WE USE YOUR INFORMATION**

We use personal information to:
  - Create and manage user accounts
  - Enable App functionality and community interaction
  - Display user-generated content
  - Improve and develop features
  - Maintain security and prevent misuse
  - Communicate updates and service-related notices
  - Comply with legal obligations

## **5. SHARING AND DISCLOSURE**

We do **not** sell personal information.

We may share data:
  - With service providers (hosting, maintenance, backups)
  - If required by law or legal process
  - To protect our rights, users, or the public
  - In the event of a merger, sale, or transfer of assets
  - User-generated content may be **publicly visible** within the App.

## **6. DATA RETENTION**

We retain personal data only as long as necessary for:
  - App operation
  - Legal and regulatory compliance
  - Dispute resolution
  - Security purposes
Users may request account deletion by contacting us.

## **7. DATA SECURITY**

We implement reasonable administrative, technical, and physical safeguards.
However, no system is completely secure, and use of the App is at your own risk.

## 8. **YOUR RIGHTS**

You have the right to:
  - Access your personal information
  - Request correction or deletion
  - Withdraw consent
  - Object to processing
  - Lodge a complaint with the Information Regulator (South Africa)

## 9. **INTERNATIONAL USERS**

Your data may be processed outside South Africa. By using the App, you consent to
cross-border data transfers.

## **10. CHILDREN’S PRIVACY**

The App is not intended for users under 16 years of age.
We do not knowingly collect data from minors.

## **11. CHANGES TO THIS POLICY**

We may update this Privacy Policy at any time.
Continued use of the App constitutes acceptance of the revised policy.

## **12. CONTACT DETAILS**

📧thesailingchefs@gmail.com
📍 South Africa
                  ''';

  @override
  Widget builder(
    BuildContext context,
    PrivacyPolicyViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: Text(
            'Privacy Policy',
            style: globalTextStyle(
              fontSize: 16.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: viewModel.getBack,
              child: Container(
                alignment: Alignment.center,
                height: 26.h,
                width: 26.w,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: kcBlackColor,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: MarkdownBody(
              data: _markdownContent,
              styleSheet: MarkdownStyleSheet(
                // Customize the horizontal rule (---) here
                horizontalRuleDecoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 2.0, // Thickness of the line (increase for bolder)
                      color: Colors.grey[
                          400]!, // Color – adjust to match your theme (e.g., Colors.black for darker)
                    ),
                  ),
                ),
                // Optional: Add space around the divider if needed
                blockSpacing: 1.0,
                h1Padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                h2Padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                h3Padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                pPadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  PrivacyPolicyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrivacyPolicyViewModel();
}
