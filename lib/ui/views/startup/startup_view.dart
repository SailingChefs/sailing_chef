import 'package:flutter/scheduler.dart';

import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background/background.png',
                fit: BoxFit.fill,
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 200,
              left: 35,
              child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        'assets/images/logo/SAILING.png',
                      ),
                      verticalSpaceTiny,
                      Image.asset(
                        'assets/images/logo/CHEFS.png',
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
