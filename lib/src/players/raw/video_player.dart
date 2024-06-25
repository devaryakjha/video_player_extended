import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_extended/src/common/index.dart';
import 'package:video_player_extended/src/common/widgets/controls_overlay.dart';

import 'raw_thumbnail_builder.dart';
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

  Future<void> listener() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
    controller.init();
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  Widget buildChild(RawVideoPlayerController controller) {
    return AspectRatio(
      key: controller.key,
      aspectRatio: controller.aspectRatio,
      child: ControlsOverlay(
        player: VideoPlayer(controller.videoPlayerController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerControllerProvider(
      controller: controller as PlayerController<PlayerValue>,
      child: Builder(builder: (context) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: controller.value.isInitialised
              ? buildChild(controller)
              : RawThumbnailBuilder(config: controller.value.thumbnail),
        );
      }),
    );
  }
}
