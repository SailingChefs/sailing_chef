import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/views/comingsoon/comingsoon_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ComingsoonView extends StackedView<ComingsoonViewModel> {
  const ComingsoonView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ComingsoonViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  ComingsoonViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ComingsoonViewModel();
}
