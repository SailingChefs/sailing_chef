// ignore_for_file: sort_child_properties_last

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/top_bar.dart';
import 'package:sailing_chefs/ui/views/settings/widgets/top_bar.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:sailing_chefs/ui/widgets/followinglist.dart';
import 'package:stacked/stacked.dart';

import 'following_list_viewmodel.dart';

class FollowingListView extends StackedView<FollowingListViewModel> {
  const FollowingListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FollowingListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          capitalizeEachWord('Chef Name'),
          style: globalTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: kcBlackColor),
        ),
        centerTitle: true,
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => viewModel.popBack(),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10.0.dg),
            height: 25.h,
            width: 25.w,
            decoration: const BoxDecoration(
              color: kcVeryLightGrey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: kcBlackColor,
              size: 20.sp,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          Container(
            height: 50.h,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    viewModel.updateFollowing();
                    viewModel.updateFollower();
                    log('following');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: viewModel.isFollowing == true
                              ? Colors.black
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        '98 Followers',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.updateFollowing();
                    viewModel.updateFollower();
                    log('Followers');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: viewModel.isFollowing == false
                              ? Colors.black
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        '108 Following',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpaceTiny,
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  color: kcWhiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: kcBlackColor.withOpacity(0.5),
                        size: 22.dg,
                      ),
                      horizontalSpaceSmall,
                      Text(
                        'Search',
                        style: globalTextStyle(
                          fontSize: 16.sp,
                          color: kcBlackColor.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          verticalSpaceTiny,
          FollowingFollowerList(),
        ],
      ),
    );
  }

  @override
  FollowingListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FollowingListViewModel();
}
