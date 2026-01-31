import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/terms_conditions/terms_conditions_viewmodel.dart';

class TermsConditionsView extends StackedView<TermsConditionsViewModel> {
  const TermsConditionsView({super.key});

  static const String _markdownContent = '''
# **TERMS & CONDITIONS**

**Sailing-Chefs (trading as The Sailing Chefs)**

**Last Updated:** 26 - 01 - 2026

## **1. ACCEPTANCE OF TERMS**

By accessing or using **The Sailing Chefs** mobile application (“the App”), you agree to be
legally bound by these Terms & Conditions (“Terms”).

If you do not agree, you must not use the App.

## **2. OPERATOR INFORMATION**

The App is owned and operated by:

**Sailing-Chefs**, trading as **The Sailing Chefs**
Salt Rock, South Africa

## **3. DESCRIPTION OF THE SERVICE**

The App provides a community-driven platform allowing users to:

- Upload and share recipes and photos
- Post reviews and comments
- Submit location pin drops and business information
- Interact with other users globally

## **4. ELIGIBILITY & USER ACCOUNTS**

- You must be at least **16 years old**
- You are responsible for safeguarding your login credentials
- You agree to provide accurate information
- We may suspend or terminate accounts at our discretion

## **5. USER-GENERATED CONTENT**

## **5.1 Ownership**

You retain ownership of content you submit.

## **5.2 License to Sailing-Chefs**

By posting content, you grant Sailing-Chefs a **worldwide, perpetual, irrevocable,
non-exclusive, royalty-free license** to use, host, display, reproduce, distribute, and
promote such content within the App and related marketing.

## **5.3 Responsibility**

You are solely responsible for your content and confirm that:

- You own or have rights to it
- It does not violate any laws or third-party rights

## **6. CONTENT MODERATION**

We reserve the right (but have no obligation) to:

- Monitor, remove, edit, or restrict content
- Suspend or terminate accounts
- Act without notice or explanation

## **7. LOCATION & BUSINESS INFORMATION DISCLAIMER**

- Location pins and business details are user-submitted
- We do not verify accuracy, safety, legality, or availability
- We do not endorse any business or location
- Use of location-based information is entirely at your own risk

## **8. PROHIBITED CONDUCT**

Users may not:

- Post unlawful, misleading, or harmful content
- Harass or impersonate others
- Upload spam or unauthorized advertising
- Attempt to access systems without authorization
- Scrape or exploit App data

## **9. NO PROFESSIONAL ADVICE**

All recipes, reviews, comments, and content are provided for informational purposes only.
Sailing-Chefs does **not** provide:

- Culinary
- Nutritional
- Medical
- Safety
- Business or professional advice


You assume all risks associated with preparing recipes or relying on content.

## **10. IN-APP PURCHASES & SUBSCRIPTIONS**

The App may offer paid features in the future.

- Payments are handled by third-party app stores
- Pricing and billing are subject to their terms
- We are not responsible for payment disputes handled by app stores

## **11. INTELLECTUAL PROPERTY**

All App software, branding, trademarks, and design elements belong to Sailing-Chefs.
Unauthorized use is strictly prohibited.

## **12. DISCLAIMER OF WARRANTIES**

The App is provided **“as is”** and **“as available”**.

We make no warranties regarding:

- Accuracy of content
- Availability or uptime
- User behavior or interactions

## **13. LIMITATION OF LIABILITY**

To the maximum extent permitted by law, Sailing-Chefs shall not be liable for:

- Personal injury
- Food-related incidents
- Business losses
- Data loss
- Indirect or consequential damages

## **14. INDEMNITY**

You agree to indemnify and hold harmless Sailing-Chefs from any claims, damages, losses,
or legal costs arising from:

- Your use of the App
- Your content
- Your violation of these Terms

## **15. FORCE MAJEURE**

We are not liable for failure or delay caused by events beyond our reasonable control,
including natural disasters, strikes, internet failures, or government actions.

## **16. TERMINATION**

We may terminate or suspend access at any time without notice.
All provisions intended to survive termination shall remain in effect.

## **17. GOVERNING LAW**

These Terms are governed by the laws of the **Republic of South Africa**.
All disputes fall under South African courts.

## **18. CHANGES TO TERMS**

We may update these Terms at any time.
Continued use of the App constitutes acceptance.

## **19. CONTACT INFORMATION**

📧thesailingchefs@gmail.com
📍 South Africa
                  ''';

  @override
  Widget builder(
    BuildContext context,
    TermsConditionsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          title: Text(
            'Terms & Conditions',
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
  TermsConditionsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TermsConditionsViewModel();
}
