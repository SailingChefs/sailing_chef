import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/ui/views/startup/startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

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
                      verticalSpaceLarge,
                      verticalSpaceSmall,
                      SvgPicture.asset(
                        'assets/images/logo/SAILING.svg',
                      ),
                      verticalSpaceTiny,
                      SvgPicture.asset(
                        'assets/images/logo/CHEFS.svg',
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
