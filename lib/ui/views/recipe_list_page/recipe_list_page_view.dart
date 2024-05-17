import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'recipe_list_page_viewmodel.dart';

class RecipeListPageView extends StackedView<RecipeListPageViewModel> {
 
  const RecipeListPageView({
    Key? key,
   
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RecipeListPageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BackArrowWidget(
              onTap:viewModel.toHomeView,
            ),
          ),
          title: Text(
            'Recipes',
            style: globalTextStyle(
                fontSize: 25.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(
                color: kcPrimaryColor,
              ))
            : ListView.builder(
                itemCount: viewModel.recipes!.length,
                itemBuilder: (BuildContext context, int index) {
                  final RecipeModel recipe = viewModel.recipes![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: kcWhiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: kclightgreycolor.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                            )
                          ]),
                      height: 400.h,
                      // padding:
                      //     const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 225.0.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      recipe.coverImage
                                          .where((element) =>
                                              element.contains('.jpg'))
                                          .first,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10.dg,
                                left: 10.dg,
                                child: Container(
                                    height: 45.h,
                                    decoration: BoxDecoration(
                                      color: Colors.black54.withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.circular(30.0.r),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FlutterRemix.time_line,
                                          size: 16,
                                          color: kcWhiteColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          recipe.prepTime,
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: kcWhiteColor),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          // const SizedBox(width: 16.0),
                          verticalSpaceSmall,
                          SizedBox(
                            width: 150.w,
                            height: recipe.title.length > 20 ? 40.h : 50.h,
                            child: Text(
                              capitalizeEachWord(recipe.title),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          // const SizedBox(height: 4.0),
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: kcVeryLightGrey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: userDetails!.displayPicture!.isEmpty
                                        ? const AssetImage(
                                            'assets/images/misc/blank_image.png')
                                        : NetworkImage(
                                                userDetails!.displayPicture!)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                userDetails!.displayName!,
                                style: TextStyle(
                                    fontSize: 15.0.sp,
                                    color: kcBlackColor.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }

  @override
  void onViewModelReady(RecipeListPageViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  RecipeListPageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeListPageViewModel();
}
