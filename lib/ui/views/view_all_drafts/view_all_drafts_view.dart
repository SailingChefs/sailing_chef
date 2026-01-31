import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/view_all_drafts/view_all_drafts_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/draftgrid.dart';

class ViewAllDraftsView extends StackedView<ViewAllDraftsViewModel> {
  const ViewAllDraftsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ViewAllDraftsViewModel viewModel,
    Widget? child,
  ) {
    return Material(
      elevation: 10,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kcBackgroundColor,
        appBar: AppBar(
          backgroundColor: kcBackgroundColor,
          title: Text(
            'Drafts',
            style: globalTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: kcBlackColor),
          ),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: viewModel.back,
              child: Container(
                alignment: Alignment.center,
                height: 26.h,
                width: 26.w,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: kcBlackColor,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            children: [
              // verticalSpace(41),

              verticalSpaceSmall,
              if (viewModel.isBusy && viewModel.draft.isEmpty)
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: kcPrimaryColor,
                    ),
                  ),
                )
              else
                viewModel.draft.isEmpty
                    ? SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'No Draft Recipes Yet!',
                            style: globalTextStyle(
                              fontSize: 14,
                              color: kcPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: screenHeight(context) * 0.802,
                        child: GridView.builder(
                          itemCount: viewModel.draft.length,
                          // physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 18.0,
                            childAspectRatio: 7.4 / 9,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return DraftGridTile(
                              recipeId: viewModel.draft[index].docId!,
                              onTap: () {
                                viewModel.toDishCreateScreen(index);
                              },
                              foodImagePath: viewModel
                                      .draft[index].coverImage.isEmpty
                                  ? 'https://st3.depositphotos.com/23594922/31822/v/450/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg'
                                  : viewModel.draft[index].coverImage
                                      .where((element) =>
                                          element.isFirebaseImageUrl)
                                      .first,
                              dishName: viewModel.draft[index].title,
                            );
                          },
                        ),
                      )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(ViewAllDraftsViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.onViewModelReady();
  }

  @override
  ViewAllDraftsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ViewAllDraftsViewModel();
}
