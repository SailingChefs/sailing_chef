import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'video_player_viewmodel.dart';

class VideoPlayerView extends StackedView<VideoPlayerViewModel> {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    VideoPlayerViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  VideoPlayerViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      VideoPlayerViewModel();
}
