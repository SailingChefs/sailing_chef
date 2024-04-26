import 'dart:io';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String? pathh;
  final bool? isclicked;

  const CustomVideoPlayer({
    Key? key,
    this.pathh,  this.isclicked, 
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  late VideoPlayerController controller;
  late Future<void> futureController;

  initVideo() {
    controller = VideoPlayerController.file(File(widget.pathh!));
    futureController = controller.initialize().then((_) {
      if (widget.isclicked!) {
        controller.play();
      } else {
        controller.pause();
      }
    });
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
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return VideoPlayer(controller);
        }
      },
    );
  }
}