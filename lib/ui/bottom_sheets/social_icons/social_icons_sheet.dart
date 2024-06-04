import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'social_icons_sheet_model.dart';

class SocialIconsSheet extends StackedView<SocialIconsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const SocialIconsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Share Recipe to Social Media',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            verticalSpaceMedium,
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
                    FlutterRemix.file_copy_2_fill, 'Copy', 5, viewModel),
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
                break;
              case 2:
                viewmodel.shareRecipeToFacebook(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
                break;
              case 3:
                viewmodel.shareRecipeToEmail(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
                break;
              case 4:
                viewmodel.shareRecipeToInstagram(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
                break;
              case 5:
                viewmodel.shareByCopy(request.data as RecipeModel);
                completer!(SheetResponse(confirmed: true));
                break;
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
