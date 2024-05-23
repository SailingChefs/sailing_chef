import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/index/widgets/shimmer_chef.dart';
import 'package:sailing_chefs/ui/widgets/custom_textbtn.dart';

class ChefListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const ChefListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return ViewModelBuilder<IndexViewModel>.reactive(
        viewModelBuilder: () => IndexViewModel(),
        onModelReady: (model) => model.getChefs(),
        builder: (context, model, child) {
          return StreamBuilder<void>(
            stream: viewModel.chefService.chefInitt(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ShimmerChef();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return !snapshot.hasData
                    ? Text(
                        'No Chef Found',
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    : Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Meet your Chef',
                                style: globalTextStyle(
                                  fontSize: 16.sp,
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w600,
                                  color: kcBlackColor,
                                ),
                              ),
                              CustomTextButton(
                                onPressed: viewModel.toAllChefsView,
                                buttonText: 'View all',
                                textColor: kclightgreencolor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.27.h,
                            width: double.maxFinite,
                            child: ListView.builder(
                              itemCount: model.data!.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final chef = model.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    viewModel.toChefProfile(chef);
                                  },
                                  child: Container(
                                    width: 160.w,
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
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.r),
                                            topRight: Radius.circular(20.r),
                                          ),
                                          child: model.data![index]
                                                      .displayPicture ==
                                                  ''
                                              ? Image.asset(
                                                  'assets/images/misc/blank_image.png',
                                                  fit: BoxFit.cover,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                                  .height *
                                                              0.25.h -
                                                          56.h,
                                                )
                                              : Image.network(
                                                  model.data![index]
                                                      .displayPicture!,
                                                  fit: BoxFit.cover,
                                                  width: double.maxFinite,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                                  .height *
                                                              0.25.h -
                                                          56.h,
                                                ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 12.h),
                                          child: Text(
                                            model.data![index].displayName!,
                                            style: globalTextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kcBlackColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
              }
            },
          );
        });
  }
}
