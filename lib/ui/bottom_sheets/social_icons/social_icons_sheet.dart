import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/social_icons/social_icons_sheet_model.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SocialIconsSheet extends StackedView<SocialIconsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const SocialIconsSheet({
    required this.completer, required this.request, super.key,
  });
  @override
  Widget builder(
    BuildContext context,
    SocialIconsSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Share this recipe',
              style: globalTextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: kcBlackColor),
            ),
            verticalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSocialIcon(
                    FlutterRemix.whatsapp_fill, 'WhatsApp', 1, viewModel),
                _buildSocialIcon(
                    FlutterRemix.facebook_fill, 'Facebook', 2, viewModel),
                _buildSocialIcon(Icons.email, 'Email', 3, viewModel),
                _buildSocialIcon(
                    FlutterRemix.instagram_fill, 'Instagram', 4, viewModel),
                _buildSocialIcon(
                    FlutterRemix.snapchat_fill, 'S.C Users', 5, viewModel),
                _buildSocialIcon(
                    FlutterRemix.file_copy_2_fill, 'Copy', 6, viewModel),
              ],
            ),
            verticalSpaceMedium,
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(
      IconData icon, String label, int num, SocialIconsSheetModel viewmodel) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            switch (num) {
              case 1:
                viewmodel.shareRecipeToWhatsapp(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
              case 2:
                viewmodel.shareRecipeToFacebook(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
              case 3:
                viewmodel.shareRecipeToEmail(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
              case 4:
                viewmodel.shareRecipeToInstagram(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
              case 5:
                viewmodel.sharetoSailingCheffUser(request.data as RecipeModel);
              case 6:
                viewmodel.shareByCopy(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
              default:
            }
          },
          icon: Icon(
            icon,
            color: kcPrimaryColor,
            size: 30,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: kcMediumGrey),
        ),
      ],
    );
  }

  @override
  SocialIconsSheetModel viewModelBuilder(BuildContext context) =>
      SocialIconsSheetModel();
}
