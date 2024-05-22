import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/search/search_viewmodel.dart';
import 'package:sailing_chefs/ui/views/search/widgets/explore_all_buttons.dart';

class ChefScreen extends ViewModelWidget<SearchViewModel> {
  final List<UserModel> chef;
  const ChefScreen({super.key, required this.chef});
  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return viewModel.searchControllerChef.text.isNotEmpty
        ? Column(
            children: [
              Column(
                children: [
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return ShrinkWrappingViewport(
                      offset: ViewportOffset.zero(),
                      axisDirection: AxisDirection.down,
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 18.0,
                            childAspectRatio: 7 / 9,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final UserModel che =
                                  viewModel.searchUser(chef).elementAt(index);
                              return GestureDetector(
                                  onTap: () {
                                    viewModel.toChefProfile(che);
                                  },
                                  child: Container(
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                      color: kcwhitecolor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.r),
                                            topRight: Radius.circular(20.r),
                                          ),
                                          child: che.displayPicture! == ''
                                              ? Image.asset(
                                                  'assets/images/misc/blank_image.png',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  che.displayPicture!,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                        )),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.dg),
                                          child: Text(
                                            capitalizeEachWord(
                                                che.displayName!),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),

                                )
                              );
                              },
                              childCount: viewModel.searchUser(chef).length >= 4 ? 4 : viewModel.searchUser(chef).length ,
                            ),


                          ),
                        

                      ],
                    );
                  }),
                  verticalSpace(90),
                  ExploreAllButtonSearch(
                    text: 'Discover more Chefs',
                    onTap: () => viewModel.toAllChefsScreen(chef),
                  ),
                ],
              ),
            ],
          )
        : chef.isEmpty
            ? SizedBox(
                height: 500.h,
                child: Center(
                    child: Text(
                  'No Chef Found',
                  style:
                      globalTextStyle(fontSize: 15.sp, color: kcPrimaryColor),
                )))
            : Column(
                children: [
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return ShrinkWrappingViewport(
                      offset: ViewportOffset.zero(),
                      axisDirection: AxisDirection.down,
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 18.0,
                            childAspectRatio: 8 / 10,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  viewModel.toChefProfile(chef);
                                },
                                child: Container(
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    color: kcwhitecolor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          topRight: Radius.circular(20.r),
                                        ),
                                        child: chef[index].displayPicture! == ''
                                            ? Image.asset(
                                                'assets/images/misc/blank_image.png',
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                chef[index].displayPicture!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                      )),
                                      Padding(
                                        padding: EdgeInsets.all(8.0.dg),
                                        child: Text(
                                          capitalizeEachWord(
                                              chef[index].displayName!),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                );

                              },
                              childCount: chef.length >= 4 ? 4 : chef.length,
                            ),

                          ),
                      
                      ],
                    );
                  }),
                  verticalSpace(90),
                  ExploreAllButtonSearch(
                    text: 'Discover more Chefs',
                    onTap: () => viewModel.toAllChefsScreen(chef),
                  ),
                  verticalSpace(30),
                ],
              );
  }
}
