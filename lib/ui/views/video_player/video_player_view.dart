import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/views/video_player/video_player_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VideoPlayerView extends StackedView<VideoPlayerViewModel> {
  const VideoPlayerView({super.key});

  @override
  Widget builder(
    BuildContext context,
    VideoPlayerViewModel viewModel,
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
  VideoPlayerViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      VideoPlayerViewModel();
}
