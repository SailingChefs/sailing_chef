import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'recipe_list_page_viewmodel.dart';

class RecipeListPageView extends StackedView<RecipeListPageViewModel> {
  final bool isFromProfileView;
  const RecipeListPageView({
    Key? key,
    required this.isFromProfileView,
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
              onTap: () => viewModel.toHomeView(isFromProfileView),
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
                color: kcWhiteColor,
              ))
            : ListView.builder(
                itemCount: viewModel.recipes!.length,
                itemBuilder: (BuildContext context, int index) {
                  final RecipeModel recipe = viewModel.recipes![index];
                  return Container(
                    width: double.infinity,
                    height: 335.h,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
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
                                    recipe.coverImage[0],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10.dg,
                              left: 10.dg,
                              child: Container(
                                  width: 95.w,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black54.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30.0.r),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
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
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpaceSmall,
                              Text(
                                recipe.title,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      topRight: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(50.0),
                                      bottomRight: Radius.circular(50.0),
                                    ),
                                    child: Image.network(
                                      userDetails!.displayPicture!,
                                      width: 35.w,
                                      height: 35.h,
                                      fit: BoxFit.cover,
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
                      ],
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
