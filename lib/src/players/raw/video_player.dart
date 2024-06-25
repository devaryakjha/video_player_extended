import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_extended/src/common/index.dart';

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

  Widget buildChild(RawVideoPlayerController controller) {
    return AspectRatio(
      key: controller.key,
      aspectRatio: controller.aspectRatio,
      child: VideoPlayer(
        controller.videoPlayerController,
      ),
    );
  }

  Widget buildThumbnail(ThumbnailConfig? config) {
    if (config == null) {
      return const SizedBox.shrink();
    }

    final child = switch (config.type) {
      ThumbnailType.asset => Image.asset(
          config.src!,
          width: config.width,
          height: config.height,
          fit: BoxFit.cover,
        ),
      ThumbnailType.network => Image.network(
          config.src!,
          width: config.width,
          height: config.height,
          fit: BoxFit.cover,
        ),
      ThumbnailType.file => Image.file(
          File(config.src!),
          width: config.width,
          height: config.height,
          fit: BoxFit.cover,
        ),
      ThumbnailType.custom => config.custom!,
    };

    if (config.aspectRatio != null) {
      return AspectRatio(
        key: ValueKey(config.src),
        aspectRatio: config.aspectRatio!,
        child: child,
      );
    } else {
      return KeyedSubtree(key: ValueKey(config.src), child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerControllerProvider(
      controller: controller,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: controller.value.isInitialised
            ? buildChild(controller)
            : buildThumbnail(controller.value.thumbnail),
      ),
    );
  }
}
