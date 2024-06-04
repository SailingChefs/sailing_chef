import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIconsSheetModel extends BaseViewModel {
  // Future<void> shareRecipeToWhatsapp(RecipeModel recipe) async {
  //   final dynamicLinkParams = DynamicLinkParameters(
  //     link: Uri.parse('https://example.com/recipe/${recipe.title}'),
  //     uriPrefix: 'https://sailingchefs.page.link',
  //     androidParameters:
  //         const AndroidParameters(packageName: 'com.stackwise.sailingChefs'),
  //     iosParameters: const IOSParameters(bundleId: 'com.example.app.ios'),
  //   );

  //   final dynamicLink =
  //       await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  //   log(dynamicLink.toString());
  //   final whatsappUrl =
  //       'https://wa.me/?text=${Uri.encodeComponent(dynamicLink.shortUrl.toString())}';
  //   await launchUrl(Uri.parse(whatsappUrl),
  //       mode: LaunchMode.externalApplication);
  // }



Future<void> shareRecipeToWhatsapp(RecipeModel recipe) async {
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse('https://sailingchefs.page.link/recipe?recipe=${recipe.docId}'),
    uriPrefix: 'https://sailingchefs.page.link',
    androidParameters: const AndroidParameters(packageName: 'com.stackwise.sailingChefs'),
    iosParameters: const IOSParameters(bundleId: 'com.stackwise.sailingChefs'),
  );

  final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

  final whatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(dynamicLink.toString())}';
  await launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
}

  Future<void> shareRecipeToEmail(RecipeModel recipe) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse('https://sailingchefs.page.link?recipe=${recipe.docId}'),
      uriPrefix: 'https://sailingchefs.page.link',
      androidParameters:
          const AndroidParameters(packageName: 'com.stackwise.sailingChefs'),
      iosParameters: const IOSParameters(bundleId: 'com.stackwise.sailingChefs'),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    final emailUrl =
        'mailto:?subject=Recipe&body=${Uri.encodeComponent(dynamicLink.toString())}';
    await launchUrl(Uri.parse(emailUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> shareRecipeToFacebook(RecipeModel recipe) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse('https://sailingchefs.page.link?recipe=${recipe.docId}'),
      uriPrefix: 'https://sailingchefs.page.link',
      androidParameters:
          const AndroidParameters(packageName: 'com.stackwise.sailingChefs'),
      iosParameters: const IOSParameters(bundleId: 'com.stackwise.sailingChefs'),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    await Clipboard.setData(
        ClipboardData(text: dynamicLink.toString()));
    const facebookUrl = 'http://m.me/';
    await launchUrl(Uri.parse(facebookUrl),
        mode: LaunchMode.externalApplication);
  }

    Future<void> shareByCopy(RecipeModel recipe) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse('https://sailingchefs.page.link?recipe=${recipe.docId}'),
      uriPrefix: 'https://sailingchefs.page.link',
      androidParameters:
          const AndroidParameters(packageName: 'com.stackwise.sailingChefs'),
      iosParameters: const IOSParameters(bundleId: 'com.stackwise.sailingChefs'),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    await Clipboard.setData(
        ClipboardData(text: dynamicLink.toString()));
    showToast(message: 'Link Copied to Clipboard');
  }


  Future<void> shareRecipeToInstagram(RecipeModel recipe) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse('https://sailingchefs.page.link?recipe=${recipe.docId}'),
      uriPrefix: 'https://sailingchefs.page.link',
      androidParameters:
          const AndroidParameters(packageName: 'com.stackwise.sailingChefs'),
      iosParameters: const IOSParameters(bundleId: 'com.stackwise.sailingChefs'),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    await Clipboard.setData(
        ClipboardData(text: dynamicLink.toString()));
    const instagramUrl = 'https://www.instagram.com/direct/new/';
    await launchUrl(Uri.parse(instagramUrl),
        mode: LaunchMode.externalApplication);
  }
}
