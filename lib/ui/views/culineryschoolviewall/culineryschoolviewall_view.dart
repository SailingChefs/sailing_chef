import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/shimmer.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/widgets/listview.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:stacked/stacked.dart';

import 'culineryschoolviewall_viewmodel.dart';

class CulineryschoolviewallView
    extends StackedView<CulineryschoolviewallViewModel> {
  const CulineryschoolviewallView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CulineryschoolviewallViewModel viewModel,
    Widget? child,
  ) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

       appBar: AppBar(
        elevation: 0,
        title: Text(
          'Explore Culinary\nSchools',
          textAlign: TextAlign.center,
          style: globalTextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kcBlackColor),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackArrowWidget(
            onTap: viewModel.toHomeView,
          ),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: viewModel.isBusy ? const  ShimmerLoaderCulinarySchool() :const ListViewCulinaryChool() ,

      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const ListViewCulinaryChool(),

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
