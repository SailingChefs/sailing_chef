import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/draftgrid.dart';

import 'view_all_drafts_viewmodel.dart';

class ViewAllDraftsView extends StackedView<ViewAllDraftsViewModel> {
  const ViewAllDraftsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ViewAllDraftsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
          backgroundColor: kcBackgroundColor,
          elevation: 0,
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BackArrowWidget(onTap: viewModel.settingsView))),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [
            verticalSpace(41),
            Center(
              child: Text('Drafts',
                  style: globalTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor)),
            ),
            verticalSpaceSmall,
            viewModel.isBusy ? const CircularProgressIndicator(color: kcWhiteColor,) :
            viewModel.draft.isEmpty
                ? const Center(child: Text('No Drafts Found'))
                : SizedBox(
                    height: screenHeight(context) * 0.802,
                    child: GridView.builder(
                      itemCount: viewModel.draft.length,
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
                                  .where((element) => element.contains('.jpg'))
                                  .first,
                          dishName: viewModel.draft[index].title,
                        );
                      },
                    ),
                  )
          ],
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
