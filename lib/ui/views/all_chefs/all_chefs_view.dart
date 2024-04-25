import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

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
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 0,
              title: Text(
                'All Chefs',
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
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 18.0,
                      childAspectRatio: 7.4 / 9,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            viewModel.toChefProfile(chefList[index]);
                          },
                          child: Container(
                            width: 160.w,

                            // height: containerHeight.h,

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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                  child: chefList[index].displayPicture == ''
                                      ? Image.asset(
                                          'assets/images/misc/blank_image.png',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          chefList[index].displayPicture!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                )),
                                Padding(
                                  padding: EdgeInsets.all(8.0.dg),
                                  child: Text(
                                    capitalizeEachWord(
                                        chefList[index].displayName!),
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
                      childCount: chefList.length,
                    ),
                  ),
                ],
              );
            }),
          )),
    );
  }

  @override
  AllChefsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllChefsViewModel();
}
