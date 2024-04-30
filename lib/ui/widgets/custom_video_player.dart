import 'dart:io';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String? pathh;
  final String? url;

  const CustomVideoPlayer.file({
    super.key,
    required this.pathh,
  }) : url = null;

  const CustomVideoPlayer.network({
    super.key,
    required this.url,
  }) : pathh = null;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  late VideoPlayerController controller;
  late Future<void> futureController;

  initVideo() {
    controller = widget.pathh != null
        ? VideoPlayerController.file(
            File(widget.pathh!),
          )
        : VideoPlayerController.networkUrl(Uri.parse(widget.url!));
    futureController = controller.initialize();
  }

  @override
  void initState() {
    initVideo();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GestureDetector(
              onTap: _playPause, child: VideoPlayer(controller));
        }
      },
    );
  }

  void _playPause() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }
}
