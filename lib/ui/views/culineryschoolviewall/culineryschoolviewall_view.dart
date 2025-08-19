import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/culineryschoolviewall_viewmodel.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/shimmer.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/widgets/listview.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class CulineryschoolviewallView
    extends StackedView<CulineryschoolviewallViewModel> {
  const CulineryschoolviewallView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CulineryschoolviewallViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcWhiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Explore Culinary\nSchools',
          textAlign: TextAlign.center,
          style: globalTextStyle(
              letterSpacing: -0.5,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: kcBlackColor),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackArrowWidget(
            onTap: viewModel.toHomeView,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: viewModel.isBusy
            ? const ShimmerLoaderCulinarySchool()
            : const ListViewCulinaryChool(),
      ),
    );
  }

  @override
  void onViewModelReady(CulineryschoolviewallViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  CulineryschoolviewallViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CulineryschoolviewallViewModel();
}
