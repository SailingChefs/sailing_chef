import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:viewModel.isBusy ? const Center(child: CircularProgressIndicator()) : Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child :Center(child: Text('Hi, ${viewModel.user.name}! Welcome to Sailing Chefs as a ${viewModel.user.role}', style: const TextStyle(fontSize: 20.0),)),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();@override
void onViewModelReady(HomeViewModel viewModel) {
  viewModel.onViewModelReady();
  super.onViewModelReady(viewModel);
}
}
