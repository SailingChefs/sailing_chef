import 'package:flutter/widgets.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/all_chefs/search_bar.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

import 'all_chefs_viewmodel.dart';

class AllChefsView extends StackedView<AllChefsViewModel> {
  final List<UserModel> chefList;
  const AllChefsView({Key? key, required this.chefList}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllChefsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kcBackgroundColor,
          appBar: AppBar(
              backgroundColor: kcBackgroundColor,
              elevation: 0,
              title: Text(
                'Meet Your Chefs',
                style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor),
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BackArrowWidget(
                  onTap: viewModel.toHomeView,
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                verticalSpaceSmall,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: SearchBarAllChefsScreen(),
                ),
                verticalSpace(13),
                Expanded(
                  child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                    return CustomScrollView(
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 190 / 270,
                            mainAxisExtent: 270,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  viewModel.toChefProfile(chefList[index]);
                                },
                                child: Container(
                                  width: 190.w,
                                  decoration: BoxDecoration(
                                    color: kcwhitecolor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: kcBlackColor.withOpacity(0.08),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12.r),
                                          topRight: Radius.circular(12.r),
                                        ),
                                        child: chefList[index].displayPicture == ''
                                            ? Image.asset(
                                                'assets/images/misc/blank_image.png',
                                                fit: BoxFit.cover,
                                                height: 200,
                                              )
                                            : Image.network(
                                                chefList[index].displayPicture!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                      )),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 13.0.dg, top: 10),
                                        child: Text(
                                          capitalizeEachWord(
                                              chefList[index].displayName!),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 13.0.dg, bottom: 10),
                                        child: Text(
                                          capitalizeEachWord(
                                            ("${chefList[index].recipeCount}  Dishes"),
                                          ),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: kcBlackColor.withOpacity(0.6),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: chefList.length,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          )),
    );
  }

  @override
  AllChefsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllChefsViewModel();
}
