import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../common/controller_provider.dart';
import 'video_player_controller.dart';

class RawVideoPlayer extends StatefulWidget {
  const RawVideoPlayer(
    this.controller, {
    super.key,
  });

  /// The [RawVideoPlayerController] responsible for the video being rendered in
  /// this widget.
  final RawVideoPlayerController controller;

  @override
  State<RawVideoPlayer> createState() => RawVideoPlayerState();
}

class RawVideoPlayerState extends State<RawVideoPlayer> {
  RawVideoPlayerController get controller => widget.controller;

  Future<void> listener() async {}

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerControllerProvider(
      controller: controller,
      child: AspectRatio(
        aspectRatio: controller.aspectRatio,
        child: VideoPlayer(
          controller.videoPlayerController,
        ),
      ),
    );
  }
}
