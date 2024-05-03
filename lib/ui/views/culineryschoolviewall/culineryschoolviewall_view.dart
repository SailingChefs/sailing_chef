import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/widgets/listview.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        height: MediaQuery.of(context).size.height*0.9,
        width: MediaQuery.of(context).size.width*0.9,
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
