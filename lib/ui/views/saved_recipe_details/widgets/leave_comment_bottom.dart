// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class LeaveComment extends StatelessWidget {
  const LeaveComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5.0, top: 20, bottom: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  backgroundColor: kcPrimaryColor,
                ),
                onPressed: () {},
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: kcwhitecolor,
                  size: 18,
                ),
              ),
              Expanded(
                child: RoundedTransparentTextField(
                  labelText: 'Leave a comment',
                  textColor: kcBlackColor.withOpacity(0.5),
                ),
              )
            ],
          ),
          verticalSpaceTiny,
          // RecipeDetailsList(),
        ],
      ),
    );
  }
}
