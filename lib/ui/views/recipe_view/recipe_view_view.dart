import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'recipe_view_viewmodel.dart';

class RecipeViewView extends StackedView<RecipeViewViewModel> {
  const RecipeViewView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RecipeViewViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/background/burger.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 227,
          child: Container(
            width: double.infinity,
            height: screenHeight(context),
            decoration: BoxDecoration(
              color: kcwhitecolor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    verticalSpaceTiny,
                    Text(
                      'Healthy Taco Salad',
                      style: globalTextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: kcBlackColor),
                    ),
                    Container(
                      width: 95,
                      height: 45,
                      padding: const EdgeInsets.all(10.0),
                      child: const Row(
                        children: [
                          Icon(
                            FlutterRemix.time_line,
                            size: 16,
                            color: kcWhiteColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '20 mins',
                            style:
                                TextStyle(fontSize: 12.0, color: kcWhiteColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  RecipeViewViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeViewViewModel();
}
